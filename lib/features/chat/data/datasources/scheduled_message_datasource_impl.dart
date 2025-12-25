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
      final response = await _dio.get(
        '/v1/messages/scheduled',
        queryParameters: {
          if (conversationId != null) 'conversationId': conversationId,
          'status': status,
          'page': page,
          'size': size,
        },
      );

      final apiResponse = ApiResponse<ScheduledMessagesPaginationResponse>.fromJson(response.data, (json) {
        final parsed = ScheduledMessagesPaginationResponse.fromJson(json as Map<String, dynamic>);
        return parsed;
      });

      return apiResponse;
    } catch (e, stackTrace) {
      debugPrint('🔴 Error getting scheduled messages: $e');
      debugPrint('🔴 Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ScheduledMessageModel>> getScheduledMessage({required int scheduledMessageId}) async {
    final response = await _dio.get('/v1/messages/scheduled/$scheduledMessageId');

    return ApiResponse<ScheduledMessageModel>.fromJson(
      response.data,
      (json) => ScheduledMessageModel.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
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

  @override
  Future<ApiResponse<void>> cancelScheduledMessage({required int scheduledMessageId}) async {
    final response = await _dio.delete('/v1/messages/scheduled/$scheduledMessageId');

    return ApiResponse<void>.fromJson(response.data, (_) {});
  }

  @override
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
