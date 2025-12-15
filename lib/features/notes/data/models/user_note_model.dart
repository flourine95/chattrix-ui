import 'package:chattrix_ui/features/notes/domain/entities/user_note.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_note_model.freezed.dart';
part 'user_note_model.g.dart';

@freezed
abstract class UserNoteModel with _$UserNoteModel {
  const UserNoteModel._();

  const factory UserNoteModel({
    required int id,
    required int userId,
    required String username,
    required String fullName,
    String? avatarUrl,
    required String noteText,
    String? musicUrl,
    String? musicTitle,
    String? emoji,
    required String createdAt,
    required String expiresAt,
    @Default(0) int replyCount,
  }) = _UserNoteModel;

  factory UserNoteModel.fromJson(Map<String, dynamic> json) => _$UserNoteModelFromJson(json);

  UserNote toEntity() {
    return UserNote(
      id: id,
      userId: userId,
      username: username,
      fullName: fullName,
      avatarUrl: avatarUrl,
      noteText: noteText,
      musicUrl: musicUrl,
      musicTitle: musicTitle,
      emoji: emoji,
      createdAt: DateTime.parse(createdAt),
      expiresAt: DateTime.parse(expiresAt),
      replyCount: replyCount,
    );
  }
}

