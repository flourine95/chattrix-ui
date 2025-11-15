import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_request.freezed.dart';

@freezed
abstract class FriendRequest with _$FriendRequest {
  const factory FriendRequest({
    required int id,
    required int senderUserId,
    required int receiverUserId,
    required String senderUsername,
    required String senderFullName,
    String? senderAvatarUrl,
    required String receiverUsername,
    required String receiverFullName,
    String? receiverAvatarUrl,
    String? nickname,
    required FriendRequestStatus status,
    required DateTime createdAt,
    DateTime? respondedAt,
  }) = _FriendRequest;
}

enum FriendRequestStatus { pending, accepted, rejected, cancelled }
