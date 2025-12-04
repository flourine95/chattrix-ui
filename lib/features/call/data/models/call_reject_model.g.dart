// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_reject_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallRejectModel _$CallRejectModelFromJson(Map<String, dynamic> json) =>
    _CallRejectModel(
      callId: json['callId'] as String,
      rejectedBy: (json['rejectedBy'] as num).toInt(),
      reason: $enumDecode(_$CallRejectReasonEnumMap, json['reason']),
    );

Map<String, dynamic> _$CallRejectModelToJson(_CallRejectModel instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'rejectedBy': instance.rejectedBy,
      'reason': _$CallRejectReasonEnumMap[instance.reason]!,
    };

const _$CallRejectReasonEnumMap = {
  CallRejectReason.busy: 'busy',
  CallRejectReason.declined: 'declined',
  CallRejectReason.unavailable: 'unavailable',
};
