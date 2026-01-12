// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDto _$UserDtoFromJson(Map<String, dynamic> json) => _UserDto(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  email: json['email'] as String,
  emailVerified: json['emailVerified'] as bool,
  phone: json['phone'] as String?,
  fullName: json['fullName'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  bio: json['bio'] as String?,
  gender: json['gender'] as String?,
  dateOfBirth: json['dateOfBirth'] as String?,
  location: json['location'] as String?,
  profileVisibility: json['profileVisibility'] as String?,
  online: json['online'] as bool,
  lastSeen: json['lastSeen'] as String?,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$UserDtoToJson(_UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'emailVerified': instance.emailVerified,
  'phone': instance.phone,
  'fullName': instance.fullName,
  'avatarUrl': instance.avatarUrl,
  'bio': instance.bio,
  'gender': instance.gender,
  'dateOfBirth': instance.dateOfBirth,
  'location': instance.location,
  'profileVisibility': instance.profileVisibility,
  'online': instance.online,
  'lastSeen': instance.lastSeen,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
