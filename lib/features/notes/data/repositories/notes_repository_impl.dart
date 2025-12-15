import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:chattrix_ui/features/notes/domain/datasources/notes_remote_datasource.dart';
import 'package:chattrix_ui/features/notes/domain/entities/user_note.dart';
import 'package:chattrix_ui/features/notes/domain/repositories/notes_repository.dart';
import 'package:dartz/dartz.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesRemoteDatasource _remoteDatasource;

  NotesRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<String, UserNote>> createOrUpdateNote({
    required String noteText,
    String? musicUrl,
    String? musicTitle,
    String? emoji,
  }) async {
    try {
      final model = await _remoteDatasource.createOrUpdateNote(
        noteText: noteText,
        musicUrl: musicUrl,
        musicTitle: musicTitle,
        emoji: emoji,
      );
      return Right(model.toEntity());
    } catch (e, stackTrace) {
      AppLogger.error('Failed to create/update note', error: e, stackTrace: stackTrace);
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserNote?>> getMyNote() async {
    try {
      final model = await _remoteDatasource.getMyNote();
      return Right(model?.toEntity());
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get my note', error: e, stackTrace: stackTrace);
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteMyNote() async {
    try {
      await _remoteDatasource.deleteMyNote();
      return const Right(null);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to delete note', error: e, stackTrace: stackTrace);
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<UserNote>>> getContactNotes() async {
    try {
      final models = await _remoteDatasource.getContactNotes();
      final notes = models.map((m) => m.toEntity()).toList();
      return Right(notes);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get contact notes', error: e, stackTrace: stackTrace);
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserNote?>> getUserNote(int userId) async {
    try {
      final model = await _remoteDatasource.getUserNote(userId);
      return Right(model?.toEntity());
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get user note', error: e, stackTrace: stackTrace);
      return Left(e.toString());
    }
  }
}

