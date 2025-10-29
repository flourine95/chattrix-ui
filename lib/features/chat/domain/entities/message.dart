import 'package:chattrix_ui/features/chat/domain/entities/message_sender.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

@freezed
abstract class Message with _$Message {
  const factory Message({
    required int id,
    required String content,
    required String type, // 'TEXT', 'IMAGE', 'VIDEO', 'AUDIO', 'DOCUMENT', 'LOCATION', etc.
    required DateTime createdAt,
    required String conversationId,
    required MessageSender sender,
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
    // Reactions (stored as JSON string: {"👍": [userId1, userId2], "❤️": [userId3]})
    String? reactions,
    // Mentions (stored as JSON string: [userId1, userId2])
    String? mentions,
  }) = _Message;
}
