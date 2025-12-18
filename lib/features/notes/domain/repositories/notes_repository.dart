import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_note.dart';

/// Repository interface for Notes feature
abstract class NotesRepository {
  /// Create or update my note
  Future<Either<Failure, UserNote>> createOrUpdateNote({
    required String noteText,
    String? musicUrl,
    String? musicTitle,
    String? emoji,
  });

  /// Get my current note
  Future<Either<Failure, UserNote?>> getMyNote();

  /// Delete my current note
  Future<Either<Failure, void>> deleteMyNote();

  /// Get notes from all contacts
  Future<Either<Failure, List<UserNote>>> getContactNotes();

  /// Get note of a specific user
  Future<Either<Failure, UserNote?>> getUserNote(int userId);
}
