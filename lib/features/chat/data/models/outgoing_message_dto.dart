import 'package:chattrix_ui/features/chat/data/models/mentioned_user_model.dart';
import 'package:chattrix_ui/features/chat/data/models/reply_to_message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'outgoing_message_dto.freezed.dart';
part 'outgoing_message_dto.g.dart';

/// WebSocket payload for new chat message (event: chat.message)
@freezed
abstract class OutgoingMessageDto with _$OutgoingMessageDto {
  const OutgoingMessageDto._();

  const factory OutgoingMessageDto({
    required int id,
    required int conversationId,
    required MessageSenderDto sender,
    required String content,
    required String type,
    required String createdAt,
    String? mediaUrl,
    String? thumbnailUrl,
    String? fileName,
    int? fileSize,
    int? duration,
    double? latitude,
    double? longitude,
    String? locationName,
    int? replyToMessageId,
    ReplyToMessageModel? replyToMessage,
    Map<String, List<int>>? reactions,
    List<int>? mentions,
    List<MentionedUserModel>? mentionedUsers,
  }) = _OutgoingMessageDto;

  factory OutgoingMessageDto.fromJson(Map<String, dynamic> json) => _$OutgoingMessageDtoFromJson(json);
}

@freezed
abstract class MessageSenderDto with _$MessageSenderDto {
  const factory MessageSenderDto({
    required int id,
    required String username,
    required String fullName,
    String? avatarUrl,
  }) = _MessageSenderDto;

  factory MessageSenderDto.fromJson(Map<String, dynamic> json) => _$MessageSenderDtoFromJson(json);
}
