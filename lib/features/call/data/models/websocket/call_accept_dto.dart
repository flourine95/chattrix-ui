import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_accept_dto.freezed.dart';
part 'call_accept_dto.g.dart';

/// WebSocket payload for call accepted (event: call.accepted)
@freezed
abstract class CallAcceptDto with _$CallAcceptDto {
  const factory CallAcceptDto({
    required String callId,
    required int acceptedBy,
  }) = _CallAcceptDto;

  factory CallAcceptDto.fromJson(Map<String, dynamic> json) =>
      _$CallAcceptDtoFromJson(json);
}

