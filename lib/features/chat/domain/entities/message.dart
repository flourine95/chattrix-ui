import 'package:chattrix_ui/features/chat/domain/entities/event_entity.dart';
import 'package:chattrix_ui/features/chat/domain/entities/mentioned_user.dart';
import 'package:chattrix_ui/features/chat/domain/entities/read_receipt.dart';
import 'package:chattrix_ui/features/chat/domain/entities/reply_to_message.dart';
import 'package:chattrix_ui/features/poll/domain/entities/poll_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

@freezed
abstract class Message with _$Message {
  const factory Message({
    required int id,
    required int conversationId,
    required int senderId,
    String? senderUsername,
    String? senderFullName,
    required String content,
    required String type, // 'TEXT', 'IMAGE', 'VIDEO', 'AUDIO', 'FILE', 'LOCATION', 'SYSTEM', 'POLL', 'EVENT'
    required DateTime createdAt,
    String? mediaUrl,
    String? thumbnailUrl,
    String? fileName,
    int? fileSize,
    int? duration,
    double? latitude,
    double? longitude,
    String? locationName,
    int? replyToMessageId,
    ReplyToMessage? replyToMessage,
    // Reactions: Map of emoji to array of user IDs (e.g., {"👍": [1, 2], "❤️": [3]})
    Map<String, List<int>>? reactions,
    // Mentions: Array of user IDs mentioned in message (e.g., [1, 2, 3])
    List<int>? mentions,
    @Default([]) List<MentionedUser> mentionedUsers,
    DateTime? sentAt,
    DateTime? updatedAt,
    @Default(false) bool edited,
    DateTime? editedAt,
    @Default(false) bool deleted,
    DateTime? deletedAt,
    @Default(false) bool forwarded,
    int? originalMessageId,
    @Default(0) int forwardCount,
    @Default(0) int readCount,
    @Default([]) List<ReadReceipt> readBy,
    // Scheduled message fields
    @Default(false) bool scheduled,
    DateTime? scheduledTime,
    String? scheduledStatus, // PENDING, SENT, CANCELLED, FAILED
    // Pinned message fields
    @Default(false) bool pinned,
    DateTime? pinnedAt,
    int? pinnedBy,
    String? pinnedByUsername,
    String? pinnedByFullName,
    // Poll data (for POLL type messages)
    PollEntity? pollData,
    // Event data (for EVENT type messages)
    EventEntity? eventData,
  }) = _Message;
}
