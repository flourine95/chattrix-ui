// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'announcement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnnouncementModel _$AnnouncementModelFromJson(Map<String, dynamic> json) =>
    _AnnouncementModel(
      id: (json['id'] as num).toInt(),
      conversationId: (json['conversationId'] as num).toInt(),
      senderId: (json['senderId'] as num).toInt(),
      senderUsername: json['senderUsername'] as String?,
      senderFullName: json['senderFullName'] as String?,
      content: json['content'] as String,
      type: json['type'] as String,
      reactions: (json['reactions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          k,
          (e as List<dynamic>).map((e) => (e as num).toInt()).toList(),
        ),
      ),
      sentAt: json['sentAt'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String?,
      edited: json['edited'] as bool? ?? false,
      deleted: json['deleted'] as bool? ?? false,
      forwarded: json['forwarded'] as bool? ?? false,
      forwardCount: (json['forwardCount'] as num?)?.toInt() ?? 0,
      scheduled: json['scheduled'] as bool? ?? false,
    );

Map<String, dynamic> _$AnnouncementModelToJson(_AnnouncementModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'senderId': instance.senderId,
      'senderUsername': instance.senderUsername,
      'senderFullName': instance.senderFullName,
      'content': instance.content,
      'type': instance.type,
      'reactions': instance.reactions,
      'sentAt': instance.sentAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'edited': instance.edited,
      'deleted': instance.deleted,
      'forwarded': instance.forwarded,
      'forwardCount': instance.forwardCount,
      'scheduled': instance.scheduled,
    };
