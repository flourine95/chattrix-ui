// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'friend_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FriendRequestModel _$FriendRequestModelFromJson(Map<String, dynamic> json) =>
    _FriendRequestModel(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      nickname: json['nickname'] as String?,
      status: $enumDecode(_$FriendRequestStatusEnumMap, json['status']),
      online: json['online'] as bool? ?? false,
      requestedAt: DateTime.parse(json['requestedAt'] as String),
      acceptedAt: json['acceptedAt'] == null
          ? null
          : DateTime.parse(json['acceptedAt'] as String),
      rejectedAt: json['rejectedAt'] == null
          ? null
          : DateTime.parse(json['rejectedAt'] as String),
    );

Map<String, dynamic> _$FriendRequestModelToJson(_FriendRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'username': instance.username,
      'fullName': instance.fullName,
      'avatarUrl': instance.avatarUrl,
      'nickname': instance.nickname,
      'status': _$FriendRequestStatusEnumMap[instance.status]!,
      'online': instance.online,
      'requestedAt': instance.requestedAt.toIso8601String(),
      'acceptedAt': instance.acceptedAt?.toIso8601String(),
      'rejectedAt': instance.rejectedAt?.toIso8601String(),
    };

const _$FriendRequestStatusEnumMap = {
  FriendRequestStatus.pending: 'PENDING',
  FriendRequestStatus.accepted: 'ACCEPTED',
  FriendRequestStatus.rejected: 'REJECTED',
  FriendRequestStatus.cancelled: 'CANCELLED',
};
