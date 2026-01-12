import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_note.dart';
import '../repositories/notes_repository.dart';

class GetMyNoteUseCase {
  final NotesRepository _repository;

  GetMyNoteUseCase(this._repository);

  Future<Either<Failure, UserNote?>> call() {
    return _repository.getMyNote();
  }
}
