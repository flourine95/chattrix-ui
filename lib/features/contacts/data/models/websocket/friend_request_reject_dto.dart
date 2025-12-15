import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_request_reject_dto.freezed.dart';
part 'friend_request_reject_dto.g.dart';

/// WebSocket payload for friend request rejected (event: friend.request.rejected)
@freezed
abstract class FriendRequestRejectDto with _$FriendRequestRejectDto {
  const factory FriendRequestRejectDto({
    required int requestId,
    required int rejectedBy,
  }) = _FriendRequestRejectDto;

  factory FriendRequestRejectDto.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestRejectDtoFromJson(json);
}

