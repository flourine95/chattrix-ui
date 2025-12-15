// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  email: json['email'] as String,
  emailVerified: json['emailVerified'] as bool,
  phone: json['phone'] as String?,
  fullName: json['fullName'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  bio: json['bio'] as String?,
  gender: $enumDecodeNullable(
    _$GenderEnumMap,
    json['gender'],
    unknownValue: Gender.other,
  ),
  dateOfBirth: json['dateOfBirth'] == null
      ? null
      : DateTime.parse(json['dateOfBirth'] as String),
  location: json['location'] as String?,
  profileVisibility: $enumDecodeNullable(
    _$ProfileVisibilityEnumMap,
    json['profileVisibility'],
    unknownValue: ProfileVisibility.public,
  ),
  online: json['online'] as bool,
  lastSeen: json['lastSeen'] as String?,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$UserModelToJson(
  _UserModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'emailVerified': instance.emailVerified,
  'phone': instance.phone,
  'fullName': instance.fullName,
  'avatarUrl': instance.avatarUrl,
  'bio': instance.bio,
  'gender': _$GenderEnumMap[instance.gender],
  'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
  'location': instance.location,
  'profileVisibility': _$ProfileVisibilityEnumMap[instance.profileVisibility],
  'online': instance.online,
  'lastSeen': instance.lastSeen,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};

const _$GenderEnumMap = {
  Gender.male: 'MALE',
  Gender.female: 'FEMALE',
  Gender.other: 'OTHER',
};

const _$ProfileVisibilityEnumMap = {
  ProfileVisibility.public: 'PUBLIC',
  ProfileVisibility.friendsOnly: 'FRIENDS_ONLY',
  ProfileVisibility.private: 'PRIVATE',
};
