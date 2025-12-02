import 'package:dio/dio.dart';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import '../models/call_models.dart';

class CallApiService {
  final Dio _dio;
  static const String _baseUrl = '/api/v1/calls';

  CallApiService(this._dio);

  /// Initiate a new call
  Future<CallConnection> initiateCall(InitiateCallRequest request) async {
    try {
      appLogger.i('Initiating call: calleeId=${request.calleeId}, type=${request.callType}');

      final response = await _dio.post(
        '$_baseUrl/initiate',
        data: request.toJson(),
      );

      appLogger.d('Call initiated successfully: ${response.data}');

      final data = response.data['data'] as Map<String, dynamic>;
      return CallConnection.fromJson(data);
    } on DioException catch (e) {
      appLogger.e('Failed to initiate call', error: e, stackTrace: e.stackTrace);
      rethrow;
    }
  }

  /// Accept an incoming call
  Future<CallConnection> acceptCall(String callId) async {
    try {
      appLogger.i('Accepting call: $callId');

      final response = await _dio.post('$_baseUrl/$callId/accept');

      appLogger.d('Call accepted successfully: ${response.data}');

      final data = response.data['data'] as Map<String, dynamic>;
      return CallConnection.fromJson(data);
    } on DioException catch (e) {
      appLogger.e('Failed to accept call', error: e, stackTrace: e.stackTrace);
      rethrow;
    }
  }

  /// Reject an incoming call
  Future<void> rejectCall(String callId, RejectCallRequest request) async {
    try {
      appLogger.i('Rejecting call: $callId, reason=${request.reason}');

      await _dio.post(
        '$_baseUrl/$callId/reject',
        data: request.toJson(),
      );

      appLogger.d('Call rejected successfully');
    } on DioException catch (e) {
      appLogger.e('Failed to reject call', error: e, stackTrace: e.stackTrace);
      rethrow;
    }
  }

  /// End an active call
  Future<void> endCall(String callId, EndCallRequest request) async {
    try {
      appLogger.i('Ending call: $callId, reason=${request.reason}');

      await _dio.post(
        '$_baseUrl/$callId/end',
        data: request.toJson(),
      );

      appLogger.d('Call ended successfully');
    } on DioException catch (e) {
      appLogger.e('Failed to end call', error: e, stackTrace: e.stackTrace);
      rethrow;
    }
  }
}

