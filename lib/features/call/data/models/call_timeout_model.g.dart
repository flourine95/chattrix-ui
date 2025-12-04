// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_timeout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallTimeoutModel _$CallTimeoutModelFromJson(Map<String, dynamic> json) =>
    _CallTimeoutModel(
      callId: json['callId'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$CallTimeoutModelToJson(_CallTimeoutModel instance) =>
    <String, dynamic>{'callId': instance.callId, 'reason': instance.reason};
