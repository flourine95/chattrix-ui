// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ParticipantModel _$ParticipantModelFromJson(Map<String, dynamic> json) =>
    _ParticipantModel(
      userId: (json['userId'] as num).toInt(),
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      role: json['role'] as String,
      email: json['email'] as String?,
      nickname: json['nickname'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      isOnline: json['isOnline'] as bool?,
      lastSeen: json['lastSeen'] as String?,
    );

Map<String, dynamic> _$ParticipantModelToJson(_ParticipantModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'fullName': instance.fullName,
      'role': instance.role,
      'email': instance.email,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'isOnline': instance.isOnline,
      'lastSeen': instance.lastSeen,
    };
