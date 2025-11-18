import 'package:chattrix_ui/features/contacts/domain/entities/friend_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_request_model.freezed.dart';
part 'friend_request_model.g.dart';

@freezed
abstract class FriendRequestModel with _$FriendRequestModel {
  const FriendRequestModel._();

  const factory FriendRequestModel({
    required int id,
    required int userId,
    required String username,
    required String fullName,
    String? avatarUrl,
    String? nickname,
    required FriendRequestStatus status,
    required DateTime requestedAt,
    DateTime? acceptedAt,
    DateTime? rejectedAt,
    @Default(false) bool online,
  }) = _FriendRequestModel;

  factory FriendRequestModel.fromJson(Map<String, dynamic> json) => _$FriendRequestModelFromJson(json);

  FriendRequest toEntity() {
    return FriendRequest(
      id: id,
      senderUserId: userId,
      receiverUserId: userId,
      senderUsername: username,
      senderFullName: fullName,
      senderAvatarUrl: avatarUrl,
      receiverUsername: username,
      receiverFullName: fullName,
      receiverAvatarUrl: avatarUrl,
      nickname: nickname,
      status: status,
      createdAt: requestedAt,
      respondedAt: acceptedAt ?? rejectedAt,
    );
  }
}
