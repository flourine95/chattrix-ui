// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_reject_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallRejectDto _$CallRejectDtoFromJson(Map<String, dynamic> json) =>
    _CallRejectDto(
      callId: json['callId'] as String,
      rejectedBy: (json['rejectedBy'] as num).toInt(),
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$CallRejectDtoToJson(_CallRejectDto instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'rejectedBy': instance.rejectedBy,
      'reason': instance.reason,
    };
