// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'reaction_event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReactionEventDto _$ReactionEventDtoFromJson(Map<String, dynamic> json) =>
    _ReactionEventDto(
      messageId: (json['messageId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      userName: json['userName'] as String,
      emoji: json['emoji'] as String,
      action: json['action'] as String,
      reactions: (json['reactions'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
          k,
          (e as List<dynamic>).map((e) => (e as num).toInt()).toList(),
        ),
      ),
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$ReactionEventDtoToJson(_ReactionEventDto instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'userId': instance.userId,
      'userName': instance.userName,
      'emoji': instance.emoji,
      'action': instance.action,
      'reactions': instance.reactions,
      'timestamp': instance.timestamp,
    };
