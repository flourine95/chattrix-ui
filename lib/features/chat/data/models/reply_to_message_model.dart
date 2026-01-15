import 'package:chattrix_ui/features/chat/domain/entities/reply_to_message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reply_to_message_model.freezed.dart';
part 'reply_to_message_model.g.dart';

@freezed
abstract class ReplyToMessageModel with _$ReplyToMessageModel {
  const ReplyToMessageModel._();

  const factory ReplyToMessageModel({
    required int id,
    required String content,
    @JsonKey(name: 'senderId') int? senderId,
    @JsonKey(name: 'senderUsername') String? senderUsername,
    String? senderFullName,
    required String type,
    String? createdAt,
    String? fileName,
    String? locationName,
    String? mediaUrl,
    int? duration,
    // Ignore metadata field from API
    @JsonKey(includeFromJson: false, includeToJson: false) Map<String, dynamic>? metadata,
  }) = _ReplyToMessageModel;

  factory ReplyToMessageModel.fromJson(Map<String, dynamic> json) => _$ReplyToMessageModelFromJson(json);

  ReplyToMessage toEntity() {
    return ReplyToMessage(
      id: id,
      content: content.isEmpty ? _getDefaultContent(type) : content,
      senderId: senderId ?? 0,
      senderUsername: senderUsername ?? 'Unknown',
      senderFullName: senderFullName,
      type: type,
      createdAt: createdAt,
      fileName: fileName,
      locationName: locationName,
      mediaUrl: mediaUrl,
      duration: duration,
    );
  }

  /// Get default content for empty content based on message type
  String _getDefaultContent(String type) {
    switch (type.toUpperCase()) {
      case 'IMAGE':
        return '📷 Photo';
      case 'VIDEO':
        return '🎥 Video';
      case 'AUDIO':
      case 'VOICE':
        return '🎤 Voice message';
      case 'DOCUMENT':
      case 'FILE':
        return '📄 Document';
      case 'LOCATION':
        return '📍 Location';
      case 'STICKER':
        return '🎭 Sticker';
      case 'EMOJI':
        return '😊 Emoji';
      default:
        return 'Message';
    }
  }
}
