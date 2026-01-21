import 'package:chattrix_ui/features/birthday/domain/entities/birthday_user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'birthday_user_dto.freezed.dart';
part 'birthday_user_dto.g.dart';

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

  const BirthdayUserDto._();

  factory BirthdayUserDto.fromJson(Map<String, dynamic> json) => _$BirthdayUserDtoFromJson(json);

  BirthdayUserEntity toEntity() {
    return BirthdayUserEntity(
      userId: userId,
      username: username,
      fullName: fullName,
      avatarUrl: avatarUrl,
      dateOfBirth: dateOfBirth,
      age: age,
      birthdayMessage: birthdayMessage,
    );
  }
}
