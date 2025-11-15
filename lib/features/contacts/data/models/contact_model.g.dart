// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContactModel _$ContactModelFromJson(Map<String, dynamic> json) =>
    _ContactModel(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      username: json['username'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      nickname: json['nickname'] as String?,
      isOnline: json['isOnline'] as bool,
      lastSeen: DateTime.parse(json['lastSeen'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ContactModelToJson(_ContactModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'username': instance.username,
      'email': instance.email,
      'fullName': instance.fullName,
      'avatarUrl': instance.avatarUrl,
      'nickname': instance.nickname,
      'isOnline': instance.isOnline,
      'lastSeen': instance.lastSeen.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };
