import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/notes_repository.dart';

class DeleteMyNoteUseCase {
  final NotesRepository _repository;

  DeleteMyNoteUseCase(this._repository);

  Future<Either<Failure, void>> call() {
    return _repository.deleteMyNote();
  }
}
