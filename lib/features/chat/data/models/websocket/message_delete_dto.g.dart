// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'message_delete_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageDeleteDto _$MessageDeleteDtoFromJson(Map<String, dynamic> json) =>
    _MessageDeleteDto(
      messageId: (json['messageId'] as num).toInt(),
      conversationId: (json['conversationId'] as num).toInt(),
    );

Map<String, dynamic> _$MessageDeleteDtoToJson(_MessageDeleteDto instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'conversationId': instance.conversationId,
    };
