import 'package:chattrix_ui/core/network/api_response.dart';
import 'package:chattrix_ui/features/chat/data/models/scheduled_msg_model.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/scheduled_message_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ScheduledMessageDatasourceImpl implements ScheduledMessageDatasource {
  final Dio _dio;

  ScheduledMessageDatasourceImpl(this._dio);

  @override
  Future<ApiResponse<ScheduledMessageModel>> scheduleMessage({
    required int conversationId,
    required ScheduleMessageRequest request,
  }) async {
    final requestBody = request.toJson();

    final response = await _dio.post('/v1/conversations/$conversationId/messages/schedule', data: requestBody);

    return ApiResponse<ScheduledMessageModel>.fromJson(
      response.data,
      (json) => ScheduledMessageModel.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<ScheduledMessagesPaginationResponse>> getScheduledMessages({
    int? conversationId,
    String status = 'PENDING',
    int page = 0,
    int size = 20,
  }) async {
    try {
      // Scheduled messages MUST have conversationId according to API spec
      if (conversationId == null) {
        throw Exception('conversationId is required to get scheduled messages');
      }

      final response = await _dio.get(
        '/v1/conversations/$conversationId/messages/scheduled',
        queryParameters: {'status': status, 'page': page, 'size': size},
      );

      final apiResponse = ApiResponse<ScheduledMessagesPaginationResponse>.fromJson(response.data, (json) {
        // API returns: { data: { items: [...], meta: {...} } }
        // We need to extract the nested 'data' object
        final dataObj = json as Map<String, dynamic>;
        final items = dataObj['items'] as List<dynamic>? ?? [];
        final meta = dataObj['meta'] as Map<String, dynamic>? ?? {};

        return ScheduledMessagesPaginationResponse(
          items: items.map((item) => ScheduledMessageListItemModel.fromJson(item as Map<String, dynamic>)).toList(),
          nextCursor: meta['nextCursor'] as String?,
          hasNextPage: meta['hasNextPage'] as bool? ?? false,
          itemsPerPage: meta['itemsPerPage'] as int? ?? 20,
        );
      });

      return apiResponse;
    } catch (e, stackTrace) {
      debugPrint('🔴 Error getting scheduled messages: $e');
      debugPrint('🔴 Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ScheduledMessageModel>> getScheduledMessage({
    required int conversationId,
    required int scheduledMessageId,
  }) async {
    final response = await _dio.get('/v1/conversations/$conversationId/messages/scheduled/$scheduledMessageId');

    return ApiResponse<ScheduledMessageModel>.fromJson(
      response.data,
      (json) => ScheduledMessageModel.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<ScheduledMessageModel>> updateScheduledMessage({
    required int conversationId,
    required int scheduledMessageId,
    required UpdateScheduledMessageRequest request,
  }) async {
    final response = await _dio.put(
      '/v1/conversations/$conversationId/messages/scheduled/$scheduledMessageId',
      data: request.toJson(),
    );

    return ApiResponse<ScheduledMessageModel>.fromJson(
      response.data,
      (json) => ScheduledMessageModel.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<void>> cancelScheduledMessage({
    required int conversationId,
    required int scheduledMessageId,
  }) async {
    final response = await _dio.delete('/v1/conversations/$conversationId/messages/scheduled/$scheduledMessageId');

    return ApiResponse<void>.fromJson(response.data, (_) {});
  }

  @override
  Future<ApiResponse<BulkCancelResponse>> bulkCancelScheduledMessages({
    required int conversationId,
    required List<int> scheduledMessageIds,
  }) async {
    final response = await _dio.delete(
      '/v1/conversations/$conversationId/messages/scheduled/bulk',
      data: BulkCancelRequest(scheduledMessageIds: scheduledMessageIds).toJson(),
    );

    return ApiResponse<BulkCancelResponse>.fromJson(
      response.data,
      (json) => BulkCancelResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
