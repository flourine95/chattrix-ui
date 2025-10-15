import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

/// HTTP Client với tự động refresh token khi access token hết hạn
class AuthHttpClient extends http.BaseClient {
  final http.Client _inner;
  final FlutterSecureStorage _secureStorage;

  // Lock để tránh nhiều request cùng refresh token
  Completer<void>? _refreshLock;

  AuthHttpClient({
    required http.Client client,
    required FlutterSecureStorage secureStorage,
  }) : _inner = client,
       _secureStorage = secureStorage;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final url = request.url.toString();

    // 📊 Log call API
    debugPrint('🌐 API Call: ${request.method} $url');

    // Thêm access token vào header nếu có
    final accessToken = await _secureStorage.read(
      key: ApiConstants.accessTokenKey,
    );
    if (accessToken != null && !request.headers.containsKey('Authorization')) {
      request.headers['Authorization'] = 'Bearer $accessToken';
    }

    // Gửi request
    var response = await _inner.send(request);

    // 📊 Log response status
    final statusEmoji = response.statusCode >= 200 && response.statusCode < 300
        ? '✅'
        : response.statusCode == 401
        ? '⚠️'
        : '❌';
    debugPrint(
      '$statusEmoji Response: ${response.statusCode} - ${request.method} $url',
    );

    // Nếu nhận được 401 (Unauthorized), thử refresh token
    if (response.statusCode == 401) {
      // Chỉ refresh nếu không phải là request login/register/refresh
      final shouldRefresh =
          !url.contains('/login') &&
          !url.contains('/register') &&
          !url.contains('/refresh') &&
          !url.contains('/verify-email') &&
          !url.contains('/forgot-password') &&
          !url.contains('/reset-password');

      if (shouldRefresh) {
        // Đợi nếu đang có refresh khác đang chạy
        while (_refreshLock != null) {
          await _refreshLock!.future;
        }

        // Tạo lock mới
        _refreshLock = Completer<void>();

        try {
          // Thử refresh token
          debugPrint('🔄 Auto-refreshing token...');
          final newAccessToken = await _refreshAccessToken();

          if (newAccessToken != null) {
            // Tạo request mới với token mới
            final newRequest = _copyRequest(request);
            newRequest.headers['Authorization'] = 'Bearer $newAccessToken';

            // Retry request
            response = await _inner.send(newRequest);
            debugPrint(
              '✅ Retry: ${response.statusCode} - ${request.method} $url',
            );
          }
        } catch (e) {
          debugPrint('❌ Auto-refresh failed: $e');
          await _clearTokens();
        } finally {
          // Giải phóng lock
          _refreshLock?.complete();
          _refreshLock = null;
        }
      }
    }

    return response;
  }

  Future<String?> _refreshAccessToken() async {
    try {
      final refreshToken = await _secureStorage.read(
        key: ApiConstants.refreshTokenKey,
      );

      if (refreshToken == null) {
        return null;
      }

      final response = await _inner.post(
        Uri.parse('${ApiConstants.baseUrl}/${ApiConstants.refresh}'),
        headers: {'Content-Type': ApiConstants.contentTypeJson},
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final data = jsonResponse['data'];

        final newAccessToken = data['accessToken'] as String;
        final newRefreshToken = data['refreshToken'] as String;

        // Lưu tokens mới (BOTH tokens được làm mới - Sliding Session)
        await _secureStorage.write(
          key: ApiConstants.accessTokenKey,
          value: newAccessToken,
        );
        await _secureStorage.write(
          key: ApiConstants.refreshTokenKey,
          value: newRefreshToken,
        );

        return newAccessToken;
      } else if (response.statusCode == 401) {
        // Refresh token hết hạn hoặc không hợp lệ
        await _clearTokens();
        return null;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Xóa tất cả tokens
  Future<void> _clearTokens() async {
    await _secureStorage.delete(key: ApiConstants.accessTokenKey);
    await _secureStorage.delete(key: ApiConstants.refreshTokenKey);
  }

  /// Copy request để retry
  http.BaseRequest _copyRequest(http.BaseRequest request) {
    http.BaseRequest newRequest;

    if (request is http.Request) {
      newRequest = http.Request(request.method, request.url)
        ..bodyBytes = request.bodyBytes;
    } else if (request is http.MultipartRequest) {
      newRequest = http.MultipartRequest(request.method, request.url)
        ..fields.addAll(request.fields)
        ..files.addAll(request.files);
    } else if (request is http.StreamedRequest) {
      throw Exception('StreamedRequest cannot be retried');
    } else {
      throw Exception('Unknown request type');
    }

    newRequest
      ..persistentConnection = request.persistentConnection
      ..followRedirects = request.followRedirects
      ..maxRedirects = request.maxRedirects
      ..headers.addAll(request.headers);

    return newRequest;
  }
}
