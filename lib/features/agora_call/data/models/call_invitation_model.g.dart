// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_invitation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallInvitationModel _$CallInvitationModelFromJson(Map<String, dynamic> json) =>
    _CallInvitationModel(
      callId: json['callId'] as String,
      channelId: json['channelId'] as String,
      callerId: (json['callerId'] as num).toInt(),
      callerName: json['callerName'] as String,
      callerAvatar: json['callerAvatar'] as String?,
      callType: json['callType'] as String,
    );

Map<String, dynamic> _$CallInvitationModelToJson(
  _CallInvitationModel instance,
) => <String, dynamic>{
  'callId': instance.callId,
  'channelId': instance.channelId,
  'callerId': instance.callerId,
  'callerName': instance.callerName,
  'callerAvatar': instance.callerAvatar,
  'callType': instance.callType,
};
