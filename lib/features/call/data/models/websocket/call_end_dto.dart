import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_end_dto.freezed.dart';
part 'call_end_dto.g.dart';

/// WebSocket payload for call ended (event: call.ended)
@freezed
abstract class CallEndDto with _$CallEndDto {
  const factory CallEndDto({required String callId, required int endedBy, required int durationSeconds}) = _CallEndDto;

  factory CallEndDto.fromJson(Map<String, dynamic> json) => _$CallEndDtoFromJson(json);
}
