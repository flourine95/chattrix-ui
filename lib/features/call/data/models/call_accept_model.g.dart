// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_accept_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallAcceptModel _$CallAcceptModelFromJson(Map<String, dynamic> json) =>
    _CallAcceptModel(
      callId: json['callId'] as String,
      acceptedBy: (json['acceptedBy'] as num).toInt(),
    );

Map<String, dynamic> _$CallAcceptModelToJson(_CallAcceptModel instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'acceptedBy': instance.acceptedBy,
    };
