import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_note.dart';
import '../repositories/notes_repository.dart';

class GetContactNotesUseCase {
  final NotesRepository _repository;

  GetContactNotesUseCase(this._repository);

  Future<Either<Failure, List<UserNote>>> call() {
    return _repository.getContactNotes();
  }
}
