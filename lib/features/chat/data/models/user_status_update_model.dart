import 'package:chattrix_ui/features/chat/domain/entities/user_status_update.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_status_update_model.freezed.dart';
part 'user_status_update_model.g.dart';

/// Model for user status update (extends entity)
@freezed
abstract class UserStatusUpdateModel with _$UserStatusUpdateModel {
  const UserStatusUpdateModel._();

  const factory UserStatusUpdateModel({
    required String userId,
    required String username,
    required String displayName,
    required bool isOnline,
    String? lastSeen,
  }) = _UserStatusUpdateModel;

  /// Convert from JSON
  factory UserStatusUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$UserStatusUpdateModelFromJson(json);

  /// Convert to entity
  UserStatusUpdate toEntity() {
    return UserStatusUpdate(
      userId: userId,
      username: username,
      displayName: displayName,
      isOnline: isOnline,
      lastSeen: lastSeen,
    );
  }
}
