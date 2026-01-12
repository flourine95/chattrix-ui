// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'conversation_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConversationUpdateDto _$ConversationUpdateDtoFromJson(
  Map<String, dynamic> json,
) => _ConversationUpdateDto(
  conversationId: (json['conversationId'] as num).toInt(),
  updatedAt: json['updatedAt'] as String,
  lastMessage: json['lastMessage'] == null
      ? null
      : LastMessageInfoDto.fromJson(
          json['lastMessage'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ConversationUpdateDtoToJson(
  _ConversationUpdateDto instance,
) => <String, dynamic>{
  'conversationId': instance.conversationId,
  'updatedAt': instance.updatedAt,
  'lastMessage': instance.lastMessage,
};

_LastMessageInfoDto _$LastMessageInfoDtoFromJson(Map<String, dynamic> json) =>
    _LastMessageInfoDto(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      senderId: (json['senderId'] as num).toInt(),
      senderUsername: json['senderUsername'] as String,
      sentAt: json['sentAt'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$LastMessageInfoDtoToJson(_LastMessageInfoDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'senderId': instance.senderId,
      'senderUsername': instance.senderUsername,
      'sentAt': instance.sentAt,
      'type': instance.type,
    };
