// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'friend_request_reject_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FriendRequestRejectDto _$FriendRequestRejectDtoFromJson(
  Map<String, dynamic> json,
) => _FriendRequestRejectDto(
  requestId: (json['requestId'] as num).toInt(),
  rejectedBy: (json['rejectedBy'] as num).toInt(),
);

Map<String, dynamic> _$FriendRequestRejectDtoToJson(
  _FriendRequestRejectDto instance,
) => <String, dynamic>{
  'requestId': instance.requestId,
  'rejectedBy': instance.rejectedBy,
};
