import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/constants/app_constants.dart';
import 'package:chattrix_ui/core/services/token_cache_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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

    if (kDebugMode) {
      print('🔧 [JWT] AuthInterceptor initialized');
      print('🔧 [JWT] Refresh endpoint: ${ApiConstants.refresh}');
    }
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await tokenCacheService.getAccessToken();

    if (accessToken != null) {
      options.headers[AppConstants.authorization] = '${AppConstants.bearer} $accessToken';

      if (kDebugMode && !options.path.contains('/typing/')) {
        print('🔑 [JWT] Token added to: ${options.method} ${options.path}');
      }
    } else if (kDebugMode) {
      print('⚠️  [JWT] No token for: ${options.method} ${options.path}');
    }

    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (kDebugMode) {
        print('🔴 [JWT] 401 Unauthorized: ${err.requestOptions.method} ${err.requestOptions.path}');
      }

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
        if (kDebugMode) {
          print('⚠️  [JWT] Skipping refresh for auth endpoint');
        }
        return handler.next(err);
      }

      // Prevent multiple simultaneous refresh attempts
      if (_isRefreshing) {
        if (kDebugMode) {
          print('⏳ [JWT] Refresh already in progress, waiting...');
        }
        // Wait a bit and retry with potentially new token
        await Future.delayed(const Duration(milliseconds: 500));
        final currentToken = await tokenCacheService.getAccessToken();
        if (currentToken != null &&
            currentToken !=
                err.requestOptions.headers[AppConstants.authorization]?.toString().replaceFirst(
                  '${AppConstants.bearer} ',
                  '',
                )) {
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

        if (kDebugMode) {
          print('🔄 [JWT] Attempting token refresh...');
        }

        // Try to refresh token
        final newAccessToken = await _refreshAccessToken();

        if (newAccessToken != null) {
          if (kDebugMode) {
            print('✅ [JWT] Token refreshed, retrying request...');
          }

          // Update request with new token
          err.requestOptions.headers[AppConstants.authorization] = '${AppConstants.bearer} $newAccessToken';

          // Retry original request
          try {
            final response = await dio.fetch(err.requestOptions);

            if (kDebugMode) {
              print('✅ [JWT] Retry successful: ${response.statusCode}');
            }

            return handler.resolve(response);
          } catch (retryError) {
            if (kDebugMode) {
              print('❌ [JWT] Retry failed: $retryError');
            }
            // If retry fails, clear tokens and logout
            await _clearTokens();
            return handler.next(err);
          }
        } else {
          if (kDebugMode) {
            print('❌ [JWT] Token refresh failed, user will be logged out');
          }
          // Token refresh failed, return 401 error to trigger logout in app
          return handler.next(err);
        }
      } catch (refreshError) {
        if (kDebugMode) {
          print('❌ [JWT] Refresh exception: $refreshError');
        }
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
        if (kDebugMode) {
          print('❌ [JWT] No refresh token found in cache/storage');
        }
        await _clearTokens();
        return null;
      }

      if (kDebugMode) {
        print('🔄 [JWT] Calling refresh API...');
        print('🔄 [JWT] Refresh token: ${refreshToken.substring(0, 20)}...');
      }

      // Use separate Dio instance to avoid interceptor
      final response = await _refreshDio.post(ApiConstants.refresh, data: {'refreshToken': refreshToken});

      if (kDebugMode) {
        print('🔄 [JWT] Refresh response status: ${response.statusCode}');
      }

      if (response.statusCode == 200) {
        try {
          final data = response.data['data'];
          final newAccessToken = data['accessToken'] as String;
          final newRefreshToken = data['refreshToken'] as String;

          if (kDebugMode) {
            print('✅ [JWT] New tokens received');
            print('✅ [JWT] New access token: ${newAccessToken.substring(0, 20)}...');
          }

          // Update cache and storage with new tokens
          await tokenCacheService.setTokens(newAccessToken, newRefreshToken);

          return newAccessToken;
        } catch (parseError) {
          if (kDebugMode) {
            print('❌ [JWT] Failed to parse refresh response: $parseError');
            print('❌ [JWT] Response data: ${response.data}');
          }
          await _clearTokens();
          return null;
        }
      } else {
        if (kDebugMode) {
          print('❌ [JWT] Refresh failed with status: ${response.statusCode}');
          print('❌ [JWT] Response: ${response.data}');
        }
        await _clearTokens();
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ [JWT] Refresh error: $e');
      }
      await _clearTokens();
      return null;
    }
  }

  Future<void> _clearTokens() async {
    if (kDebugMode) {
      print('🗑️  [JWT] Clearing tokens from cache and storage');
    }
    await tokenCacheService.clearTokens();
  }
}
