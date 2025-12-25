// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'birthday_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BirthdayModel _$BirthdayModelFromJson(Map<String, dynamic> json) =>
    _BirthdayModel(
      userId: (json['userId'] as num).toInt(),
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      age: (json['age'] as num).toInt(),
      birthdayMessage: json['birthdayMessage'] as String,
    );

Map<String, dynamic> _$BirthdayModelToJson(_BirthdayModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'fullName': instance.fullName,
      'avatarUrl': instance.avatarUrl,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'age': instance.age,
      'birthdayMessage': instance.birthdayMessage,
    };

_SendBirthdayWishesRequest _$SendBirthdayWishesRequestFromJson(
  Map<String, dynamic> json,
) => _SendBirthdayWishesRequest(
  userId: (json['userId'] as num).toInt(),
  conversationIds: (json['conversationIds'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  customMessage: json['customMessage'] as String?,
);

Map<String, dynamic> _$SendBirthdayWishesRequestToJson(
  _SendBirthdayWishesRequest instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'conversationIds': instance.conversationIds,
  'customMessage': instance.customMessage,
};

_SendBirthdayWishesResponse _$SendBirthdayWishesResponseFromJson(
  Map<String, dynamic> json,
) => _SendBirthdayWishesResponse(
  conversationCount: (json['conversationCount'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
);

Map<String, dynamic> _$SendBirthdayWishesResponseToJson(
  _SendBirthdayWishesResponse instance,
) => <String, dynamic>{
  'conversationCount': instance.conversationCount,
  'userId': instance.userId,
};
