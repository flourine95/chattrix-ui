// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_participant_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallParticipantUpdateModel _$CallParticipantUpdateModelFromJson(
  Map<String, dynamic> json,
) => _CallParticipantUpdateModel(
  callId: json['callId'] as String,
  userId: (json['userId'] as num).toInt(),
  fullName: json['fullName'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  status: $enumDecode(_$CallParticipantStatusEnumMap, json['status']),
);

Map<String, dynamic> _$CallParticipantUpdateModelToJson(
  _CallParticipantUpdateModel instance,
) => <String, dynamic>{
  'callId': instance.callId,
  'userId': instance.userId,
  'fullName': instance.fullName,
  'avatarUrl': instance.avatarUrl,
  'status': _$CallParticipantStatusEnumMap[instance.status]!,
};

const _$CallParticipantStatusEnumMap = {
  CallParticipantStatus.ringing: 'RINGING',
  CallParticipantStatus.joined: 'JOINED',
  CallParticipantStatus.left: 'LEFT',
};
