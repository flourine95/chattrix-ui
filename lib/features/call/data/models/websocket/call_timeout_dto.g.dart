// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_timeout_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallTimeoutDto _$CallTimeoutDtoFromJson(Map<String, dynamic> json) =>
    _CallTimeoutDto(
      callId: json['callId'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$CallTimeoutDtoToJson(_CallTimeoutDto instance) =>
    <String, dynamic>{'callId': instance.callId, 'reason': instance.reason};
