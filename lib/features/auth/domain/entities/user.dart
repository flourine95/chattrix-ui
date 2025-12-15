import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// User entity matching UserResponse schema from API
/// This replaces the old separate Profile concept
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
    String? gender, // MALE, FEMALE, OTHER
    DateTime? dateOfBirth,
    String? location,
    String? profileVisibility, // PUBLIC, FRIENDS_ONLY, PRIVATE
    required bool online,
    DateTime? lastSeen,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _User;
}
