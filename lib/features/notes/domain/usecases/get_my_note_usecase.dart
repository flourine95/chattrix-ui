import 'package:chattrix_ui/features/notes/domain/entities/user_note.dart';
import 'package:chattrix_ui/features/notes/domain/repositories/notes_repository.dart';
import 'package:dartz/dartz.dart';

class GetMyNoteUseCase {
  final NotesRepository _repository;

  GetMyNoteUseCase(this._repository);

  Future<Either<String, UserNote?>> call() {
    return _repository.getMyNote();
  }
}

