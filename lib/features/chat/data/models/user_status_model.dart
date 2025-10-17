import 'package:chattrix_ui/features/chat/domain/entities/user_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_status_model.freezed.dart';
part 'user_status_model.g.dart';

@freezed
abstract class UserStatusModel with _$UserStatusModel {
  const UserStatusModel._();

  const factory UserStatusModel({
    required int userId,
    required bool isOnline,
    required int activeSessionCount,
  }) = _UserStatusModel;

  factory UserStatusModel.fromJson(Map<String, dynamic> json) =>
      _$UserStatusModelFromJson(json);

  UserStatus toEntity() {
    return UserStatus(
      userId: userId,
      isOnline: isOnline,
      activeSessionCount: activeSessionCount,
    );
  }
}
