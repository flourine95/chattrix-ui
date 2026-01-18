// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'user_status_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserStatusUpdateModel _$UserStatusUpdateModelFromJson(
  Map<String, dynamic> json,
) => _UserStatusUpdateModel(
  userId: (json['userId'] as num).toInt(),
  status: json['status'] as String,
  lastSeen: json['lastSeen'] as String?,
);

Map<String, dynamic> _$UserStatusUpdateModelToJson(
  _UserStatusUpdateModel instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'status': instance.status,
  'lastSeen': instance.lastSeen,
};
