// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_end_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallEndModel _$CallEndModelFromJson(Map<String, dynamic> json) =>
    _CallEndModel(
      callId: json['callId'] as String,
      endedBy: (json['endedBy'] as num).toInt(),
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CallEndModelToJson(_CallEndModel instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'endedBy': instance.endedBy,
      'durationSeconds': instance.durationSeconds,
    };
