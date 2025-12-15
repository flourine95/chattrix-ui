// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'user_note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserNoteModel _$UserNoteModelFromJson(Map<String, dynamic> json) =>
    _UserNoteModel(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      noteText: json['noteText'] as String,
      musicUrl: json['musicUrl'] as String?,
      musicTitle: json['musicTitle'] as String?,
      emoji: json['emoji'] as String?,
      createdAt: json['createdAt'] as String,
      expiresAt: json['expiresAt'] as String,
      replyCount: (json['replyCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$UserNoteModelToJson(_UserNoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'username': instance.username,
      'fullName': instance.fullName,
      'avatarUrl': instance.avatarUrl,
      'noteText': instance.noteText,
      'musicUrl': instance.musicUrl,
      'musicTitle': instance.musicTitle,
      'emoji': instance.emoji,
      'createdAt': instance.createdAt,
      'expiresAt': instance.expiresAt,
      'replyCount': instance.replyCount,
    };
