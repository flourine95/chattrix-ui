import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_update_dto.freezed.dart';
part 'message_update_dto.g.dart';

/// WebSocket payload for message update (event: message.updated)
@freezed
abstract class MessageUpdateDto with _$MessageUpdateDto {
  const factory MessageUpdateDto({
    required int messageId,
    required int conversationId,
    required String content,
    required bool edited,
    required DateTime updatedAt,
  }) = _MessageUpdateDto;

  factory MessageUpdateDto.fromJson(Map<String, dynamic> json) => _$MessageUpdateDtoFromJson(json);
}
