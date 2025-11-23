import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_invitation_data.freezed.dart';
part 'call_invitation_data.g.dart';

/// Data payload for call invitation
@freezed
abstract class CallInvitationData with _$CallInvitationData {
  const factory CallInvitationData({
    required String callId,
    required String channelId,
    required String callerId,
    required String callerName,
    String? callerAvatar,
    required String callType, // 'AUDIO' or 'VIDEO'
  }) = _CallInvitationData;

  factory CallInvitationData.fromJson(Map<String, dynamic> json) => _$CallInvitationDataFromJson(json);
}
