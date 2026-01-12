import 'package:freezed_annotation/freezed_annotation.dart';

part 'birthday.freezed.dart';

/// Domain entity for birthday
/// Framework-agnostic - NO Flutter/Dio/json_annotation imports
@freezed
abstract class Birthday with _$Birthday {
  const factory Birthday({
    required int userId,
    required String username,
    required String fullName,
    String? avatarUrl,
    required DateTime dateOfBirth,
    required int age,
    required String birthdayMessage,
  }) = _Birthday;
}

/// Domain entity for send birthday wishes response
@freezed
abstract class SendBirthdayWishes with _$SendBirthdayWishes {
  const factory SendBirthdayWishes({required int conversationCount, required int userId}) = _SendBirthdayWishes;
}
