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
  fullName: json['fullName'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  phone: json['phone'] as String?,
  bio: json['bio'] as String?,
  dateOfBirth: json['dateOfBirth'] as String?,
  gender: $enumDecodeNullable(
    _$GenderEnumMap,
    json['gender'],
    unknownValue: Gender.other,
  ),
  location: json['location'] as String?,
);

Map<String, dynamic> _$UpdateProfileRequestToJson(
  _UpdateProfileRequest instance,
) => <String, dynamic>{
  'fullName': instance.fullName,
  'avatarUrl': instance.avatarUrl,
  'phone': instance.phone,
  'bio': instance.bio,
  'dateOfBirth': instance.dateOfBirth,
  'gender': _$GenderEnumMap[instance.gender],
  'location': instance.location,
};

const _$GenderEnumMap = {
  Gender.male: 'MALE',
  Gender.female: 'FEMALE',
  Gender.other: 'OTHER',
};
