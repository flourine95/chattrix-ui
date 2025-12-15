import 'package:chattrix_ui/features/notes/data/models/user_note_model.dart';
import 'package:chattrix_ui/features/notes/domain/datasources/notes_remote_datasource.dart';
import 'package:dio/dio.dart';

class NotesRemoteDatasourceImpl implements NotesRemoteDatasource {
  final Dio _dio;

  NotesRemoteDatasourceImpl(this._dio);

  @override
  Future<UserNoteModel> createOrUpdateNote({
    required String noteText,
    String? musicUrl,
    String? musicTitle,
    String? emoji,
  }) async {
    final response = await _dio.post(
      '/v1/notes',
      data: {
        'noteText': noteText,
        if (musicUrl != null) 'musicUrl': musicUrl,
        if (musicTitle != null) 'musicTitle': musicTitle,
        if (emoji != null) 'emoji': emoji,
      },
    );

    final data = response.data['data'];
    return UserNoteModel.fromJson(data);
  }

  @override
  Future<UserNoteModel?> getMyNote() async {
    final response = await _dio.get('/v1/notes');
    final data = response.data['data'];

    if (data == null) return null;
    return UserNoteModel.fromJson(data);
  }

  @override
  Future<void> deleteMyNote() async {
    await _dio.delete('/v1/notes');
  }

  @override
  Future<List<UserNoteModel>> getContactNotes() async {
    final response = await _dio.get('/v1/notes/contacts');
    final data = response.data['data'] as List;

    return data.map((json) => UserNoteModel.fromJson(json)).toList();
  }

  @override
  Future<UserNoteModel?> getUserNote(int userId) async {
    final response = await _dio.get('/v1/notes/user/$userId');
    final data = response.data['data'];

    if (data == null) return null;
    return UserNoteModel.fromJson(data);
  }
}

