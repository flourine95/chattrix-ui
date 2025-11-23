// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_invitation_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallInvitationMessage _$CallInvitationMessageFromJson(
  Map<String, dynamic> json,
) => _CallInvitationMessage(
  type: json['type'] as String,
  data: CallInvitationData.fromJson(json['data'] as Map<String, dynamic>),
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$CallInvitationMessageToJson(
  _CallInvitationMessage instance,
) => <String, dynamic>{
  'type': instance.type,
  'data': instance.data,
  'timestamp': instance.timestamp.toIso8601String(),
};
