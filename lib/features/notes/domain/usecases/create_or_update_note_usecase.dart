import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_note.dart';
import '../repositories/notes_repository.dart';

class CreateOrUpdateNoteUseCase {
  final NotesRepository _repository;

  CreateOrUpdateNoteUseCase(this._repository);

  Future<Either<Failure, UserNote>> call({
    required String noteText,
    String? musicUrl,
    String? musicTitle,
    String? emoji,
  }) {
    return _repository.createOrUpdateNote(noteText: noteText, musicUrl: musicUrl, musicTitle: musicTitle, emoji: emoji);
  }
}
