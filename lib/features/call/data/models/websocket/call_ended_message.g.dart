// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_ended_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallEndedMessage _$CallEndedMessageFromJson(Map<String, dynamic> json) =>
    _CallEndedMessage(
      type: json['type'] as String,
      data: CallEndedData.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$CallEndedMessageToJson(_CallEndedMessage instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
      'timestamp': instance.timestamp.toIso8601String(),
    };
