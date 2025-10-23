import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_status_update.freezed.dart';

/// Entity representing a user status update from WebSocket
@freezed
abstract class UserStatusUpdate with _$UserStatusUpdate {
  const UserStatusUpdate._();

  const factory UserStatusUpdate({
    required String userId,
    required String username,
    required String displayName,
    required bool isOnline,
    String? lastSeen,
  }) = _UserStatusUpdate;
}
