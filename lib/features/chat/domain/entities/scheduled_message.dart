import 'package:freezed_annotation/freezed_annotation.dart';

part 'scheduled_message.freezed.dart';

/// Domain entity for scheduled message
///
/// Represents a message that is scheduled to be sent at a future time
@freezed
abstract class ScheduledMessage with _$ScheduledMessage {
  const factory ScheduledMessage({
    required int id,
    required int conversationId,
    required int senderId,
    String? senderUsername,
    String? senderFullName,
    required String content,
    required String type,
    String? mediaUrl,
    String? thumbnailUrl,
    String? fileName,
    int? fileSize,
    int? duration,
    int? replyToMessageId,
    DateTime? sentAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    // These fields only available in list response
    DateTime? scheduledTime,
    String? scheduledStatus, // PENDING, SENT, FAILED, CANCELLED
  }) = _ScheduledMessage;
}
