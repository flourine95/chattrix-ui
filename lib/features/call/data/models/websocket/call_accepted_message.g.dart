// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_accepted_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallAcceptedMessage _$CallAcceptedMessageFromJson(Map<String, dynamic> json) =>
    _CallAcceptedMessage(
      type: json['type'] as String,
      data: CallAcceptedData.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$CallAcceptedMessageToJson(
  _CallAcceptedMessage instance,
) => <String, dynamic>{
  'type': instance.type,
  'data': instance.data,
  'timestamp': instance.timestamp.toIso8601String(),
};
