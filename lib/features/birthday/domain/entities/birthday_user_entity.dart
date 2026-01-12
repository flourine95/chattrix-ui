import 'package:freezed_annotation/freezed_annotation.dart';

part 'birthday_user_entity.freezed.dart';

/// Domain entity for birthday user
@freezed
abstract class BirthdayUserEntity with _$BirthdayUserEntity {
  const factory BirthdayUserEntity({
    required int userId,
    required String username,
    required String fullName,
    String? avatarUrl,
    DateTime? dateOfBirth,
    int? age,
    required String birthdayMessage,
  }) = _BirthdayUserEntity;
}

extension BirthdayUserEntityX on BirthdayUserEntity {
  bool get isBirthdayToday => birthdayMessage == 'Hôm nay';
}
