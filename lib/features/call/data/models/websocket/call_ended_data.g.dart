// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_ended_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallEndedData _$CallEndedDataFromJson(Map<String, dynamic> json) =>
    _CallEndedData(
      callId: json['callId'] as String,
      endedBy: json['endedBy'] as String,
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CallEndedDataToJson(_CallEndedData instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'endedBy': instance.endedBy,
      'durationSeconds': instance.durationSeconds,
    };
