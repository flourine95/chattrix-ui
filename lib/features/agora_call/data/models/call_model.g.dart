// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallModel _$CallModelFromJson(Map<String, dynamic> json) => _CallModel(
  id: json['id'] as String,
  channelId: json['channelId'] as String,
  status: json['status'] as String,
  callType: json['callType'] as String,
  callerId: (json['callerId'] as num).toInt(),
  callerName: json['callerName'] as String,
  callerAvatar: json['callerAvatar'] as String?,
  calleeId: (json['calleeId'] as num).toInt(),
  calleeName: json['calleeName'] as String,
  calleeAvatar: json['calleeAvatar'] as String?,
  createdAt: json['createdAt'] as String,
  durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
);

Map<String, dynamic> _$CallModelToJson(_CallModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'channelId': instance.channelId,
      'status': instance.status,
      'callType': instance.callType,
      'callerId': instance.callerId,
      'callerName': instance.callerName,
      'callerAvatar': instance.callerAvatar,
      'calleeId': instance.calleeId,
      'calleeName': instance.calleeName,
      'calleeAvatar': instance.calleeAvatar,
      'createdAt': instance.createdAt,
      'durationSeconds': instance.durationSeconds,
    };
