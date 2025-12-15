import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_timeout_dto.freezed.dart';
part 'call_timeout_dto.g.dart';

/// WebSocket payload for call timeout (event: call.timeout)
@freezed
abstract class CallTimeoutDto with _$CallTimeoutDto {
  const factory CallTimeoutDto({
    required String callId,
    required String reason,
  }) = _CallTimeoutDto;

  factory CallTimeoutDto.fromJson(Map<String, dynamic> json) =>
      _$CallTimeoutDtoFromJson(json);
}

