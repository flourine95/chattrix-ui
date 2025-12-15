// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'reply_to_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReplyToMessageModel _$ReplyToMessageModelFromJson(Map<String, dynamic> json) =>
    _ReplyToMessageModel(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      senderId: (json['senderId'] as num).toInt(),
      senderUsername: json['senderUsername'] as String,
    );

Map<String, dynamic> _$ReplyToMessageModelToJson(
  _ReplyToMessageModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'senderId': instance.senderId,
  'senderUsername': instance.senderUsername,
};
