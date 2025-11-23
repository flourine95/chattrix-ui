// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_accepted_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallAcceptedData _$CallAcceptedDataFromJson(Map<String, dynamic> json) =>
    _CallAcceptedData(
      callId: json['callId'] as String,
      acceptedBy: json['acceptedBy'] as String,
    );

Map<String, dynamic> _$CallAcceptedDataToJson(_CallAcceptedData instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'acceptedBy': instance.acceptedBy,
    };
