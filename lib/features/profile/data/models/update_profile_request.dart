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
    // Convert dateOfBirth to noon UTC to avoid timezone issues
    String? dateOfBirthString;
    if (params.dateOfBirth != null) {
      final date = params.dateOfBirth!;
      final noonUtc = DateTime.utc(date.year, date.month, date.day, 12, 0, 0);
      dateOfBirthString = noonUtc.toIso8601String();
    }

    return UpdateProfileRequest(
      fullName: params.fullName,
      avatarUrl: params.avatarUrl,
      phone: params.phone,
      bio: params.bio,
      dateOfBirth: dateOfBirthString,
      gender: params.gender,
      location: params.location,
    );
  }
}
