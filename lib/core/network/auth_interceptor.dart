import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/constants/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends QueuedInterceptor {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  late final Dio _refreshDio;

  AuthInterceptor({required this.dio, required this.secureStorage}) {
    _refreshDio = Dio(
      BaseOptions(
        contentType: AppConstants.contentTypeJson,
        validateStatus: (status) => status != null && status < 500,
      ),
    );
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await secureStorage.read(key: AppConstants.accessTokenKey);

    if (accessToken != null) {
      options.headers[AppConstants.authorization] = '${AppConstants.bearer} $accessToken';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final isRefreshEndpoint = err.requestOptions.path.contains('/auth/refresh');
      final isLoginEndpoint = err.requestOptions.path.contains('/auth/login');
      final isRegisterEndpoint = err.requestOptions.path.contains('/auth/register');

      if (isRefreshEndpoint || isLoginEndpoint || isRegisterEndpoint) {
        return handler.next(err);
      }

      try {
        // Try to refresh token
        final newAccessToken = await _refreshAccessToken();

        if (newAccessToken != null) {
          // Update request with new token
          err.requestOptions.headers[AppConstants.authorization] = '${AppConstants.bearer} $newAccessToken';

          // Retry original request
          final response = await dio.fetch(err.requestOptions);
          return handler.resolve(response);
        }
      } catch (refreshError) {
        // Token refresh failed, clear tokens
        await _clearTokens();
        return handler.next(err);
      }
    }

    handler.next(err);
  }

  Future<String?> _refreshAccessToken() async {
    try {
      final refreshToken = await secureStorage.read(key: AppConstants.refreshTokenKey);

      if (refreshToken == null) {
        await _clearTokens();
        return null;
      }

      // Use separate Dio instance to avoid interceptor
      final response = await _refreshDio.post(ApiConstants.refresh, data: {'refreshToken': refreshToken});

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final newAccessToken = data['accessToken'] as String;
        final newRefreshToken = data['refreshToken'] as String;

        // Save new tokens
        await secureStorage.write(key: AppConstants.accessTokenKey, value: newAccessToken);
        await secureStorage.write(key: AppConstants.refreshTokenKey, value: newRefreshToken);

        return newAccessToken;
      } else {
        await _clearTokens();
        return null;
      }
    } catch (e) {
      await _clearTokens();
      return null;
    }
  }

  Future<void> _clearTokens() async {
    await secureStorage.delete(key: AppConstants.accessTokenKey);
    await secureStorage.delete(key: AppConstants.refreshTokenKey);
  }
}
