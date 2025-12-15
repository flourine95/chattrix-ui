import 'package:chattrix_ui/features/notes/domain/entities/user_note.dart';
import 'package:dartz/dartz.dart';

/// Repository interface for Notes feature
abstract class NotesRepository {
  /// Create or update my note
  Future<Either<String, UserNote>> createOrUpdateNote({
    required String noteText,
    String? musicUrl,
    String? musicTitle,
    String? emoji,
  });

  /// Get my current note
  Future<Either<String, UserNote?>> getMyNote();

  /// Delete my current note
  Future<Either<String, void>> deleteMyNote();

  /// Get notes from all contacts
  Future<Either<String, List<UserNote>>> getContactNotes();

  /// Get note of a specific user
  Future<Either<String, UserNote?>> getUserNote(int userId);
}

