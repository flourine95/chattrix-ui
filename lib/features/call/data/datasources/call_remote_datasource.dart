import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/call/data/models/call_model.dart';
import 'package:chattrix_ui/features/call/data/services/call_logger.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

/// Remote data source for call-related API operations
class CallRemoteDataSource {
  final Dio dio;

  CallRemoteDataSource({required this.dio});

  /// Initiate a call via REST API
  /// Backend will generate channel ID and send WebSocket invitation to callee
  /// Returns Either<Failure, Map<String, dynamic>> for proper error handling
  Future<Either<Failure, Map<String, dynamic>>> initiateCall({
    required String calleeId,
    required CallType callType,
  }) async {
    try {
      final requestData = {'calleeId': calleeId, 'callType': callType == CallType.video ? 'VIDEO' : 'AUDIO'};

      CallLogger.logDebug('Calling REST API to initiate call: calleeId=$calleeId, callType=${callType.name}');
      CallLogger.logDebug('Request body: $requestData');

      final response = await dio.post(ApiConstants.callsInitiate, data: requestData);

      if (response.statusCode == 201) {
        final data = response.data['data'] as Map<String, dynamic>;
        CallLogger.logDebug('Call initiation API response: $data');
        return Right(data);
      }

      final failure = const Failure.server(message: 'Failed to initiate call');
      CallLogger.logFailure(failure, context: 'initiateCall');
      return Left(failure);
    } on DioException catch (e, stackTrace) {
      final failure = _handleDioError(e);
      CallLogger.logFailure(failure, context: 'initiateCall', stackTrace: stackTrace);
      return Left(failure);
    } catch (e, stackTrace) {
      final failure = Failure.unknown(message: 'Unexpected error during call initiation: ${e.toString()}');
      CallLogger.logFailure(failure, context: 'initiateCall', stackTrace: stackTrace);
      return Left(failure);
    }
  }

  /// Accept a call via REST API
  /// Returns Either<Failure, CallModel> for proper error handling
  Future<Either<Failure, CallModel>> acceptCall(String callId) async {
    try {
      CallLogger.logDebug('Calling REST API to accept call: callId=$callId');

      final response = await dio.post(ApiConstants.callAccept(callId));

      if (response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>;
        CallLogger.logDebug('Call accept API response: $data');
        return Right(CallModel.fromJson(data));
      }

      final failure = const Failure.server(message: 'Failed to accept call');
      CallLogger.logFailure(failure, context: 'acceptCall');
      return Left(failure);
    } on DioException catch (e, stackTrace) {
      final failure = _handleDioError(e);
      CallLogger.logFailure(failure, context: 'acceptCall', stackTrace: stackTrace);
      return Left(failure);
    } catch (e, stackTrace) {
      final failure = Failure.unknown(message: 'Unexpected error during call accept: ${e.toString()}');
      CallLogger.logFailure(failure, context: 'acceptCall', stackTrace: stackTrace);
      return Left(failure);
    }
  }

  /// Reject a call via REST API
  /// Returns Either<Failure, void> for proper error handling
  Future<Either<Failure, void>> rejectCall(String callId, String reason) async {
    try {
      CallLogger.logDebug('Calling REST API to reject call: callId=$callId, reason=$reason');

      final response = await dio.post(ApiConstants.callReject(callId), data: {'reason': reason});

      if (response.statusCode == 200) {
        CallLogger.logDebug('Call rejected successfully via REST API: callId=$callId');
        return const Right(null);
      }

      final failure = const Failure.server(message: 'Failed to reject call');
      CallLogger.logFailure(failure, context: 'rejectCall');
      return Left(failure);
    } on DioException catch (e, stackTrace) {
      final failure = _handleDioError(e);
      CallLogger.logFailure(failure, context: 'rejectCall', stackTrace: stackTrace);
      return Left(failure);
    } catch (e, stackTrace) {
      final failure = Failure.unknown(message: 'Unexpected error during call reject: ${e.toString()}');
      CallLogger.logFailure(failure, context: 'rejectCall', stackTrace: stackTrace);
      return Left(failure);
    }
  }

  /// End a call via REST API
  /// Returns Either<Failure, void> for proper error handling
  Future<Either<Failure, void>> endCall(String callId, int? durationSeconds) async {
    try {
      CallLogger.logDebug('Calling REST API to end call: callId=$callId, durationSeconds=$durationSeconds');

      final response = await dio.post(
        ApiConstants.callEnd(callId),
        data: {if (durationSeconds != null) 'durationSeconds': durationSeconds},
      );

      if (response.statusCode == 200) {
        CallLogger.logDebug('Call ended successfully via REST API: callId=$callId');
        return const Right(null);
      }

      final failure = const Failure.server(message: 'Failed to end call');
      CallLogger.logFailure(failure, context: 'endCall');
      return Left(failure);
    } on DioException catch (e, stackTrace) {
      final failure = _handleDioError(e);
      CallLogger.logFailure(failure, context: 'endCall', stackTrace: stackTrace);
      return Left(failure);
    } catch (e, stackTrace) {
      final failure = Failure.unknown(message: 'Unexpected error during call end: ${e.toString()}');
      CallLogger.logFailure(failure, context: 'endCall', stackTrace: stackTrace);
      return Left(failure);
    }
  }

  /// Convert DioException to appropriate Failure type
  Failure _handleDioError(DioException error) {
    final statusCode = error.response?.statusCode;
    final errorData = error.response?.data;
    final message = errorData?['message'] ?? 'Request failed';
    final errorCode = errorData?['errorCode'];

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure.network(message: 'Connection timeout. Please check your internet connection.');

      case DioExceptionType.badResponse:
        if (statusCode == 401) {
          return Failure.unauthorized(message: message, errorCode: errorCode);
        } else if (statusCode == 403) {
          return Failure.forbidden(message: message, errorCode: errorCode);
        } else if (statusCode == 404) {
          return Failure.notFound(message: message, errorCode: errorCode);
        } else if (statusCode == 400) {
          return Failure.badRequest(message: message, errorCode: errorCode);
        } else if (statusCode == 409) {
          return Failure.conflict(message: message, errorCode: errorCode);
        } else if (statusCode != null && statusCode >= 500) {
          return Failure.server(message: message, errorCode: errorCode);
        } else {
          return Failure.server(message: message, errorCode: errorCode);
        }

      case DioExceptionType.cancel:
        return const Failure.unknown(message: 'Request was cancelled');

      case DioExceptionType.connectionError:
        return const Failure.network(message: 'Cannot connect to server. Please check your internet connection.');

      case DioExceptionType.unknown:
      default:
        return Failure.network(message: 'Network error: ${error.message ?? "Unknown error"}');
    }
  }
}
