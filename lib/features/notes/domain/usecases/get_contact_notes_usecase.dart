import 'package:chattrix_ui/features/notes/domain/entities/user_note.dart';
import 'package:chattrix_ui/features/notes/domain/repositories/notes_repository.dart';
import 'package:dartz/dartz.dart';

class GetContactNotesUseCase {
  final NotesRepository _repository;

  GetContactNotesUseCase(this._repository);

  Future<Either<String, List<UserNote>>> call() {
    return _repository.getContactNotes();
  }
}

