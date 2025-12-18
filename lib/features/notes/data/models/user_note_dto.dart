import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_note_dto.freezed.dart';
part 'user_note_dto.g.dart';

/// WebSocket DTO for note events (note.created, note.updated)
@freezed
abstract class UserNoteDto with _$UserNoteDto {
  const factory UserNoteDto({
    required int id,
    required int userId,
    required String noteText,
    String? emoji,
    required String createdAt,
    required String expiresAt,
  }) = _UserNoteDto;

  factory UserNoteDto.fromJson(Map<String, dynamic> json) => _$UserNoteDtoFromJson(json);
}
