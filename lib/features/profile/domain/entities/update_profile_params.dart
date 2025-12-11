import 'package:chattrix_ui/features/profile/domain/entities/gender.dart';
import 'package:chattrix_ui/features/profile/domain/entities/profile_visibility.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_params.freezed.dart';

@freezed
abstract class UpdateProfileParams with _$UpdateProfileParams {
  const factory UpdateProfileParams({
    String? username,
    String? email,
    String? fullName,
    String? phone,
    String? bio,
    DateTime? dateOfBirth,
    Gender? gender,
    String? location,
    ProfileVisibility? profileVisibility,
    String? avatarUrl,
  }) = _UpdateProfileParams;
}
