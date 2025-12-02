import 'package:freezed_annotation/freezed_annotation.dart';
import 'call_entity.dart';

part 'call_invitation_entity.freezed.dart';

/// Incoming call invitation
@freezed
abstract class CallInvitationEntity with _$CallInvitationEntity {
  const factory CallInvitationEntity({
    required String callId,
    required String channelId,
    required int callerId,
    required String callerName,
    String? callerAvatar,
    required CallType callType,
  }) = _CallInvitationEntity;
}
