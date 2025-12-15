import 'package:chattrix_ui/features/contacts/domain/entities/friend_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_request_model.freezed.dart';
part 'friend_request_model.g.dart';

@freezed
abstract class FriendRequestModel with _$FriendRequestModel {
  const FriendRequestModel._();

  const factory FriendRequestModel({
    required int id,
    required int userId, // Sender khi received, Receiver khi sent
    required String username,
    required String fullName,
    String? avatarUrl,
    String? nickname,
    required FriendRequestStatus status,
    @Default(false) bool online,
    required DateTime requestedAt,
    DateTime? acceptedAt,
    DateTime? rejectedAt,
  }) = _FriendRequestModel;

  factory FriendRequestModel.fromJson(Map<String, dynamic> json) => _$FriendRequestModelFromJson(json);

  // Convert model to entity (adapt structure for domain layer)
  FriendRequest toEntityAsReceived(int currentUserId) {
    // When received: userId is sender, currentUserId is receiver
    return FriendRequest(
      id: id,
      senderUserId: userId,
      receiverUserId: currentUserId,
      senderUsername: username,
      senderFullName: fullName,
      senderAvatarUrl: avatarUrl,
      receiverUsername: '', // Not provided
      receiverFullName: '', // Not provided
      receiverAvatarUrl: null,
      nickname: nickname,
      status: status,
      createdAt: requestedAt,
      respondedAt: acceptedAt ?? rejectedAt,
    );
  }

  FriendRequest toEntityAsSent(int currentUserId) {
    // When sent: userId is receiver, currentUserId is sender
    return FriendRequest(
      id: id,
      senderUserId: currentUserId,
      receiverUserId: userId,
      senderUsername: '', // Not provided
      senderFullName: '', // Not provided
      senderAvatarUrl: null,
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
