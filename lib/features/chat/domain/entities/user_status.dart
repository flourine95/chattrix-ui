import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_status.freezed.dart';

@freezed
abstract class UserStatus with _$UserStatus {
  const factory UserStatus({
    required int userId,
    required bool isOnline,
    required int activeSessionCount,
  }) = _UserStatus;
}
