// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConversationUpdateModel _$ConversationUpdateModelFromJson(
  Map<String, dynamic> json,
) => _ConversationUpdateModel(
  conversationId: (json['conversationId'] as num).toInt(),
  updatedAt: json['updatedAt'] as String,
  lastMessage: json['lastMessage'] == null
      ? null
      : LastMessageInfoModel.fromJson(
          json['lastMessage'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ConversationUpdateModelToJson(
  _ConversationUpdateModel instance,
) => <String, dynamic>{
  'conversationId': instance.conversationId,
  'updatedAt': instance.updatedAt,
  'lastMessage': instance.lastMessage,
};

_LastMessageInfoModel _$LastMessageInfoModelFromJson(
  Map<String, dynamic> json,
) => _LastMessageInfoModel(
  id: (json['id'] as num).toInt(),
  content: json['content'] as String,
  senderId: (json['senderId'] as num).toInt(),
  senderUsername: json['senderUsername'] as String,
  sentAt: json['sentAt'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$LastMessageInfoModelToJson(
  _LastMessageInfoModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'senderId': instance.senderId,
  'senderUsername': instance.senderUsername,
  'sentAt': instance.sentAt,
  'type': instance.type,
};
