/// COMPLETE INTEGRATION EXAMPLE: ApiResponse + Failures + Auth Feature
///
/// This shows the complete flow from API to UI with proper error handling

import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/network/models/api_response.dart';
import 'package:chattrix_ui/core/network/models/api_response_extensions.dart';
import 'package:chattrix_ui/features/auth/data/models/auth_tokens_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

/// ============================================================================
/// LAYER 1: DATASOURCE - Handles API calls with ApiResponse
/// ============================================================================

class ExampleAuthDatasource {
  final Dio dio;

  ExampleAuthDatasource(this.dio);

  /// Login method using ApiResponse
  Future<AuthTokensModel> login(String username, String password) async {
    try {
      final response = await dio.post('/v1/auth/login', data: {
        'usernameOrEmail': username,
        'password': password,
      });

      // Parse response as ApiResponse<AuthTokensModel>
      final apiResponse = ApiResponse<AuthTokensModel>.fromJson(
        response.data,
        (data) => AuthTokensModel.fromJson(data as Map<String, dynamic>),
      );

      // Check if successful
      if (apiResponse.isSuccess) {
        return apiResponse.data!;
      } else {
        // Convert ApiResponse error to ServerException
        throw ServerException(
          message: apiResponse.message ?? 'Login failed',
          errorCode: apiResponse.code,
        );
      }
    } on DioException catch (e) {
      // Handle network errors
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw NetworkException(message: 'Network connection failed');
      }

      // Try to parse error response as ApiResponse
      if (e.response != null) {
        final apiResponse = ApiResponse<AuthTokensModel>.fromJson(
          e.response!.data,
          (data) => AuthTokensModel.fromJson(data as Map<String, dynamic>),
        );

        throw ServerException(
          message: apiResponse.message ?? 'Server error',
          errorCode: apiResponse.code,
          statusCode: e.response!.statusCode,
        );
      }

      throw NetworkException();
    }
  }
}

/// ============================================================================
/// LAYER 2: REPOSITORY - Converts Exceptions to Failures
/// ============================================================================

class ExampleAuthRepository {
  final ExampleAuthDatasource datasource;

  ExampleAuthRepository(this.datasource);

  /// Login method returning Either<Failure, AuthTokens>
  Future<Either<Failure, AuthTokens>> login(String username, String password) async {
    try {
      final tokensModel = await datasource.login(username, password);

      // Success - convert model to entity
      final tokens = tokensModel.toEntity();
      return Right(tokens as AuthTokens);

    } on ServerException catch (e) {
      // Map ServerException to appropriate Failure
      return Left(_mapServerExceptionToFailure(e));

    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));

    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  /// Map ServerException to Failure based on error code
  Failure _mapServerExceptionToFailure(ServerException exception) {
    final errorCode = exception.errorCode;

    // Map by error code first (more specific)
    switch (errorCode) {
      case 'VALIDATION_ERROR':
        return Failure.validation(message: exception.message);
      case 'UNAUTHORIZED':
      case 'INVALID_CREDENTIALS':
        return Failure.unauthorized(
          message: exception.message,
          errorCode: errorCode,
        );
      case 'RATE_LIMIT_EXCEEDED':
        return Failure.rateLimitExceeded(message: exception.message);
      case 'USER_NOT_FOUND':
        return Failure.notFound(
          message: exception.message,
          errorCode: errorCode,
        );
      default:
        // Fallback to HTTP status code
        switch (exception.statusCode) {
          case 400:
            return Failure.badRequest(
              message: exception.message,
              errorCode: errorCode,
            );
          case 401:
            return Failure.unauthorized(
              message: exception.message,
              errorCode: errorCode,
            );
          case 404:
            return Failure.notFound(
              message: exception.message,
              errorCode: errorCode,
            );
          case 409:
            return Failure.conflict(
              message: exception.message,
              errorCode: errorCode,
            );
          case 429:
            return Failure.rateLimitExceeded(message: exception.message);
          default:
            return Failure.server(
              message: exception.message,
              errorCode: errorCode,
            );
        }
    }
  }
}

/// ============================================================================
/// ALTERNATIVE: Use ApiResponseExtension for easier conversion
/// ============================================================================

class SimplifiedAuthDatasource {
  final Dio dio;

  SimplifiedAuthDatasource(this.dio);

