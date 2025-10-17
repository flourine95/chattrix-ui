// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserStatusModel _$UserStatusModelFromJson(Map<String, dynamic> json) =>
    _UserStatusModel(
      userId: (json['userId'] as num).toInt(),
      isOnline: json['isOnline'] as bool,
      activeSessionCount: (json['activeSessionCount'] as num).toInt(),
    );

Map<String, dynamic> _$UserStatusModelToJson(_UserStatusModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'isOnline': instance.isOnline,
      'activeSessionCount': instance.activeSessionCount,
    };
