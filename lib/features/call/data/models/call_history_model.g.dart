// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallHistoryModel _$CallHistoryModelFromJson(Map<String, dynamic> json) =>
    _CallHistoryModel(
      id: json['id'] as String?,
      conversationId: (json['conversationId'] as num?)?.toInt(),
      callerId: (json['callerId'] as num?)?.toInt(),
      callerName: json['callerName'] as String?,
      callerAvatar: json['callerAvatar'] as String?,
      callType: json['callType'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CallHistoryModelToJson(_CallHistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'callerId': instance.callerId,
      'callerName': instance.callerName,
      'callerAvatar': instance.callerAvatar,
      'callType': instance.callType,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'durationSeconds': instance.durationSeconds,
    };
