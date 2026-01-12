// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'birthday_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BirthdayUserDto _$BirthdayUserDtoFromJson(Map<String, dynamic> json) =>
    _BirthdayUserDto(
      userId: (json['userId'] as num).toInt(),
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      age: (json['age'] as num?)?.toInt(),
      birthdayMessage: json['birthdayMessage'] as String,
    );

Map<String, dynamic> _$BirthdayUserDtoToJson(_BirthdayUserDto instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'fullName': instance.fullName,
      'avatarUrl': instance.avatarUrl,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'age': instance.age,
      'birthdayMessage': instance.birthdayMessage,
    };
