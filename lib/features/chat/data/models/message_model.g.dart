// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageModel _$MessageModelFromJson(Map<String, dynamic> json) =>
    _MessageModel(
      id: (json['id'] as num).toInt(),
      conversationId: (json['conversationId'] as num).toInt(),
      senderId: (json['senderId'] as num).toInt(),
      senderUsername: json['senderUsername'] as String?,
      senderFullName: json['senderFullName'] as String?,
      content: json['content'] as String,
      type: json['type'] as String,
      systemMessageType: json['systemMessageType'] as String?,
      createdAt: json['createdAt'] as String,
      mediaUrl: json['mediaUrl'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      fileName: json['fileName'] as String?,
      fileSize: (json['fileSize'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      locationName: json['locationName'] as String?,
      replyToMessageId: (json['replyToMessageId'] as num?)?.toInt(),
      replyToMessage: json['replyToMessage'] == null
          ? null
          : ReplyToMessageModel.fromJson(
              json['replyToMessage'] as Map<String, dynamic>,
            ),
      reactions: (json['reactions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          k,
          (e as List<dynamic>).map((e) => (e as num).toInt()).toList(),
        ),
      ),
      mentions: (json['mentions'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      mentionedUsers:
          (json['mentionedUsers'] as List<dynamic>?)
              ?.map(
                (e) => MentionedUserModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      sentAt: json['sentAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      edited: json['edited'] as bool? ?? false,
      editedAt: json['editedAt'] as String?,
      deleted: json['deleted'] as bool? ?? false,
      deletedAt: json['deletedAt'] as String?,
      forwarded: json['forwarded'] as bool? ?? false,
      originalMessageId: (json['originalMessageId'] as num?)?.toInt(),
      forwardCount: (json['forwardCount'] as num?)?.toInt() ?? 0,
      readCount: (json['readCount'] as num?)?.toInt() ?? 0,
      readBy:
          (json['readBy'] as List<dynamic>?)
              ?.map((e) => ReadReceiptModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      scheduled: json['scheduled'] as bool? ?? false,
      scheduledTime: json['scheduledTime'] as String?,
      scheduledStatus: json['scheduledStatus'] as String?,
    );

Map<String, dynamic> _$MessageModelToJson(_MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'senderId': instance.senderId,
      'senderUsername': instance.senderUsername,
      'senderFullName': instance.senderFullName,
      'content': instance.content,
      'type': instance.type,
      'systemMessageType': instance.systemMessageType,
      'createdAt': instance.createdAt,
      'mediaUrl': instance.mediaUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'fileName': instance.fileName,
      'fileSize': instance.fileSize,
      'duration': instance.duration,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'locationName': instance.locationName,
      'replyToMessageId': instance.replyToMessageId,
      'replyToMessage': instance.replyToMessage,
      'reactions': instance.reactions,
      'mentions': instance.mentions,
      'mentionedUsers': instance.mentionedUsers,
      'sentAt': instance.sentAt,
      'updatedAt': instance.updatedAt,
      'edited': instance.edited,
      'editedAt': instance.editedAt,
      'deleted': instance.deleted,
      'deletedAt': instance.deletedAt,
      'forwarded': instance.forwarded,
      'originalMessageId': instance.originalMessageId,
      'forwardCount': instance.forwardCount,
      'readCount': instance.readCount,
      'readBy': instance.readBy,
      'scheduled': instance.scheduled,
      'scheduledTime': instance.scheduledTime,
      'scheduledStatus': instance.scheduledStatus,
    };
