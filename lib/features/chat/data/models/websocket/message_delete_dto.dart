import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_delete_dto.freezed.dart';
part 'message_delete_dto.g.dart';

/// WebSocket payload for message deletion (event: message.deleted)
@freezed
abstract class MessageDeleteDto with _$MessageDeleteDto {
  const factory MessageDeleteDto({required int messageId, required int conversationId}) = _MessageDeleteDto;

  factory MessageDeleteDto.fromJson(Map<String, dynamic> json) => _$MessageDeleteDtoFromJson(json);
}
