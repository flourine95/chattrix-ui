import 'package:chattrix_ui/features/profile/domain/entities/gender.dart';
import 'package:chattrix_ui/features/profile/domain/entities/profile_visibility.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';

@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    required int id,
    required String username,
    required String email,
    required String fullName,
    String? avatarUrl,
    String? bio,
    String? phone,
    DateTime? dateOfBirth,
    Gender? gender,
    String? location,
    ProfileVisibility? profileVisibility,
    required bool isEmailVerified,
    required bool isOnline,
    required DateTime lastSeen,
    DateTime? createdAt,
  }) = _Profile;
}
