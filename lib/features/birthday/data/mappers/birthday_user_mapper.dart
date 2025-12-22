import '../models/birthday_user_dto.dart';
import '../../domain/entities/birthday_user_entity.dart';

extension BirthdayUserDtoMapper on BirthdayUserDto {
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
