import 'package:chattrix_ui/features/profile/domain/entities/gender.dart';
import 'package:chattrix_ui/features/profile/domain/entities/profile.dart';
import 'package:chattrix_ui/features/profile/domain/entities/profile_visibility.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
abstract class ProfileModel with _$ProfileModel {
  const ProfileModel._();

  const factory ProfileModel({
    required int id,
    required String username,
    required String email,
    required String fullName,
    String? avatarUrl,
    String? bio,
    String? phone,
    DateTime? dateOfBirth,

    @JsonKey(unknownEnumValue: Gender.other) Gender? gender,

    String? location,

    ProfileVisibility? profileVisibility,

    required bool isEmailVerified,
    required bool isOnline,

    required DateTime lastSeen,
    DateTime? createdAt,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);

  Profile toEntity() {
    return Profile(
      id: id,
      username: username,
      email: email,
      fullName: fullName,
      avatarUrl: avatarUrl,
      bio: bio,
      phone: phone,
      dateOfBirth: dateOfBirth, // Không cần parse nữa
      gender: gender,
      location: location,
      profileVisibility: profileVisibility,
      isEmailVerified: isEmailVerified,
      isOnline: isOnline,
      lastSeen: lastSeen,       // Không cần parse nữa
      createdAt: createdAt,     // Không cần parse nữa
    );
  }
}