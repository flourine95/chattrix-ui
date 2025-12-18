import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../errors/failures.dart';
import '../errors/exceptions.dart';

/// Base repository with common error handling logic
///
/// All repository implementations should extend this class to:
/// - Eliminate code duplication (~60% code reduction)
/// - Ensure consistent error handling across the app
/// - Automatically convert exceptions to domain Failures
///
/// Usage:
/// ```dart
/// class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
///   @override
///   Future<Either<Failure, User>> login(...) async {
///     return executeApiCall(() async {
///       final dto = await _apiService.login(...);
///       return dto.toEntity();
///     });
///   }
/// }
/// ```
abstract class BaseRepository {
  /// Execute API call with automatic error handling
  ///
  /// Wraps the API call in try-catch and converts exceptions to Failures:
  /// - ApiException → ValidationFailure, AuthFailure, NotFoundFailure, etc.
  /// - DioException → NetworkFailure (timeout, no connection)
  /// - Other exceptions → ServerFailure
  ///
  /// Returns Either<Failure, T>:
  /// - Right(T): Success with data
  /// - Left(Failure): Error occurred
  Future<Either<Failure, T>> executeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      final result = await apiCall();
      return right(result);
    } on ApiException catch (e) {
      return left(_handleApiException(e));
    } on DioException catch (e) {
      return left(_handleDioException(e));
    } catch (e) {
      return left(Failure.server(message: 'Unexpected error: $e', code: 'UNEXPECTED_ERROR'));
    }
  }

  /// Handle API exceptions from interceptor
  ///
  /// Maps API error codes to appropriate Failure types:
  /// - VALIDATION_ERROR → ValidationFailure
  /// - UNAUTHORIZED, FORBIDDEN → AuthFailure
  /// - RESOURCE_NOT_FOUND → NotFoundFailure
  /// - CONFLICT → ConflictFailure
  /// - RATE_LIMIT_EXCEEDED → RateLimitFailure
  /// - Others → ServerFailure
  Failure _handleApiException(ApiException e) {
    switch (e.code) {
      case 'VALIDATION_ERROR':
        return Failure.validation(message: e.message, code: e.code, details: e.details, requestId: e.requestId);
      case 'UNAUTHORIZED':
      case 'FORBIDDEN':
        return Failure.auth(message: e.message, code: e.code, requestId: e.requestId);
      case 'RESOURCE_NOT_FOUND':
        return Failure.notFound(message: e.message, code: e.code, requestId: e.requestId);
      case 'CONFLICT':
        return Failure.conflict(message: e.message, code: e.code, requestId: e.requestId);
      case 'RATE_LIMIT_EXCEEDED':
        return Failure.rateLimit(message: e.message, code: e.code, requestId: e.requestId);
      default:
        return Failure.server(message: e.message, code: e.code, requestId: e.requestId);
    }
  }

  /// Handle Dio exceptions (network errors)
  ///
  /// Maps DioException types to Failures:
  /// - connectionTimeout, receiveTimeout → NetworkFailure (TIMEOUT)
  /// - connectionError → NetworkFailure (NO_CONNECTION)
  /// - Others → ServerFailure
  Failure _handleDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
      return Failure.network(message: 'Connection timeout', code: 'TIMEOUT');
    } else if (e.type == DioExceptionType.connectionError) {
      return Failure.network(message: 'No internet connection', code: 'NO_CONNECTION');
    } else {
      return Failure.server(message: e.message ?? 'Server error', code: 'SERVER_ERROR');
    }
  }
}
