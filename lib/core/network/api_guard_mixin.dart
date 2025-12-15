import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

mixin ApiGuardMixin {
  Future<Either<Failure, T>> safeCall<T>(Future<T> Function() body) async {
    try {
      final result = await body();
      return Right(result);
    } catch (e, stackTrace) {
      AppLogger.error('SafeCall Error', error: e, stackTrace: stackTrace);
      return Left(_mapExceptionToFailure(e));
    }
  }

  Failure _mapExceptionToFailure(dynamic error) {
    if (error is Failure) return error;

    if (error is ServerException) {
      return _mapServerException(error);
    }

    if (error is NetworkException) {
      return Failure.network(message: error.message);
    }

    if (error is DioException) {
      return _mapDioException(error);
    }

    return Failure.unknown(message: error.toString());
  }

  Failure _mapServerException(ServerException e) {
    switch (e.errorCode) {
      case 'VALIDATION_ERROR':
        List<ValidationError>? validationErrors;
        if (e.errors != null) {
          validationErrors = e.errors!.entries.map((entry) {
            return ValidationError(
              field: entry.key,
              errorCode: 'INVALID',
              message: entry.value.toString(),
            );
          }).toList();
        }
        return Failure.validation(message: e.message, errors: validationErrors);

      case 'UNAUTHORIZED':
      case 'INVALID_TOKEN':
      case 'TOKEN_EXPIRED':
        return Failure.unauthorized(message: e.message, errorCode: e.errorCode);

      case 'FORBIDDEN':
      case 'ACCESS_DENIED':
        return Failure.forbidden(message: e.message, errorCode: e.errorCode);

      case 'NOT_FOUND':
      case 'USER_NOT_FOUND':
      case 'RESOURCE_NOT_FOUND':
        return Failure.notFound(message: e.message, errorCode: e.errorCode);

      case 'CONFLICT':
      case 'ALREADY_EXISTS':
      case 'EMAIL_EXISTS':
        return Failure.conflict(message: e.message, errorCode: e.errorCode);

      case 'RATE_LIMIT_EXCEEDED':
        return Failure.rateLimitExceeded(message: e.message);

      case 'BAD_REQUEST':
        return Failure.badRequest(message: e.message, errorCode: e.errorCode);

      default:
        if (e.statusCode == 401) return Failure.unauthorized(message: e.message);
        if (e.statusCode == 403) return Failure.forbidden(message: e.message);
        if (e.statusCode == 404) return Failure.notFound(message: e.message);

        return Failure.server(message: e.message, errorCode: e.errorCode);
    }
  }

  Failure _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const Failure.network(message: 'Không có kết nối internet');

      case DioExceptionType.badResponse:
        return Failure.server(
            message: 'Lỗi máy chủ (${e.response?.statusCode})',
            errorCode: '${e.response?.statusCode}'
        );

      case DioExceptionType.cancel:
        return const Failure.unknown(message: 'Yêu cầu bị hủy');

      default:
        return Failure.unknown(message: 'Lỗi kết nối không xác định');
    }
  }
}