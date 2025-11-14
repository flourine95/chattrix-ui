// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FriendRequestModel _$FriendRequestModelFromJson(Map<String, dynamic> json) =>
    _FriendRequestModel(
      id: (json['id'] as num).toInt(),
      senderUserId: (json['senderUserId'] as num).toInt(),
      receiverUserId: (json['receiverUserId'] as num).toInt(),
      senderUsername: json['senderUsername'] as String,
      senderFullName: json['senderFullName'] as String,
      senderAvatarUrl: json['senderAvatarUrl'] as String?,
      receiverUsername: json['receiverUsername'] as String,
      receiverFullName: json['receiverFullName'] as String,
      receiverAvatarUrl: json['receiverAvatarUrl'] as String?,
      nickname: json['nickname'] as String?,
      status: $enumDecode(_$FriendRequestStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      respondedAt: json['respondedAt'] == null
          ? null
          : DateTime.parse(json['respondedAt'] as String),
    );

Map<String, dynamic> _$FriendRequestModelToJson(_FriendRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderUserId': instance.senderUserId,
      'receiverUserId': instance.receiverUserId,
      'senderUsername': instance.senderUsername,
      'senderFullName': instance.senderFullName,
      'senderAvatarUrl': instance.senderAvatarUrl,
      'receiverUsername': instance.receiverUsername,
      'receiverFullName': instance.receiverFullName,
      'receiverAvatarUrl': instance.receiverAvatarUrl,
      'nickname': instance.nickname,
      'status': _$FriendRequestStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'respondedAt': instance.respondedAt?.toIso8601String(),
    };

const _$FriendRequestStatusEnumMap = {
  FriendRequestStatus.pending: 'pending',
  FriendRequestStatus.accepted: 'accepted',
  FriendRequestStatus.rejected: 'rejected',
  FriendRequestStatus.cancelled: 'cancelled',
};
