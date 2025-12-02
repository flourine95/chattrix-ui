import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/call_connection_entity.dart';
import '../../domain/entities/call_entity.dart';
import '../../domain/failures/call_failure.dart';
import '../../domain/repositories/agora_call_repository.dart';
import '../datasources/agora_call_remote_datasource.dart';
import '../models/call_model.dart';
import '../models/call_connection_model.dart';
import '../../../../core/errors/exceptions.dart';

/// Implementation of AgoraCallRepository
///
/// Handles call operations by delegating to the remote data source
/// and mapping exceptions to domain failures using Either type
class AgoraCallRepositoryImpl implements AgoraCallRepository {
  final AgoraCallRemoteDataSource _remoteDataSource;

  AgoraCallRepositoryImpl({required AgoraCallRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<CallFailure, CallConnectionEntity>> initiateCall({
    required int calleeId,
    required CallType callType,
  }) async {
    try {
      final result = await _remoteDataSource.initiateCall(calleeId: calleeId, callType: callType.name.toUpperCase());
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(_handleServerException(e));
    } on NetworkException catch (_) {
      return Left(const CallFailure.networkError());
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(CallFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<CallFailure, CallConnectionEntity>> acceptCall({required String callId}) async {
    try {
      final result = await _remoteDataSource.acceptCall(callId);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(_handleServerException(e));
    } on NetworkException catch (_) {
      return Left(const CallFailure.networkError());
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(CallFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<CallFailure, CallEntity>> rejectCall({required String callId, required String reason}) async {
    try {
      final result = await _remoteDataSource.rejectCall(callId: callId, reason: reason);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(_handleServerException(e));
    } on NetworkException catch (_) {
      return Left(const CallFailure.networkError());
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(CallFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<CallFailure, CallEntity>> endCall({required String callId, String reason = 'hangup'}) async {
    try {
      final result = await _remoteDataSource.endCall(callId: callId, reason: reason);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(_handleServerException(e));
    } on NetworkException catch (_) {
      return Left(const CallFailure.networkError());
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(CallFailure.serverError(e.toString()));
    }
  }

  /// Maps ServerException to appropriate CallFailure
  CallFailure _handleServerException(ServerException exception) {
    // Check for specific error codes
    if (exception.errorCode != null) {
      switch (exception.errorCode) {
        case 'USER_BUSY':
        case 'CALL_USER_BUSY':
          return const CallFailure.userBusy();
        case 'CALL_NOT_FOUND':
          return const CallFailure.callNotFound();
        case 'UNAUTHORIZED':
        case 'INVALID_TOKEN':
          return const CallFailure.unauthorized();
        case 'PERMISSION_DENIED':
          return CallFailure.permissionDenied(exception.message);
      }
    }

    // Check status code
    if (exception.statusCode != null) {
      switch (exception.statusCode) {
        case 401:
          return const CallFailure.unauthorized();
        case 404:
          return const CallFailure.callNotFound();
      }
    }

    // Check message content for specific errors
    final message = exception.message.toLowerCase();
    if (message.contains('busy')) {
      return const CallFailure.userBusy();
    }
    if (message.contains('not found')) {
      return const CallFailure.callNotFound();
    }
    if (message.contains('unauthorized') || message.contains('token')) {
      return const CallFailure.unauthorized();
    }

    return CallFailure.serverError(exception.message);
  }

  /// Maps DioException to appropriate CallFailure
  ///
  /// Handles HTTP errors and network connectivity issues
  CallFailure _handleDioError(DioException exception) {
    // Handle network timeout and connection errors
    if (exception.type == DioExceptionType.connectionTimeout ||
        exception.type == DioExceptionType.sendTimeout ||
        exception.type == DioExceptionType.receiveTimeout ||
        exception.type == DioExceptionType.connectionError) {
      return const CallFailure.networkError();
    }

    // Handle response errors
    if (exception.response != null) {
      final statusCode = exception.response?.statusCode;
      final responseData = exception.response?.data;

      // Extract error message from response
      String message = 'An error occurred';
      String? errorCode;

      if (responseData is Map<String, dynamic>) {
        final errorData = responseData['error'];
        if (errorData is Map<String, dynamic>) {
          message = errorData['message'] ?? message;
          errorCode = errorData['code'] as String?;
        } else {
          message = responseData['message'] ?? message;
        }
      }

      // Map based on status code
      switch (statusCode) {
        case 400:
          if (errorCode == 'USER_BUSY' || message.toLowerCase().contains('busy')) {
            return const CallFailure.userBusy();
          }
          return CallFailure.serverError(message);
        case 401:
          return const CallFailure.unauthorized();
        case 404:
          return const CallFailure.callNotFound();
        case 403:
          return CallFailure.permissionDenied(message);
        default:
          return CallFailure.serverError(message);
      }
    }

    // Handle other DioException types
    if (exception.type == DioExceptionType.cancel) {
      return const CallFailure.serverError('Request cancelled');
    }

    return const CallFailure.networkError();
  }
}