  /// Login with direct Failure conversion
  Future<Either<Failure, AuthTokensModel>> loginWithFailure(
    String username,
    String password,
  ) async {
    try {
      final response = await dio.post('/v1/auth/login', data: {
        'usernameOrEmail': username,
        'password': password,
      });

      // Parse as ApiResponse
      final apiResponse = ApiResponse<AuthTokensModel>.fromJson(
        response.data,
        (data) => AuthTokensModel.fromJson(data as Map<String, dynamic>),
      );

      // Use extension to convert directly to Either
      if (apiResponse.isSuccess) {
        return Right(apiResponse.data!);
      } else {
        // Convert ApiResponse error to Failure using extension
        return Left(apiResponse.toFailure());
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return Left(Failure.network(message: 'Connection failed'));
      }

      if (e.response != null) {
        final apiResponse = ApiResponse<AuthTokensModel>.fromJson(
          e.response!.data,
          (data) => AuthTokensModel.fromJson(data as Map<String, dynamic>),
        );
        return Left(apiResponse.toFailure());
      }

      return Left(Failure.network(message: e.message ?? 'Network error'));
    }
  }
}

/// ============================================================================
/// LAYER 3: UI - Handle Failure and show to user
/// ============================================================================

class ExampleLoginScreen {
  final ExampleAuthRepository repository;

  ExampleLoginScreen(this.repository);

  Future<void> handleLogin(String username, String password) async {
    final result = await repository.login(username, password);

    result.fold(
      (failure) {
        // Handle different failure types
        failure.when(
          // Validation errors - show field-specific errors
          validation: (message, errors) {
            if (errors != null) {
              for (var error in errors) {
                print('${error.field}: ${error.message}');
                // Show error on specific field
                // usernameField.error = error.message
              }
            } else {
              // Generic validation error
              showToast(message);
            }
          },

          // Unauthorized - show "Wrong password" message
          unauthorized: (message, errorCode) {
            showToast('Invalid username or password');
          },

          // Network error - show "Check connection" message
          network: (message) {
            showToast('Please check your internet connection');
          },

          // Rate limit - show wait message
          rateLimitExceeded: (message) {
            showToast('Too many attempts. Please try again later');
          },

          // Other errors - show generic message
          server: (message, errorCode) {
            showToast('Server error. Please try again');
          },

          // Default handler
          badRequest: (message, errorCode) => showToast(message),
          forbidden: (message, errorCode) => showToast(message),
          notFound: (message, errorCode) => showToast(message),
          conflict: (message, errorCode) => showToast(message),
          unknown: (message) => showToast('An error occurred'),
          permission: (message) => showToast(message),
          agoraEngine: (message, code) => showToast(message),
          tokenExpired: (message) => showToast(message),
          channelJoin: (message) => showToast(message),
          webSocketNotConnected: (message) => showToast(message),
          webSocketSendFailed: (message) => showToast(message),
          callNotFound: (message) => showToast(message),
          callAlreadyActive: (message) => showToast(message),
        );
      },
      (tokens) {
        // Success - navigate to home
        print('Login successful!');
        print('Access Token: ${tokens.accessToken}');
        // Navigate to home screen
      },
    );
  }

  void showToast(String message) {
    print('🔔 Toast: $message');
    // Show actual toast/snackbar in UI
  }
}

/// ============================================================================
/// BENEFITS SUMMARY
/// ============================================================================

/// ✅ CLEAN SEPARATION OF CONCERNS
///    - Datasource: Handles API + ApiResponse parsing
///    - Repository: Converts Exceptions to Failures
///    - UI: Handles Failures and shows to user

/// ✅ TYPE-SAFE ERROR HANDLING
///    - Compile-time checking with sealed Failure class
///    - Exhaustive pattern matching with .when()
///    - No runtime surprises

/// ✅ CONSISTENT ERROR FLOW
///    - All errors go through same pipeline
///    - Easy to debug and maintain
///    - Predictable behavior

/// ✅ REUSABLE ACROSS FEATURES
///    - ApiResponse: Shared in core/network
///    - Failures: Shared in core/errors
///    - Same pattern for Auth, Chat, Profile, etc.

/// ============================================================================
/// USAGE IN ACTUAL AUTH FEATURE
/// ============================================================================

/// Current implementation:
/// 1. AuthRemoteDataSourceImpl.login()
///    ↓ Returns AuthTokensModel or throws ServerException
///
/// 2. AuthRepositoryImpl.login()
///    ↓ Catches exceptions, converts to Failure
///    ↓ Returns Either<Failure, AuthTokens>
///
/// 3. LoginUseCase.call()
///    ↓ Passes through Either<Failure, AuthTokens>
///
/// 4. UI (LoginPage)
///    ↓ Handles result.fold((failure) => ..., (tokens) => ...)

// Dummy classes for compilation
class AuthTokens {
  final String accessToken;
  final String refreshToken;
  AuthTokens(this.accessToken, this.refreshToken);
}

