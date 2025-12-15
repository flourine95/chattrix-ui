import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_params.freezed.dart';

/// Parameters for updating user profile
/// Only updatable fields: fullName, avatarUrl, phone, bio, dateOfBirth, gender, location
@freezed
abstract class UpdateProfileParams with _$UpdateProfileParams {
  const factory UpdateProfileParams({
    String? fullName,
    String? avatarUrl,
    String? phone,
    String? bio,
    DateTime? dateOfBirth,
    String? gender, // MALE, FEMALE, OTHER
    String? location,
  }) = _UpdateProfileParams;
}
