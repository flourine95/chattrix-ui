// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_quality_warning_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallQualityWarningMessage _$CallQualityWarningMessageFromJson(
  Map<String, dynamic> json,
) => _CallQualityWarningMessage(
  type: json['type'] as String,
  data: CallQualityWarningData.fromJson(json['data'] as Map<String, dynamic>),
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$CallQualityWarningMessageToJson(
  _CallQualityWarningMessage instance,
) => <String, dynamic>{
  'type': instance.type,
  'data': instance.data,
  'timestamp': instance.timestamp.toIso8601String(),
};
