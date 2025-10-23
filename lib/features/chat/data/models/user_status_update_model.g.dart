// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_status_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserStatusUpdateModel _$UserStatusUpdateModelFromJson(
  Map<String, dynamic> json,
) => _UserStatusUpdateModel(
  userId: json['userId'] as String,
  username: json['username'] as String,
  displayName: json['displayName'] as String,
  isOnline: json['isOnline'] as bool,
  lastSeen: json['lastSeen'] as String?,
);

Map<String, dynamic> _$UserStatusUpdateModelToJson(
  _UserStatusUpdateModel instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'username': instance.username,
  'displayName': instance.displayName,
  'isOnline': instance.isOnline,
  'lastSeen': instance.lastSeen,
};
