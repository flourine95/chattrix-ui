// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallHistoryModel _$CallHistoryModelFromJson(Map<String, dynamic> json) =>
    _CallHistoryModel(
      id: json['id'] as String,
      remoteUserId: json['remoteUserId'] as String,
      remoteUserName: json['remoteUserName'] as String,
      callType: json['callType'] as String,
      status: json['status'] as String,
      timestamp: json['timestamp'] as String,
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CallHistoryModelToJson(_CallHistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'remoteUserId': instance.remoteUserId,
      'remoteUserName': instance.remoteUserName,
      'callType': instance.callType,
      'status': instance.status,
      'timestamp': instance.timestamp,
      'durationSeconds': instance.durationSeconds,
    };
