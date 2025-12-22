import 'package:freezed_annotation/freezed_annotation.dart';

part 'birthday_user_dto.freezed.dart';
part 'birthday_user_dto.g.dart';

/// DTO for birthday user from API
@freezed
abstract class BirthdayUserDto with _$BirthdayUserDto {
  const factory BirthdayUserDto({
    required int userId,
    required String username,
    required String fullName,
    String? avatarUrl,
    DateTime? dateOfBirth,
    int? age,
    required String birthdayMessage,
  }) = _BirthdayUserDto;

  factory BirthdayUserDto.fromJson(Map<String, dynamic> json) => _$BirthdayUserDtoFromJson(json);
}
