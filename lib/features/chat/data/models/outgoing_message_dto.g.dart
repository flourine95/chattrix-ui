// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'outgoing_message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OutgoingMessageDto _$OutgoingMessageDtoFromJson(Map<String, dynamic> json) =>
    _OutgoingMessageDto(
      id: (json['id'] as num).toInt(),
      conversationId: (json['conversationId'] as num).toInt(),
      sender: MessageSenderDto.fromJson(json['sender'] as Map<String, dynamic>),
      content: json['content'] as String,
      type: json['type'] as String,
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
      mentionedUsers: (json['mentionedUsers'] as List<dynamic>?)
          ?.map((e) => MentionedUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OutgoingMessageDtoToJson(_OutgoingMessageDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'sender': instance.sender,
      'content': instance.content,
      'type': instance.type,
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
    };

_MessageSenderDto _$MessageSenderDtoFromJson(Map<String, dynamic> json) =>
    _MessageSenderDto(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$MessageSenderDtoToJson(_MessageSenderDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'fullName': instance.fullName,
      'avatarUrl': instance.avatarUrl,
    };
