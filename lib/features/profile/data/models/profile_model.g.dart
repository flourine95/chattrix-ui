// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) =>
    _ProfileModel(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      bio: json['bio'] as String?,
      phone: json['phone'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      gender: $enumDecodeNullable(
        _$GenderEnumMap,
        json['gender'],
        unknownValue: Gender.other,
      ),
      location: json['location'] as String?,
      profileVisibility: $enumDecodeNullable(
        _$ProfileVisibilityEnumMap,
        json['profileVisibility'],
      ),
      isEmailVerified: json['isEmailVerified'] as bool,
      isOnline: json['isOnline'] as bool,
      lastSeen: DateTime.parse(json['lastSeen'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ProfileModelToJson(
  _ProfileModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'fullName': instance.fullName,
  'avatarUrl': instance.avatarUrl,
  'bio': instance.bio,
  'phone': instance.phone,
  'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
  'gender': _$GenderEnumMap[instance.gender],
  'location': instance.location,
  'profileVisibility': _$ProfileVisibilityEnumMap[instance.profileVisibility],
  'isEmailVerified': instance.isEmailVerified,
  'isOnline': instance.isOnline,
  'lastSeen': instance.lastSeen.toIso8601String(),
  'createdAt': instance.createdAt?.toIso8601String(),
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
