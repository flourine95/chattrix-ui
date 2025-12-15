// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_accept_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallAcceptDto _$CallAcceptDtoFromJson(Map<String, dynamic> json) =>
    _CallAcceptDto(
      callId: json['callId'] as String,
      acceptedBy: (json['acceptedBy'] as num).toInt(),
    );

Map<String, dynamic> _$CallAcceptDtoToJson(_CallAcceptDto instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'acceptedBy': instance.acceptedBy,
    };
