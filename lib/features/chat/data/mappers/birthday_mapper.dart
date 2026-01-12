import '../models/birthday_model.dart';
import '../../domain/entities/birthday.dart';

extension BirthdayModelMapper on BirthdayModel {
  Birthday toEntity() {
    return Birthday(
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

extension SendBirthdayWishesResponseMapper on SendBirthdayWishesResponse {
  SendBirthdayWishes toEntity() {
    return SendBirthdayWishes(conversationCount: conversationCount, userId: userId);
  }
}
