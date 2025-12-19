import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../errors/exceptions.dart';
import '../errors/failures.dart';

abstract class BaseRepository {
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
