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
      mediaUrl: json['mediaUrl'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      fileName: json['fileName'] as String?,
      fileSize: (json['fileSize'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      locationName: json['locationName'] as String?,
      replyToMessageId: (json['replyToMessageId'] as num?)?.toInt(),
      reactions: json['reactions'] as String?,
      mentions: json['mentions'] as String?,
    );

Map<String, dynamic> _$MessageModelToJson(_MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'type': instance.type,
      'createdAt': instance.createdAt,
      'conversationId': instance.conversationId,
      'sender': instance.sender,
      'mediaUrl': instance.mediaUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'fileName': instance.fileName,
      'fileSize': instance.fileSize,
      'duration': instance.duration,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'locationName': instance.locationName,
      'replyToMessageId': instance.replyToMessageId,
      'reactions': instance.reactions,
      'mentions': instance.mentions,
    };
