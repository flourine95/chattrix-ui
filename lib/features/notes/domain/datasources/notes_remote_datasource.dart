import 'package:chattrix_ui/features/notes/data/models/user_note_model.dart';

/// Remote datasource interface for Notes API
abstract class NotesRemoteDatasource {
  /// POST /v1/notes - Create or update note
  Future<UserNoteModel> createOrUpdateNote({
    required String noteText,
    String? musicUrl,
    String? musicTitle,
    String? emoji,
  });

  /// GET /v1/notes - Get my note
  Future<UserNoteModel?> getMyNote();

  /// DELETE /v1/notes - Delete my note
  Future<void> deleteMyNote();

  /// GET /v1/notes/contacts - Get notes from contacts
  Future<List<UserNoteModel>> getContactNotes();

  /// GET /v1/notes/user/{userId} - Get note of specific user
  Future<UserNoteModel?> getUserNote(int userId);
}
