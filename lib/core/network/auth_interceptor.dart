import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/constants/app_constants.dart';
import 'package:chattrix_ui/core/services/token_cache_service.dart';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends QueuedInterceptor {
  final Dio dio;
  final TokenCacheService tokenCacheService;

  late final Dio _refreshDio;
  bool _isRefreshing = false;

  AuthInterceptor({required this.dio, required this.tokenCacheService}) {
    _refreshDio = Dio(
      BaseOptions(
        contentType: AppConstants.contentTypeJson,
        // Allow all status codes for refresh endpoint to handle manually
        validateStatus: (status) => true,
      ),
    );
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await tokenCacheService.getAccessToken();

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
      final isVerifyEndpoint = err.requestOptions.path.contains('/auth/verify-email');
      final isResendEndpoint = err.requestOptions.path.contains('/auth/resend-verification');
      final isForgotPasswordEndpoint = err.requestOptions.path.contains('/auth/forgot-password');
      final isResetPasswordEndpoint = err.requestOptions.path.contains('/auth/reset-password');

      // Don't try to refresh token for auth endpoints
      if (isRefreshEndpoint ||
          isLoginEndpoint ||
          isRegisterEndpoint ||
          isVerifyEndpoint ||
          isResendEndpoint ||
          isForgotPasswordEndpoint ||
          isResetPasswordEndpoint) {
        return handler.next(err);
      }

      // Prevent multiple simultaneous refresh attempts
      if (_isRefreshing) {
        AppLogger.debug('🔐 Token refresh already in progress, waiting...', tag: 'AuthInterceptor');
        // Wait a bit and retry with potentially new token
        await Future.delayed(const Duration(milliseconds: 500));
        final currentToken = await tokenCacheService.getAccessToken();
        if (currentToken != null &&
            currentToken !=
                err.requestOptions.headers[AppConstants.authorization]?.toString().replaceFirst(
                  '${AppConstants.bearer} ',
                  '',
                )) {
          AppLogger.debug('🔐 Token was refreshed, retrying request', tag: 'AuthInterceptor');
          // Token was refreshed by another request, retry with new token
          err.requestOptions.headers[AppConstants.authorization] = '${AppConstants.bearer} $currentToken';
          try {
            final response = await dio.fetch(err.requestOptions);
            return handler.resolve(response);
          } catch (e) {
            // If still fails, let it through
            return handler.next(err);
          }
        }
        return handler.next(err);
      }

      try {
        _isRefreshing = true;
        AppLogger.debug('🔐 Attempting to refresh access token...', tag: 'AuthInterceptor');

        // Try to refresh token
        final newAccessToken = await _refreshAccessToken();

        if (newAccessToken != null) {
          AppLogger.debug('🔐 Token refresh successful, retrying original request', tag: 'AuthInterceptor');
          // Update request with new token
          err.requestOptions.headers[AppConstants.authorization] = '${AppConstants.bearer} $newAccessToken';

          // Retry original request
          try {
            final response = await dio.fetch(err.requestOptions);
            return handler.resolve(response);
          } catch (retryError) {
            AppLogger.error('🔐 Retry failed after token refresh', tag: 'AuthInterceptor');
            // If retry fails, clear tokens and logout
            await _clearTokens();
            return handler.next(err);
          }
        } else {
          AppLogger.warning('🔐 Token refresh failed, user needs to re-login', tag: 'AuthInterceptor');
          // Token refresh failed, return 401 error to trigger logout in app
          return handler.next(err);
        }
      } catch (refreshError) {
        AppLogger.error('🔐 Token refresh exception: $refreshError', tag: 'AuthInterceptor');
        // Token refresh failed, clear tokens and return error
        await _clearTokens();
        return handler.next(err);
      } finally {
        _isRefreshing = false;
      }
    }

    handler.next(err);
  }

  Future<String?> _refreshAccessToken() async {
    try {
      final refreshToken = await tokenCacheService.getRefreshToken();

      if (refreshToken == null) {
        await _clearTokens();
        return null;
      }

      // Use separate Dio instance to avoid interceptor
      final response = await _refreshDio.post(ApiConstants.refresh, data: {'refreshToken': refreshToken});

      if (response.statusCode == 200) {
        try {
          final data = response.data['data'];
          final newAccessToken = data['accessToken'] as String;
          final newRefreshToken = data['refreshToken'] as String;

          // Update cache and storage with new tokens
          await tokenCacheService.setTokens(newAccessToken, newRefreshToken);

          return newAccessToken;
        } catch (parseError) {
          await _clearTokens();
          return null;
        }
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
    await tokenCacheService.clearTokens();
  }
}
