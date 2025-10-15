import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String id,
    required String username,
    required String email,
    required String fullName,
    String? avatarUrl,
    required bool isOnline,
    required String lastSeen,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  User toEntity() {
    return User(
      id: id,
      username: username,
      email: email,
      fullName: fullName,
      avatarUrl: avatarUrl,
      isOnline: isOnline,
      lastSeen: DateTime.parse(lastSeen),
    );
  }
}
