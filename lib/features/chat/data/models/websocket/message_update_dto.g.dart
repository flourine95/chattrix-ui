// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'message_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageUpdateDto _$MessageUpdateDtoFromJson(Map<String, dynamic> json) =>
    _MessageUpdateDto(
      messageId: (json['messageId'] as num).toInt(),
      conversationId: (json['conversationId'] as num).toInt(),
      content: json['content'] as String,
      edited: json['edited'] as bool,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$MessageUpdateDtoToJson(_MessageUpdateDto instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'conversationId': instance.conversationId,
      'content': instance.content,
      'edited': instance.edited,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
