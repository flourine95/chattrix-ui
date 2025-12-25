import '../../../../core/network/api_response.dart';
import '../../data/models/scheduled_msg_model.dart';

/// Datasource interface for scheduled messages
/// Implementation: Data Layer
abstract class ScheduledMessageDatasource {
  /// Schedule a message
  ///
  /// **Endpoint**: `POST /api/v1/conversations/{conversationId}/messages/schedule`
  ///
  /// **Errors:**
  /// - 400: Validation failed (time in past, etc.)
  /// - 404: Conversation not found
  Future<ApiResponse<ScheduledMessageModel>> scheduleMessage({
    required int conversationId,
    required ScheduleMessageRequest request,
  });

  /// Get list of scheduled messages
  ///
  /// **Endpoint**: `GET /api/v1/conversations/{conversationId}/messages/scheduled`
  ///
  /// **Query params:**
  /// - status: Filter by status (default: PENDING)
  /// - page: Page number (default: 0)
  /// - size: Page size (default: 20)
  ///
  /// **Note**: conversationId is REQUIRED
  Future<ApiResponse<ScheduledMessagesPaginationResponse>> getScheduledMessages({
    int? conversationId,
    String status = 'PENDING',
    int page = 0,
    int size = 20,
  });

  /// Get single scheduled message
  ///
  /// **Endpoint**: `GET /api/v1/conversations/{conversationId}/messages/scheduled/{scheduledMessageId}`
  ///
  /// **Errors:**
  /// - 404: Scheduled message not found
  Future<ApiResponse<ScheduledMessageModel>> getScheduledMessage({
    required int conversationId,
    required int scheduledMessageId,
  });

  /// Update scheduled message
  ///
  /// **Endpoint**: `PUT /api/v1/conversations/{conversationId}/messages/scheduled/{scheduledMessageId}`
  ///
  /// **Errors:**
  /// - 400: Cannot edit (already sent)
  /// - 404: Scheduled message not found
  Future<ApiResponse<ScheduledMessageModel>> updateScheduledMessage({
    required int conversationId,
    required int scheduledMessageId,
    required UpdateScheduledMessageRequest request,
  });

  /// Cancel scheduled message
  ///
  /// **Endpoint**: `DELETE /api/v1/conversations/{conversationId}/messages/scheduled/{scheduledMessageId}`
  ///
  /// **Errors:**
  /// - 400: Cannot cancel (already sent)
  /// - 404: Scheduled message not found
  Future<ApiResponse<void>> cancelScheduledMessage({required int conversationId, required int scheduledMessageId});

  /// Bulk cancel scheduled messages
  ///
  /// **Endpoint**: `DELETE /api/v1/conversations/{conversationId}/messages/scheduled/bulk`
  Future<ApiResponse<BulkCancelResponse>> bulkCancelScheduledMessages({
    required int conversationId,
    required List<int> scheduledMessageIds,
  });
}
