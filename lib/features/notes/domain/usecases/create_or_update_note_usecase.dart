import 'package:chattrix_ui/features/notes/domain/entities/user_note.dart';
import 'package:chattrix_ui/features/notes/domain/repositories/notes_repository.dart';
import 'package:dartz/dartz.dart';

class CreateOrUpdateNoteUseCase {
  final NotesRepository _repository;

  CreateOrUpdateNoteUseCase(this._repository);

  Future<Either<String, UserNote>> call({
    required String noteText,
    String? musicUrl,
    String? musicTitle,
    String? emoji,
  }) {
    return _repository.createOrUpdateNote(
      noteText: noteText,
      musicUrl: musicUrl,
      musicTitle: musicTitle,
      emoji: emoji,
    );
  }
}

