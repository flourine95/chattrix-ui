// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_end_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallEndDto _$CallEndDtoFromJson(Map<String, dynamic> json) => _CallEndDto(
  callId: json['callId'] as String,
  endedBy: (json['endedBy'] as num).toInt(),
  durationSeconds: (json['durationSeconds'] as num).toInt(),
);

Map<String, dynamic> _$CallEndDtoToJson(_CallEndDto instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'endedBy': instance.endedBy,
      'durationSeconds': instance.durationSeconds,
    };
