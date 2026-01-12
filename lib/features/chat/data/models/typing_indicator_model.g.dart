// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'typing_indicator_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TypingIndicatorModel _$TypingIndicatorModelFromJson(
  Map<String, dynamic> json,
) => _TypingIndicatorModel(
  conversationId: _conversationIdFromJson(json['conversationId']),
  typingUsers: (json['typingUsers'] as List<dynamic>)
      .map((e) => TypingUserModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TypingIndicatorModelToJson(
  _TypingIndicatorModel instance,
) => <String, dynamic>{
  'conversationId': instance.conversationId,
  'typingUsers': instance.typingUsers,
};

_TypingUserModel _$TypingUserModelFromJson(Map<String, dynamic> json) =>
    _TypingUserModel(
      id: _userIdFromJson(json['userId']),
      username: json['username'] as String,
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$TypingUserModelToJson(_TypingUserModel instance) =>
    <String, dynamic>{
      'userId': instance.id,
      'username': instance.username,
      'fullName': instance.fullName,
    };
