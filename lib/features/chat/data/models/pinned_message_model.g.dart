// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'pinned_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PinnedMessageModel _$PinnedMessageModelFromJson(Map<String, dynamic> json) =>
    _PinnedMessageModel(
      id: (json['id'] as num).toInt(),
      conversationId: (json['conversationId'] as num).toInt(),
      senderId: (json['senderId'] as num).toInt(),
      senderUsername: json['senderUsername'] as String,
      senderFullName: json['senderFullName'] as String,
      content: json['content'] as String,
      type: json['type'] as String,
      reactions: json['reactions'] as Map<String, dynamic>? ?? const {},
      sentAt: DateTime.parse(json['sentAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      edited: json['edited'] as bool? ?? false,
      deleted: json['deleted'] as bool? ?? false,
      forwarded: json['forwarded'] as bool? ?? false,
      forwardCount: (json['forwardCount'] as num?)?.toInt() ?? 0,
      pinned: json['pinned'] as bool? ?? true,
      pinnedAt: json['pinnedAt'] == null
          ? null
          : DateTime.parse(json['pinnedAt'] as String),
      pinnedBy: (json['pinnedBy'] as num?)?.toInt(),
      pinnedByUsername: json['pinnedByUsername'] as String?,
      pinnedByFullName: json['pinnedByFullName'] as String?,
      scheduled: json['scheduled'] as bool? ?? false,
    );

Map<String, dynamic> _$PinnedMessageModelToJson(_PinnedMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'senderId': instance.senderId,
      'senderUsername': instance.senderUsername,
      'senderFullName': instance.senderFullName,
      'content': instance.content,
      'type': instance.type,
      'reactions': instance.reactions,
      'sentAt': instance.sentAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'edited': instance.edited,
      'deleted': instance.deleted,
      'forwarded': instance.forwarded,
      'forwardCount': instance.forwardCount,
      'pinned': instance.pinned,
      'pinnedAt': instance.pinnedAt?.toIso8601String(),
      'pinnedBy': instance.pinnedBy,
      'pinnedByUsername': instance.pinnedByUsername,
      'pinnedByFullName': instance.pinnedByFullName,
      'scheduled': instance.scheduled,
    };

_SearchMessagesRequest _$SearchMessagesRequestFromJson(
  Map<String, dynamic> json,
) => _SearchMessagesRequest(
  query: json['query'] as String,
  limit: (json['limit'] as num?)?.toInt(),
  cursor: json['cursor'] as String?,
);

Map<String, dynamic> _$SearchMessagesRequestToJson(
  _SearchMessagesRequest instance,
) => <String, dynamic>{
  'query': instance.query,
  'limit': instance.limit,
  'cursor': instance.cursor,
};

_SearchMediaRequest _$SearchMediaRequestFromJson(Map<String, dynamic> json) =>
    _SearchMediaRequest(
      type: json['type'] as String?,
      limit: (json['limit'] as num?)?.toInt(),
      cursor: json['cursor'] as String?,
    );

Map<String, dynamic> _$SearchMediaRequestToJson(_SearchMediaRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      'limit': instance.limit,
      'cursor': instance.cursor,
    };
