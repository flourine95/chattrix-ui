import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDto with _$UserDto {
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
    required bool online,
    String? lastSeen,
    required String createdAt,
    String? updatedAt,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
}
