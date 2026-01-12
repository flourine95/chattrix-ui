import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/repositories/base_repository.dart';
import '../../domain/entities/user_note.dart';
import '../../domain/repositories/notes_repository.dart';
import '../datasources/notes_remote_datasource_impl.dart';

class NotesRepositoryImpl extends BaseRepository implements NotesRepository {
  final NotesRemoteDatasourceImpl _remoteDatasource;

  NotesRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, UserNote>> createOrUpdateNote({
    required String noteText,
    String? musicUrl,
    String? musicTitle,
    String? emoji,
  }) async {
    return executeApiCall(() async {
      final model = await _remoteDatasource.createOrUpdateNote(
        noteText: noteText,
        musicUrl: musicUrl,
        musicTitle: musicTitle,
        emoji: emoji,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, UserNote?>> getMyNote() async {
    return executeApiCall(() async {
      final model = await _remoteDatasource.getMyNote();
      return model?.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> deleteMyNote() async {
    return executeApiCall(() async {
      await _remoteDatasource.deleteMyNote();
    });
  }

  @override
  Future<Either<Failure, List<UserNote>>> getContactNotes() async {
    return executeApiCall(() async {
      final models = await _remoteDatasource.getContactNotes();
      return models.map((m) => m.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, UserNote?>> getUserNote(int userId) async {
    return executeApiCall(() async {
      final model = await _remoteDatasource.getUserNote(userId);
      return model?.toEntity();
    });
  }
}
