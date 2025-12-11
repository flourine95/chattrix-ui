import 'package:chattrix_ui/features/profile/domain/entities/gender.dart';
import 'package:chattrix_ui/features/profile/domain/entities/profile_visibility.dart';
import 'package:chattrix_ui/features/profile/domain/entities/update_profile_params.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_request.freezed.dart';
part 'update_profile_request.g.dart';

@freezed
abstract class UpdateProfileRequest with _$UpdateProfileRequest {
  const UpdateProfileRequest._();

  const factory UpdateProfileRequest({
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
  }) = _UpdateProfileRequest;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  factory UpdateProfileRequest.fromParams(UpdateProfileParams params) {
    return UpdateProfileRequest(
      username: params.username,
      email: params.email,
      fullName: params.fullName,
      phone: params.phone,
      bio: params.bio,
      dateOfBirth: params.dateOfBirth?.toUtc(),
      gender: params.gender,
      location: params.location,
      profileVisibility: params.profileVisibility,
      avatarUrl: params.avatarUrl,
    );
  }
}