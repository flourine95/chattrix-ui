// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_rejected_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallRejectedMessage _$CallRejectedMessageFromJson(Map<String, dynamic> json) =>
    _CallRejectedMessage(
      type: json['type'] as String,
      data: CallRejectedData.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$CallRejectedMessageToJson(
  _CallRejectedMessage instance,
) => <String, dynamic>{
  'type': instance.type,
  'data': instance.data,
  'timestamp': instance.timestamp.toIso8601String(),
};
