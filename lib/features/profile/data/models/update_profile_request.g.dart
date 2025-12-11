// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'update_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateProfileRequest _$UpdateProfileRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateProfileRequest(
  username: json['username'] as String?,
  email: json['email'] as String?,
  fullName: json['fullName'] as String?,
  phone: json['phone'] as String?,
  bio: json['bio'] as String?,
  dateOfBirth: json['dateOfBirth'] == null
      ? null
      : DateTime.parse(json['dateOfBirth'] as String),
  gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
  location: json['location'] as String?,
  profileVisibility: $enumDecodeNullable(
    _$ProfileVisibilityEnumMap,
    json['profileVisibility'],
  ),
  avatarUrl: json['avatarUrl'] as String?,
);

Map<String, dynamic> _$UpdateProfileRequestToJson(
  _UpdateProfileRequest instance,
) => <String, dynamic>{
  'username': instance.username,
  'email': instance.email,
  'fullName': instance.fullName,
  'phone': instance.phone,
  'bio': instance.bio,
  'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
  'gender': _$GenderEnumMap[instance.gender],
  'location': instance.location,
  'profileVisibility': _$ProfileVisibilityEnumMap[instance.profileVisibility],
  'avatarUrl': instance.avatarUrl,
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
