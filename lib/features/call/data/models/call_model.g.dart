// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallModel _$CallModelFromJson(Map<String, dynamic> json) => _CallModel(
  callId: json['callId'] as String,
  channelId: json['channelId'] as String,
  localUserId: json['localUserId'] as String,
  remoteUserId: json['remoteUserId'] as String,
  callType: json['callType'] as String,
  status: json['status'] as String,
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String?,
  isLocalAudioMuted: json['isLocalAudioMuted'] as bool,
  isLocalVideoMuted: json['isLocalVideoMuted'] as bool,
  cameraFacing: json['cameraFacing'] as String,
  networkQuality: json['networkQuality'] as String?,
);

Map<String, dynamic> _$CallModelToJson(_CallModel instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'channelId': instance.channelId,
      'localUserId': instance.localUserId,
      'remoteUserId': instance.remoteUserId,
      'callType': instance.callType,
      'status': instance.status,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'isLocalAudioMuted': instance.isLocalAudioMuted,
      'isLocalVideoMuted': instance.isLocalVideoMuted,
      'cameraFacing': instance.cameraFacing,
      'networkQuality': instance.networkQuality,
    };
