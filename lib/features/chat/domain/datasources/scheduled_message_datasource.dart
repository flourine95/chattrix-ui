import '../../../../core/network/api_response.dart';
import '../../data/models/scheduled_msg_model.dart';

abstract class ScheduledMessageDatasource {
  Future<ApiResponse<ScheduledMessageModel>> scheduleMessage({
    required int conversationId,
    required ScheduleMessageRequest request,
  });

  Future<ApiResponse<ScheduledMessagesPaginationResponse>> getScheduledMessages({
    int? conversationId,
    String status = 'PENDING',
    int page = 0,
    int size = 20,
  });

  Future<ApiResponse<ScheduledMessageModel>> getScheduledMessage({
    required int conversationId,
    required int scheduledMessageId,
  });

  Future<ApiResponse<ScheduledMessageModel>> updateScheduledMessage({
    required int conversationId,
    required int scheduledMessageId,
    required UpdateScheduledMessageRequest request,
  });

  Future<ApiResponse<void>> cancelScheduledMessage({required int conversationId, required int scheduledMessageId});

  Future<ApiResponse<BulkCancelResponse>> bulkCancelScheduledMessages({
    required int conversationId,
    required List<int> scheduledMessageIds,
  });
}
