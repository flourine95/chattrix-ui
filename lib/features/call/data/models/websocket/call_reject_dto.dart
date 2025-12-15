import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_reject_dto.freezed.dart';
part 'call_reject_dto.g.dart';

/// WebSocket payload for call rejected (event: call.rejected)
@freezed
abstract class CallRejectDto with _$CallRejectDto {
  const factory CallRejectDto({
    required String callId,
    required int rejectedBy,
    required String reason,
  }) = _CallRejectDto;

  factory CallRejectDto.fromJson(Map<String, dynamic> json) =>
      _$CallRejectDtoFromJson(json);
}

