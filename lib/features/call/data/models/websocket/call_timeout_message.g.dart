// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_timeout_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallTimeoutMessage _$CallTimeoutMessageFromJson(Map<String, dynamic> json) =>
    _CallTimeoutMessage(
      type: json['type'] as String,
      data: CallTimeoutData.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$CallTimeoutMessageToJson(_CallTimeoutMessage instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
      'timestamp': instance.timestamp.toIso8601String(),
    };
