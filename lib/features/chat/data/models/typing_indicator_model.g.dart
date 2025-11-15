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
  conversationId: json['conversationId'] as String,
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
      id: json['id'] as String,
      username: json['username'] as String,
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$TypingUserModelToJson(_TypingUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'fullName': instance.fullName,
    };
