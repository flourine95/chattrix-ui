import 'package:chattrix_ui/features/contacts/domain/entities/friend_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_request_model.freezed.dart';
part 'friend_request_model.g.dart';

@freezed
abstract class FriendRequestModel with _$FriendRequestModel {
  const FriendRequestModel._();

  const factory FriendRequestModel({
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
  }) = _FriendRequestModel;

  factory FriendRequestModel.fromJson(Map<String, dynamic> json) => _$FriendRequestModelFromJson(json);

  FriendRequest toEntity() {
    return FriendRequest(
      id: id,
      senderUserId: senderUserId,
      receiverUserId: receiverUserId,
      senderUsername: senderUsername,
      senderFullName: senderFullName,
      senderAvatarUrl: senderAvatarUrl,
      receiverUsername: receiverUsername,
      receiverFullName: receiverFullName,
      receiverAvatarUrl: receiverAvatarUrl,
      nickname: nickname,
      status: status,
      createdAt: createdAt,
      respondedAt: respondedAt,
    );
  }
}
