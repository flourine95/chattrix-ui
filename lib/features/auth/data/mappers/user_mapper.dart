import '../models/user_dto.dart';
import '../../domain/entities/user.dart';
import '../../../../core/domain/enums/enums.dart';

extension UserDtoMapper on UserDto {
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
      online: online,
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

extension UserEntityMapper on User {
  UserDto toDto() {
    return UserDto(
      id: id,
      username: username,
      email: email,
      emailVerified: emailVerified,
      phone: phone,
      fullName: fullName,
      avatarUrl: avatarUrl,
      bio: bio,
      gender: gender?.name.toUpperCase(),
      dateOfBirth: dateOfBirth?.toIso8601String(),
      location: location,
      profileVisibility: profileVisibility?.name.toUpperCase(),
      online: online,
      lastSeen: lastSeen?.toIso8601String(),
      createdAt: createdAt.toIso8601String(),
      updatedAt: updatedAt?.toIso8601String(),
    );
  }
}
