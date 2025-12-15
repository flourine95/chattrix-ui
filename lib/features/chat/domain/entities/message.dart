import 'package:chattrix_ui/features/chat/domain/entities/mentioned_user.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message_sender.dart';
import 'package:chattrix_ui/features/chat/domain/entities/read_receipt.dart';
import 'package:chattrix_ui/features/chat/domain/entities/reply_to_message.dart';
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
    required String type, // 'TEXT', 'IMAGE', 'VIDEO', 'AUDIO', 'FILE', 'LOCATION'
    required DateTime createdAt,
    @Deprecated('Use senderId, senderUsername, senderFullName instead') MessageSender? sender,
    // Rich media fields
    String? mediaUrl, // URL for image, video, audio, or document
    String? thumbnailUrl, // Thumbnail for video or document preview
    String? fileName, // Original file name for documents
    int? fileSize, // File size in bytes
    int? duration, // Duration in seconds for audio/video
    // Location fields
    double? latitude,
    double? longitude,
    String? locationName, // Human-readable location name
    // Reply/Thread fields
    int? replyToMessageId, // ID of message being replied to
    ReplyToMessage? replyToMessage, // Full reply message details
    // Reactions (stored as JSON string: {"👍": [userId1, userId2], "❤️": [userId3]})
    String? reactions,
    // Mentions (stored as JSON string: [userId1, userId2])
    String? mentions,
    @Default([]) List<MentionedUser> mentionedUsers,
    // Timestamps
    DateTime? sentAt,
    DateTime? updatedAt,
    // Edit/Delete/Forward
    @Default(false) bool edited,
    DateTime? editedAt,
    @Default(false) bool deleted,
    DateTime? deletedAt,
    @Default(false) bool forwarded,
    int? originalMessageId,
    @Default(0) int forwardCount,
    // Read receipts
    @Default(0) int readCount,
    @Default([]) List<ReadReceipt> readBy,
  }) = _Message;
}
