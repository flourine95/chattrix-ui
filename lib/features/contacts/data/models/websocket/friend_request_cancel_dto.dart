import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_request_cancel_dto.freezed.dart';
part 'friend_request_cancel_dto.g.dart';

/// WebSocket payload for friend request cancelled (event: friend.request.cancelled)
@freezed
abstract class FriendRequestCancelDto with _$FriendRequestCancelDto {
  const factory FriendRequestCancelDto({
    required int requestId,
    required int cancelledBy,
  }) = _FriendRequestCancelDto;

  factory FriendRequestCancelDto.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestCancelDtoFromJson(json);
}

