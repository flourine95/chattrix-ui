import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/network/api_response.dart';
import 'package:chattrix_ui/features/chat/data/models/scheduled_msg_model.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/scheduled_message_datasource.dart';
import 'package:dio/dio.dart';

class ScheduledMessageDatasourceImpl implements ScheduledMessageDatasource {
  final Dio _dio;

  ScheduledMessageDatasourceImpl(this._dio);

  @override
  Future<ApiResponse<ScheduledMessageModel>> scheduleMessage({
    required int conversationId,
    required ScheduleMessageRequest request,
  }) async {
    final requestBody = request.toJson();

    final response = await _dio.post(ApiConstants.scheduleMessage(conversationId), data: requestBody);

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
      if (conversationId == null) {
        throw Exception('conversationId is required to get scheduled messages');
      }

      final response = await _dio.get(
        ApiConstants.scheduledMessages(conversationId),
        queryParameters: {'status': status, 'page': page, 'size': size},
      );

      final apiResponse = ApiResponse<ScheduledMessagesPaginationResponse>.fromJson(response.data, (json) {
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
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ScheduledMessageModel>> getScheduledMessage({
    required int conversationId,
    required int scheduledMessageId,
  }) async {
    final response = await _dio.get(ApiConstants.scheduledMessageById(conversationId, scheduledMessageId));

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
      ApiConstants.scheduledMessageById(conversationId, scheduledMessageId),
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
    final response = await _dio.delete(ApiConstants.scheduledMessageById(conversationId, scheduledMessageId));

    return ApiResponse<void>.fromJson(response.data, (_) {});
  }

  @override
  Future<ApiResponse<BulkCancelResponse>> bulkCancelScheduledMessages({
    required int conversationId,
    required List<int> scheduledMessageIds,
  }) async {
    final response = await _dio.delete(
      ApiConstants.cancelScheduledMessagesBulk(conversationId),
      data: BulkCancelRequest(scheduledMessageIds: scheduledMessageIds).toJson(),
    );

    return ApiResponse<BulkCancelResponse>.fromJson(
      response.data,
      (json) => BulkCancelResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
