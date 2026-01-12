// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallParticipantModel _$CallParticipantModelFromJson(
  Map<String, dynamic> json,
) => _CallParticipantModel(
  userId: (json['userId'] as num).toInt(),
  fullName: json['fullName'] as String,
  avatar: json['avatar'] as String?,
  status: $enumDecode(_$CallParticipantStatusEnumMap, json['status']),
  joinedAt: json['joinedAt'] as String?,
);

Map<String, dynamic> _$CallParticipantModelToJson(
  _CallParticipantModel instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'fullName': instance.fullName,
  'avatar': instance.avatar,
  'status': _$CallParticipantStatusEnumMap[instance.status]!,
  'joinedAt': instance.joinedAt,
};

const _$CallParticipantStatusEnumMap = {
  CallParticipantStatus.ringing: 'RINGING',
  CallParticipantStatus.joined: 'JOINED',
  CallParticipantStatus.left: 'LEFT',
};
