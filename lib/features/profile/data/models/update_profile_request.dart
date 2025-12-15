import 'package:chattrix_ui/core/domain/enums/gender.dart';
import 'package:chattrix_ui/features/profile/domain/entities/update_profile_params.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_request.freezed.dart';
part 'update_profile_request.g.dart';

@freezed
abstract class UpdateProfileRequest with _$UpdateProfileRequest {
  const UpdateProfileRequest._();

  const factory UpdateProfileRequest({
    String? fullName,
    String? avatarUrl,
    String? phone,
    String? bio,
    String? dateOfBirth,
    @JsonKey(unknownEnumValue: Gender.other) Gender? gender,
    String? location,
  }) = _UpdateProfileRequest;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) => _$UpdateProfileRequestFromJson(json);

  factory UpdateProfileRequest.fromParams(UpdateProfileParams params) {
    return UpdateProfileRequest(
      fullName: params.fullName,
      avatarUrl: params.avatarUrl,
      phone: params.phone,
      bio: params.bio,
      dateOfBirth: params.dateOfBirth?.toIso8601String().split('T')[0],
      gender: params.gender,
      location: params.location,
    );
  }
}
