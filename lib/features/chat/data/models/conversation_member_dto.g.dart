// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'conversation_member_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConversationMemberDto _$ConversationMemberDtoFromJson(
  Map<String, dynamic> json,
) => _ConversationMemberDto(
  id: (json['id'] as num).toInt(),
  fullName: json['fullName'] as String,
  username: json['username'] as String,
  email: json['email'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  online: json['online'] as bool,
);

Map<String, dynamic> _$ConversationMemberDtoToJson(
  _ConversationMemberDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'username': instance.username,
  'email': instance.email,
  'avatarUrl': instance.avatarUrl,
  'online': instance.online,
};
