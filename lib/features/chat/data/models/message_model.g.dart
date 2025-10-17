// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageModel _$MessageModelFromJson(Map<String, dynamic> json) =>
    _MessageModel(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      type: json['type'] as String,
      createdAt: json['createdAt'] as String,
      conversationId: json['conversationId'] as String,
      sender: MessageSenderModel.fromJson(
        json['sender'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$MessageModelToJson(_MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'type': instance.type,
      'createdAt': instance.createdAt,
      'conversationId': instance.conversationId,
      'sender': instance.sender,
    };
