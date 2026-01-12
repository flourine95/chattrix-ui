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
      conversationId: (json['conversationId'] as num).toInt(),
      status: $enumDecode(_$CallStatusEnumMap, json['status']),
      callType: $enumDecode(_$CallTypeEnumMap, json['callType']),
      callerId: (json['callerId'] as num).toInt(),
      callerName: json['callerName'] as String,
      callerAvatar: json['callerAvatar'] as String?,
      createdAt: json['createdAt'] as String,
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => CallParticipantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CallInfoModelToJson(_CallInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'channelId': instance.channelId,
      'conversationId': instance.conversationId,
      'status': _$CallStatusEnumMap[instance.status]!,
      'callType': _$CallTypeEnumMap[instance.callType]!,
      'callerId': instance.callerId,
      'callerName': instance.callerName,
      'callerAvatar': instance.callerAvatar,
      'createdAt': instance.createdAt,
      'durationSeconds': instance.durationSeconds,
      'participants': instance.participants,
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
