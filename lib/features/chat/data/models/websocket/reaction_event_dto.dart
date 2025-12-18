import 'package:freezed_annotation/freezed_annotation.dart';

part 'reaction_event_dto.freezed.dart';
part 'reaction_event_dto.g.dart';

/// WebSocket payload for reaction events (event: message.reaction)
@freezed
abstract class ReactionEventDto with _$ReactionEventDto {
  const factory ReactionEventDto({
    required int messageId,
    required int userId,
    required String userName,
    required String emoji,
    required String action,
    required Map<String, List<int>> reactions,
    required DateTime timestamp,
  }) = _ReactionEventDto;

  factory ReactionEventDto.fromJson(Map<String, dynamic> json) => _$ReactionEventDtoFromJson(json);
}
