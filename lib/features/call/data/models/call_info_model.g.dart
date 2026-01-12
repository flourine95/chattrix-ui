// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallInfoModel _$CallInfoModelFromJson(Map<String, dynamic> json) =>
    _CallInfoModel(
      id: json['id'] as String,
      channelId: json['channelId'] as String,
      status: $enumDecode(_$CallStatusEnumMap, json['status']),
      callType: $enumDecode(_$CallTypeEnumMap, json['callType']),
      callerId: (json['callerId'] as num).toInt(),
      callerName: json['callerName'] as String,
      callerAvatar: json['callerAvatar'] as String?,
      calleeId: (json['calleeId'] as num).toInt(),
      calleeName: json['calleeName'] as String,
      calleeAvatar: json['calleeAvatar'] as String?,
      createdAt: json['createdAt'] as String,
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CallInfoModelToJson(_CallInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'channelId': instance.channelId,
      'status': _$CallStatusEnumMap[instance.status]!,
      'callType': _$CallTypeEnumMap[instance.callType]!,
      'callerId': instance.callerId,
      'callerName': instance.callerName,
      'callerAvatar': instance.callerAvatar,
      'calleeId': instance.calleeId,
      'calleeName': instance.calleeName,
      'calleeAvatar': instance.calleeAvatar,
      'createdAt': instance.createdAt,
      'durationSeconds': instance.durationSeconds,
    };

const _$CallStatusEnumMap = {
  CallStatus.ringing: 'RINGING',
  CallStatus.connecting: 'CONNECTING',
  CallStatus.connected: 'CONNECTED',
  CallStatus.rejected: 'REJECTED',
  CallStatus.ended: 'ENDED',
  CallStatus.initiating: 'INITIATING',
};

const _$CallTypeEnumMap = {CallType.audio: 'AUDIO', CallType.video: 'VIDEO'};
