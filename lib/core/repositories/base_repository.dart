import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

abstract class BaseRepository {
  Future<Either<Failure, T>> executeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      debugPrint('🔄 [BaseRepo] Executing API call...');
      final result = await apiCall();
      debugPrint('✅ [BaseRepo] API call successful');
      return right(result);
    } on DioException catch (e) {
      debugPrint('❌ [BaseRepo] DioException caught: ${e.type}, message: ${e.message}');
      debugPrint('❌ [BaseRepo] Response: ${e.response?.data}');
      debugPrint('❌ [BaseRepo] Status code: ${e.response?.statusCode}');
      
      // Check if the error is an ApiException wrapped in DioException
      if (e.error is ApiException) {
        final apiException = e.error as ApiException;
        debugPrint('❌ [BaseRepo] ApiException wrapped in DioException: ${apiException.message}');
        return left(_handleApiException(apiException));
      }

      return left(_handleDioException(e));
    } on ApiException catch (e) {
      debugPrint('❌ [BaseRepo] ApiException caught: ${e.message}, code: ${e.code}');
      return left(_handleApiException(e));
    } catch (e, stackTrace) {
      debugPrint('❌ [BaseRepo] Unexpected error: $e');
      debugPrint('❌ [BaseRepo] Stack trace: $stackTrace');
      return left(Failure.server(message: 'Unexpected error: $e', code: 'UNEXPECTED_ERROR'));
    }
  }

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
      case 'BAD_REQUEST':
        return Failure.validation(message: e.message, code: e.code, requestId: e.requestId);
      default:
        return Failure.server(message: e.message, code: e.code, requestId: e.requestId);
    }
  }

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
