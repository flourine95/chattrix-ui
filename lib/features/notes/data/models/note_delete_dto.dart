import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_delete_dto.freezed.dart';
part 'note_delete_dto.g.dart';

/// WebSocket DTO for note deletion (event: note.deleted)
@freezed
abstract class NoteDeleteDto with _$NoteDeleteDto {
  const factory NoteDeleteDto({required int userId}) = _NoteDeleteDto;

  factory NoteDeleteDto.fromJson(Map<String, dynamic> json) => _$NoteDeleteDtoFromJson(json);
}
