import 'package:chattrix_ui/features/notes/domain/repositories/notes_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteMyNoteUseCase {
  final NotesRepository _repository;

  DeleteMyNoteUseCase(this._repository);

  Future<Either<String, void>> call() {
    return _repository.deleteMyNote();
  }
}

