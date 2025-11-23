// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_rejected_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallRejectedData _$CallRejectedDataFromJson(Map<String, dynamic> json) =>
    _CallRejectedData(
      callId: json['callId'] as String,
      rejectedBy: json['rejectedBy'] as String,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$CallRejectedDataToJson(_CallRejectedData instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'rejectedBy': instance.rejectedBy,
      'reason': instance.reason,
    };
