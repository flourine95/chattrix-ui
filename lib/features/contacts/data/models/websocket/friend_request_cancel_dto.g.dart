// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'friend_request_cancel_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FriendRequestCancelDto _$FriendRequestCancelDtoFromJson(
  Map<String, dynamic> json,
) => _FriendRequestCancelDto(
  requestId: (json['requestId'] as num).toInt(),
  cancelledBy: (json['cancelledBy'] as num).toInt(),
);

Map<String, dynamic> _$FriendRequestCancelDtoToJson(
  _FriendRequestCancelDto instance,
) => <String, dynamic>{
  'requestId': instance.requestId,
  'cancelledBy': instance.cancelledBy,
};
