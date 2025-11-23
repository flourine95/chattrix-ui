// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_invitation_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallInvitationData _$CallInvitationDataFromJson(Map<String, dynamic> json) =>
    _CallInvitationData(
      callId: json['callId'] as String,
      channelId: json['channelId'] as String,
      callerId: json['callerId'] as String,
      callerName: json['callerName'] as String,
      callerAvatar: json['callerAvatar'] as String?,
      callType: json['callType'] as String,
    );

Map<String, dynamic> _$CallInvitationDataToJson(_CallInvitationData instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'channelId': instance.channelId,
      'callerId': instance.callerId,
      'callerName': instance.callerName,
      'callerAvatar': instance.callerAvatar,
      'callType': instance.callType,
    };
