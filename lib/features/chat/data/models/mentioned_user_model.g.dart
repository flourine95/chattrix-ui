// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'mentioned_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MentionedUserModel _$MentionedUserModelFromJson(Map<String, dynamic> json) =>
    _MentionedUserModel(
      userId: (json['userId'] as num).toInt(),
      username: json['username'] as String,
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$MentionedUserModelToJson(_MentionedUserModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'fullName': instance.fullName,
    };
