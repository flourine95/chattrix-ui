import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/network/api_response.dart';
import '../models/scheduled_msg_model.dart';

/// API service for scheduled messages
class ScheduledMessageApiService {
  final Dio _dio;

  ScheduledMessageApiService(this._dio);

  /// Schedule a message
  ///
  /// **Endpoint**: `POST /api/v1/conversations/{conversationId}/messages/schedule`
  ///
  /// **Returns**: Full Message entity (scheduledTime and scheduledStatus are hidden)
  ///
  /// **Errors:**
  /// - 400: Validation failed (time in past, etc.)
  /// - 404: Conversation not found
  Future<ApiResponse<ScheduledMessageModel>> scheduleMessage({
    required int conversationId,
    required ScheduleMessageRequest request,
  }) async {
    final requestBody = request.toJson();
    debugPrint('🔵 Schedule Message Request Body: $requestBody');
    debugPrint('🔵 scheduledTime value: ${requestBody['scheduledTime']}');

    final response = await _dio.post('/v1/conversations/$conversationId/messages/schedule', data: requestBody);

    return ApiResponse<ScheduledMessageModel>.fromJson(
      response.data,
      (json) => ScheduledMessageModel.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Get list of scheduled messages
  ///
  /// **Endpoint**: `GET /api/v1/messages/scheduled`
  ///
  /// **Returns**: List with scheduledTime and scheduledStatus visible
  ///
  /// **Query params:**
  /// - conversationId: Filter by conversation (optional)
  /// - status: Filter by status (default: PENDING)
  /// - page: Page number (default: 0)
  /// - size: Page size (default: 20)
  Future<ApiResponse<ScheduledMessagesPaginationResponse>> getScheduledMessages({
    int? conversationId,
    String status = 'PENDING',
    int page = 0,
    int size = 20,
  }) async {
    debugPrint('🔵 Get Scheduled Messages Request:');
    debugPrint('   conversationId: $conversationId');
    debugPrint('   status: $status');
    debugPrint('   page: $page, size: $size');

    try {
      final response = await _dio.get(
        '/v1/messages/scheduled',
        queryParameters: {
          if (conversationId != null) 'conversationId': conversationId,
          'status': status,
          'page': page,
          'size': size,
        },
      );

      debugPrint('🔵 Get Scheduled Messages Response:');
      debugPrint('   status: ${response.statusCode}');
      debugPrint('   data type: ${response.data.runtimeType}');
      debugPrint('   data: ${response.data}');

      final apiResponse = ApiResponse<ScheduledMessagesPaginationResponse>.fromJson(response.data, (json) {
        debugPrint('🔵 Parsing pagination response from: $json');
        final parsed = ScheduledMessagesPaginationResponse.fromJson(json as Map<String, dynamic>);
        debugPrint('🔵 Parsed ${parsed.messages.length} messages');
        return parsed;
      });

      debugPrint('🔵 API Response success: ${apiResponse.success}');
      debugPrint('🔵 API Response message: ${apiResponse.message}');
      debugPrint('🔵 API Response data: ${apiResponse.data}');

      return apiResponse;
    } catch (e, stackTrace) {
      debugPrint('🔴 Error getting scheduled messages: $e');
      debugPrint('🔴 Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Get single scheduled message
  ///
  /// **Endpoint**: `GET /api/v1/messages/scheduled/{scheduledMessageId}`
  ///
  /// **Errors:**
  /// - 404: Scheduled message not found
  Future<ApiResponse<ScheduledMessageModel>> getScheduledMessage({required int scheduledMessageId}) async {
    final response = await _dio.get('/v1/messages/scheduled/$scheduledMessageId');

    return ApiResponse<ScheduledMessageModel>.fromJson(
      response.data,
      (json) => ScheduledMessageModel.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Update scheduled message
  ///
  /// **Endpoint**: `PUT /api/v1/messages/scheduled/{scheduledMessageId}`
  ///
  /// **Errors:**
  /// - 400: Cannot edit (already sent)
  /// - 404: Scheduled message not found
  Future<ApiResponse<ScheduledMessageModel>> updateScheduledMessage({
    required int scheduledMessageId,
    required UpdateScheduledMessageRequest request,
  }) async {
    final response = await _dio.put('/v1/messages/scheduled/$scheduledMessageId', data: request.toJson());

    return ApiResponse<ScheduledMessageModel>.fromJson(
      response.data,
      (json) => ScheduledMessageModel.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Cancel scheduled message
  ///
  /// **Endpoint**: `DELETE /api/v1/messages/scheduled/{scheduledMessageId}`
  ///
  /// **Errors:**
  /// - 400: Cannot cancel (already sent)
  /// - 404: Scheduled message not found
  Future<ApiResponse<void>> cancelScheduledMessage({required int scheduledMessageId}) async {
    final response = await _dio.delete('/v1/messages/scheduled/$scheduledMessageId');

    return ApiResponse<void>.fromJson(response.data, (_) {});
  }

  /// Bulk cancel scheduled messages
  ///
  /// **Endpoint**: `DELETE /api/v1/messages/scheduled/bulk`
  Future<ApiResponse<BulkCancelResponse>> bulkCancelScheduledMessages({required List<int> scheduledMessageIds}) async {
    final response = await _dio.delete(
      '/v1/messages/scheduled/bulk',
      data: BulkCancelRequest(scheduledMessageIds: scheduledMessageIds).toJson(),
    );

    return ApiResponse<BulkCancelResponse>.fromJson(
      response.data,
      (json) => BulkCancelResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
