import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_note_entity.freezed.dart';

/// User note/story entity
///
/// Represents a short status update that appears above user's avatar
/// Similar to Instagram/Facebook Stories
@freezed
abstract class UserNoteEntity with _$UserNoteEntity {
  const factory UserNoteEntity({
    required String userId,
    required String content,
    required DateTime createdAt,
    DateTime? expiresAt,
  }) = _UserNoteEntity;
}
