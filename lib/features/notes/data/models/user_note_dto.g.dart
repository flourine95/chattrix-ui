// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'user_note_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserNoteDto _$UserNoteDtoFromJson(Map<String, dynamic> json) => _UserNoteDto(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  noteText: json['noteText'] as String,
  emoji: json['emoji'] as String?,
  createdAt: json['createdAt'] as String,
  expiresAt: json['expiresAt'] as String,
);

Map<String, dynamic> _$UserNoteDtoToJson(_UserNoteDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'noteText': instance.noteText,
      'emoji': instance.emoji,
      'createdAt': instance.createdAt,
      'expiresAt': instance.expiresAt,
    };
