// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_invitation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallInvitationDto _$CallInvitationDtoFromJson(Map<String, dynamic> json) =>
    _CallInvitationDto(
      callId: json['callId'] as String,
      channelId: json['channelId'] as String,
      callerId: (json['callerId'] as num).toInt(),
      callerName: json['callerName'] as String,
      callerAvatar: json['callerAvatar'] as String?,
      callType: json['callType'] as String,
    );

Map<String, dynamic> _$CallInvitationDtoToJson(_CallInvitationDto instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'channelId': instance.channelId,
      'callerId': instance.callerId,
      'callerName': instance.callerName,
      'callerAvatar': instance.callerAvatar,
      'callType': instance.callType,
    };
