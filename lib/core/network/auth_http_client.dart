import 'dart:async';

import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Dio Client với tự động refresh token khi access token hết hạn
class AuthDioClient {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  // Lock để tránh nhiều request cùng refresh token
  Completer<void>? _refreshLock;

  AuthDioClient({required this.dio, required this.secureStorage}) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    // Request Interceptor - Thêm access token vào header
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 📊 Log call API
          debugPrint('🌐 API Call: ${options.method} ${options.uri}');

          // Thêm access token vào header nếu có
          final accessToken = await secureStorage.read(
            key: ApiConstants.accessTokenKey,
          );
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }

          handler.next(options);
        },
        onResponse: (response, handler) {
          // 📊 Log response status
          debugPrint(
            '✅ Response: ${response.statusCode} - ${response.requestOptions.method} ${response.requestOptions.uri}',
          );
          handler.next(response);
        },
        onError: (error, handler) async {
          // 📊 Log error
          final statusCode = error.response?.statusCode;
          debugPrint(
            '❌ Error: $statusCode - ${error.requestOptions.method} ${error.requestOptions.uri}',
          );

          // Nếu nhận được 401 (Unauthorized), thử refresh token
          if (statusCode == 401) {
            final url = error.requestOptions.uri.toString();

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
                  // Retry request với token mới
                  error.requestOptions.headers['Authorization'] =
                      'Bearer $newAccessToken';

                  final response = await dio.fetch(error.requestOptions);
                  debugPrint(
                    '✅ Retry: ${response.statusCode} - ${error.requestOptions.method} ${error.requestOptions.uri}',
                  );

                  _refreshLock?.complete();
                  _refreshLock = null;

                  return handler.resolve(response);
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

          handler.next(error);
        },
      ),
    );
  }

  Future<String?> _refreshAccessToken() async {
    try {
      final refreshToken = await secureStorage.read(
        key: ApiConstants.refreshTokenKey,
      );

      if (refreshToken == null) {
        debugPrint('❌ Refresh token not found in storage');
        await _clearTokens();
        return null;
      }

      debugPrint(
        '🔑 Refreshing with token: ${refreshToken.substring(0, 20)}...',
      );

      // Tạo Dio instance mới để tránh interceptor loop
      final refreshDio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          contentType: ApiConstants.contentTypeJson,
          validateStatus: (status) => status! < 500, // Accept 4xx responses
        ),
      );

      final response = await refreshDio.post(
        '${ApiConstants.baseUrl}/${ApiConstants.refresh}',
        data: {'refreshToken': refreshToken},
      );

      debugPrint('🔄 Refresh response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = response.data['data'];

        final newAccessToken = data['accessToken'] as String;
        final newRefreshToken = data['refreshToken'] as String;

        // Lưu tokens mới (BOTH tokens được làm mới - Sliding Session)
        await secureStorage.write(
          key: ApiConstants.accessTokenKey,
          value: newAccessToken,
        );
        await secureStorage.write(
          key: ApiConstants.refreshTokenKey,
          value: newRefreshToken,
        );

        debugPrint('✅ Token refreshed successfully');
        return newAccessToken;
      } else if (response.statusCode == 401) {
        // Refresh token hết hạn hoặc không hợp lệ
        debugPrint('❌ Refresh token expired or invalid');
        await _clearTokens();
        return null;
      } else {
        debugPrint('❌ Refresh failed with status: ${response.statusCode}');
        debugPrint('Response: ${response.data}');
        return null;
      }
    } catch (e) {
      debugPrint('❌ Exception during refresh: $e');
      if (e is DioException) {
        debugPrint('DioException type: ${e.type}');
        debugPrint('DioException message: ${e.message}');
        debugPrint('DioException response: ${e.response?.data}');
      }
      return null;
    }
  }

  /// Xóa tất cả tokens
  Future<void> _clearTokens() async {
    await secureStorage.delete(key: ApiConstants.accessTokenKey);
    await secureStorage.delete(key: ApiConstants.refreshTokenKey);
  }
}
