import 'package:chattrix_ui/core/domain/enums/gender.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_params.freezed.dart';

@freezed
abstract class UpdateProfileParams with _$UpdateProfileParams {
  const factory UpdateProfileParams({
    String? fullName,
    String? avatarUrl,
    String? phone,
    String? bio,
    DateTime? dateOfBirth,
    Gender? gender,
    String? location,
  }) = _UpdateProfileParams;
}
