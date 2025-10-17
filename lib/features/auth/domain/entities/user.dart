import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required int id,
    required String username,
    required String email,
    required String fullName,
    String? avatarUrl,
    required bool isOnline,
    required DateTime lastSeen,
  }) = _User;
}
