import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import '../errors/exceptions.dart';
import '../errors/failures.dart';

abstract class BaseRepository {
  Future<Either<Failure, T>> executeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      final result = await apiCall();
      return right(result);
    } on DioException catch (e) {
      // Check if the error is an ApiException wrapped in DioException
      if (e.error is ApiException) {
        final apiException = e.error as ApiException;
        debugPrint('🔴 ApiException caught in BaseRepository:');
        debugPrint('   Message: ${apiException.message}');
        debugPrint('   Code: ${apiException.code}');
        debugPrint('   Status: ${apiException.statusCode}');
        debugPrint('   Details: ${apiException.details}');
        debugPrint('   RequestID: ${apiException.requestId}');
        return left(_handleApiException(apiException));
      }

      // Handle regular DioException
      debugPrint('🔴 DioException caught in BaseRepository:');
      debugPrint('   Type: ${e.type}');
      debugPrint('   Message: ${e.message}');
      debugPrint('   Response: ${e.response?.data}');
      debugPrint('   Status: ${e.response?.statusCode}');
      return left(_handleDioException(e));
    } on ApiException catch (e) {
      // Direct ApiException (shouldn't happen with new interceptor, but keep for safety)
      debugPrint('🔴 Direct ApiException caught in BaseRepository:');
      debugPrint('   Message: ${e.message}');
      debugPrint('   Code: ${e.code}');
      debugPrint('   Status: ${e.statusCode}');
      debugPrint('   Details: ${e.details}');
      return left(_handleApiException(e));
    } catch (e, stackTrace) {
      debugPrint('🔴 Unexpected error in BaseRepository: $e');
      debugPrint('   Stack trace: $stackTrace');
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
