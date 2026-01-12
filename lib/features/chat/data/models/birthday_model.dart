import 'package:freezed_annotation/freezed_annotation.dart';

part 'birthday_model.freezed.dart';
part 'birthday_model.g.dart';

@freezed
abstract class BirthdayModel with _$BirthdayModel {
  const factory BirthdayModel({
    required int userId,
    required String username,
    required String fullName,
    String? avatarUrl,
    required DateTime dateOfBirth,
    required int age,
    required String birthdayMessage,
  }) = _BirthdayModel;

  factory BirthdayModel.fromJson(Map<String, dynamic> json) => _$BirthdayModelFromJson(json);
}

@freezed
abstract class SendBirthdayWishesRequest with _$SendBirthdayWishesRequest {
  const factory SendBirthdayWishesRequest({
    required int userId,
    required List<int> conversationIds,
    String? customMessage,
  }) = _SendBirthdayWishesRequest;

  factory SendBirthdayWishesRequest.fromJson(Map<String, dynamic> json) => _$SendBirthdayWishesRequestFromJson(json);
}

@freezed
abstract class SendBirthdayWishesResponse with _$SendBirthdayWishesResponse {
  const factory SendBirthdayWishesResponse({required int conversationCount, required int userId}) =
      _SendBirthdayWishesResponse;

  factory SendBirthdayWishesResponse.fromJson(Map<String, dynamic> json) => _$SendBirthdayWishesResponseFromJson(json);
}
