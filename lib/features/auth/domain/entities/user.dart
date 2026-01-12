import 'package:chattrix_ui/core/domain/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required int id,
    required String username,
    required String email,
    required bool emailVerified,
    String? phone,
    required String fullName,
    String? avatarUrl,
    String? bio,
    Gender? gender,
    DateTime? dateOfBirth,
    String? location,
    ProfileVisibility? profileVisibility,
    required bool online,
    DateTime? lastSeen,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _User;
}
