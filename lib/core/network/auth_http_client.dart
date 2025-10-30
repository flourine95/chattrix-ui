import 'dart:async';

import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthDioClient {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  Completer<void>? _refreshLock;

  AuthDioClient({required this.dio, required this.secureStorage}) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = await secureStorage.read(
            key: ApiConstants.accessTokenKey,
          );
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }

          handler.next(options);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (error, handler) async {
          final statusCode = error.response?.statusCode;

          if (statusCode == 401) {
            final url = error.requestOptions.uri.toString();

            final shouldRefresh =
                !url.contains('/login') &&
                !url.contains('/register') &&
                !url.contains('/refresh') &&
                !url.contains('/verify-email') &&
                !url.contains('/forgot-password') &&
                !url.contains('/reset-password');

            if (shouldRefresh) {
              while (_refreshLock != null) {
                await _refreshLock!.future;
              }

              _refreshLock = Completer<void>();

              try {
                final newAccessToken = await _refreshAccessToken();

                if (newAccessToken != null) {
                  error.requestOptions.headers['Authorization'] =
                      'Bearer $newAccessToken';

                  final response = await dio.fetch(error.requestOptions);

                  _refreshLock?.complete();
                  _refreshLock = null;

                  return handler.resolve(response);
                }
              } catch (e) {
                await _clearTokens();
              } finally {
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
        await _clearTokens();
        return null;
      }

      final refreshDio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          contentType: ApiConstants.contentTypeJson,
          validateStatus: (status) => status! < 500,
        ),
      );

      final response = await refreshDio.post(
        '${ApiConstants.baseUrl}/${ApiConstants.refresh}',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];

        final newAccessToken = data['accessToken'] as String;
        final newRefreshToken = data['refreshToken'] as String;

        await secureStorage.write(
          key: ApiConstants.accessTokenKey,
          value: newAccessToken,
        );
        await secureStorage.write(
          key: ApiConstants.refreshTokenKey,
          value: newRefreshToken,
        );

        return newAccessToken;
      } else {
        await _clearTokens();
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> _clearTokens() async {
    await secureStorage.delete(key: ApiConstants.accessTokenKey);
    await secureStorage.delete(key: ApiConstants.refreshTokenKey);
  }
}
