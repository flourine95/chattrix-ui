import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_update_dto.freezed.dart';
part 'conversation_update_dto.g.dart';

/// WebSocket payload for conversation update (event: conversation.update)
@freezed
abstract class ConversationUpdateDto with _$ConversationUpdateDto {
  const factory ConversationUpdateDto({
    required int conversationId,
    required String updatedAt,
    LastMessageInfoDto? lastMessage,
  }) = _ConversationUpdateDto;

  factory ConversationUpdateDto.fromJson(Map<String, dynamic> json) => _$ConversationUpdateDtoFromJson(json);
}

@freezed
abstract class LastMessageInfoDto with _$LastMessageInfoDto {
  const factory LastMessageInfoDto({
    required int id,
    required String content,
    required int senderId,
    required String senderUsername,
    required String sentAt,
    required String type,
  }) = _LastMessageInfoDto;

  factory LastMessageInfoDto.fromJson(Map<String, dynamic> json) => _$LastMessageInfoDtoFromJson(json);
}

