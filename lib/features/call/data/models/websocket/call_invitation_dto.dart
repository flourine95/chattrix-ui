import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_invitation_dto.freezed.dart';
part 'call_invitation_dto.g.dart';

/// WebSocket payload for incoming call (event: call.incoming)
@freezed
abstract class CallInvitationDto with _$CallInvitationDto {
  const factory CallInvitationDto({
    required String callId,
    required String channelId,
    required int callerId,
    required String callerName,
    String? callerAvatar,
    required String callType,
  }) = _CallInvitationDto;

  factory CallInvitationDto.fromJson(Map<String, dynamic> json) => _$CallInvitationDtoFromJson(json);
}
