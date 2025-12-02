import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/features/agora_call/data/models/call_connection_model.dart';
import 'package:chattrix_ui/features/agora_call/data/models/call_model.dart';
import 'package:dio/dio.dart';

/// Remote data source for Agora call API communication
class AgoraCallRemoteDataSource {
  final Dio dio;

  AgoraCallRemoteDataSource({required this.dio});

  /// Initiates a call to another user
  ///
  /// Sends a POST request to the backend with calleeId and callType
  /// Returns CallConnectionModel containing call details and Agora token
  ///
  /// Throws [ServerException] on API errors
  /// Throws [NetworkException] on network errors
  Future<CallConnectionModel> initiateCall({required int calleeId, required String callType}) async {
    try {
      final response = await dio.post(ApiConstants.callsInitiate, data: {'calleeId': calleeId, 'callType': callType});

      final data = _handleResponse(response);
      return CallConnectionModel.fromJson(data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Accepts an incoming call
  ///
  /// Sends a POST request to accept the call with the given callId
  /// Returns CallConnectionModel containing call details and Agora token for callee
  ///
  /// Throws [ServerException] on API errors
  /// Throws [NetworkException] on network errors
  Future<CallConnectionModel> acceptCall(String callId) async {
    try {
      final response = await dio.post(ApiConstants.callAccept(callId));

      final data = _handleResponse(response);
      return CallConnectionModel.fromJson(data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Rejects an incoming call
  ///
  /// Sends a POST request to reject the call with the given callId and reason
  /// Returns CallModel containing updated call details
  ///
  /// Throws [ServerException] on API errors
  /// Throws [NetworkException] on network errors
  Future<CallModel> rejectCall({required String callId, required String reason}) async {
    try {
      final response = await dio.post(ApiConstants.callReject(callId), data: {'reason': reason});

      final data = _handleResponse(response);
      return CallModel.fromJson(data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Ends an active call
  ///
  /// Sends a POST request to end the call with the given callId and reason
  /// Returns CallModel containing final call details including duration
  ///
  /// Throws [ServerException] on API errors
  /// Throws [NetworkException] on network errors
  Future<CallModel> endCall({required String callId, required String reason}) async {
    try {
      final response = await dio.post(ApiConstants.callEnd(callId), data: {'reason': reason});

      final data = _handleResponse(response);
      return CallModel.fromJson(data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Handles successful API responses
  ///
  /// Extracts the 'data' field from the response
  /// Throws [ServerException] if response status is not successful
  dynamic _handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data['data'];
    } else {
      // Parse error from API format: { "success": false, "error": { "code": "...", "message": "..." }, "requestId": "..." }
      final errorData = response.data['error'];
      final message = errorData?['message'] ?? response.data['message'] ?? 'An error occurred';
      final errorCode = errorData?['code'] as String?;

      throw ServerException(message: message, errorCode: errorCode, statusCode: response.statusCode);
    }
  }

  /// Handles errors from API calls
  ///
  /// Converts DioException to appropriate custom exceptions
  /// Returns [ServerException] for API errors
  /// Returns [NetworkException] for network connectivity issues
  Exception _handleError(dynamic error) {
    if (error is ServerException) {
      return error;
    } else if (error is DioException) {
      // Handle network timeout and connection errors
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError) {
        return NetworkException();
      }

      // Handle response errors
      if (error.response != null) {
        // Parse error from API format: { "success": false, "error": { "code": "...", "message": "..." }, "requestId": "..." }
        final errorData = error.response?.data['error'];
        final message = errorData?['message'] ?? error.response?.data['message'] ?? 'An error occurred';
        final errorCode = errorData?['code'] as String?;

        return ServerException(message: message, errorCode: errorCode, statusCode: error.response?.statusCode);
      }

      return NetworkException();
    } else {
      return ServerException(message: error.toString());
    }
  }
}
