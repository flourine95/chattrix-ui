import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/core/domain/enums/enums.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDto with _$UserDto {
  const UserDto._();

  const factory UserDto({
    required int id,
    required String username,
    required String email,
    required bool emailVerified,
    String? phone,
    required String fullName,
    String? avatarUrl,
    String? bio,
    String? gender,
    String? dateOfBirth,
    String? location,
    String? profileVisibility,
    String? lastSeen,
    required String createdAt,
    String? updatedAt,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  /// Convert DTO to domain entity
  User toEntity() {
    return User(
      id: id,
      username: username,
      email: email,
      emailVerified: emailVerified,
      phone: phone,
      fullName: fullName,
      avatarUrl: avatarUrl,
      bio: bio,
      gender: _parseGender(gender),
      dateOfBirth: dateOfBirth != null ? DateTime.tryParse(dateOfBirth!) : null,
      location: location,
      profileVisibility: _parseProfileVisibility(profileVisibility),
      lastSeen: lastSeen != null ? DateTime.tryParse(lastSeen!) : null,
      createdAt: DateTime.parse(createdAt),
      updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
    );
  }

  Gender? _parseGender(String? value) {
    if (value == null) return null;
    switch (value.toUpperCase()) {
      case 'MALE':
        return Gender.male;
      case 'FEMALE':
        return Gender.female;
      case 'OTHER':
        return Gender.other;
      default:
        return Gender.other;
    }
  }

  ProfileVisibility? _parseProfileVisibility(String? value) {
    if (value == null) return null;
    switch (value.toUpperCase()) {
      case 'PUBLIC':
        return ProfileVisibility.public;
      case 'FRIENDS_ONLY':
        return ProfileVisibility.friendsOnly;
      case 'PRIVATE':
        return ProfileVisibility.private;
      default:
        return ProfileVisibility.public;
    }
  }
}

