import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/notes/data/datasources/notes_remote_datasource_impl.dart';
import 'package:chattrix_ui/features/notes/data/repositories/notes_repository_impl.dart';
import 'package:chattrix_ui/features/notes/domain/datasources/notes_remote_datasource.dart';
import 'package:chattrix_ui/features/notes/domain/entities/user_note.dart';
import 'package:chattrix_ui/features/notes/domain/repositories/notes_repository.dart';
import 'package:chattrix_ui/features/notes/domain/usecases/create_or_update_note_usecase.dart';
import 'package:chattrix_ui/features/notes/domain/usecases/delete_my_note_usecase.dart';
import 'package:chattrix_ui/features/notes/domain/usecases/get_contact_notes_usecase.dart';
import 'package:chattrix_ui/features/notes/domain/usecases/get_my_note_usecase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Datasource Provider
final notesRemoteDatasourceProvider = Provider<NotesRemoteDatasource>((ref) {
  final dio = ref.watch(dioProvider);
  return NotesRemoteDatasourceImpl(dio);
});

// Repository Provider
final notesRepositoryProvider = Provider<NotesRepository>((ref) {
  final datasource = ref.watch(notesRemoteDatasourceProvider);
  return NotesRepositoryImpl(datasource);
});

// Use Case Providers
final createOrUpdateNoteUseCaseProvider = Provider<CreateOrUpdateNoteUseCase>((ref) {
  final repository = ref.watch(notesRepositoryProvider);
  return CreateOrUpdateNoteUseCase(repository);
});

final getMyNoteUseCaseProvider = Provider<GetMyNoteUseCase>((ref) {
  final repository = ref.watch(notesRepositoryProvider);
  return GetMyNoteUseCase(repository);
});

final deleteMyNoteUseCaseProvider = Provider<DeleteMyNoteUseCase>((ref) {
  final repository = ref.watch(notesRepositoryProvider);
  return DeleteMyNoteUseCase(repository);
});

final getContactNotesUseCaseProvider = Provider<GetContactNotesUseCase>((ref) {
  final repository = ref.watch(notesRepositoryProvider);
  return GetContactNotesUseCase(repository);
});

// State Providers
final myNoteProvider = FutureProvider<UserNote?>((ref) async {
  final useCase = ref.watch(getMyNoteUseCaseProvider);
  final result = await useCase();

  return result.fold(
    (error) => null,
    (note) => note,
  );
});

final contactNotesProvider = FutureProvider<List<UserNote>>((ref) async {
  final useCase = ref.watch(getContactNotesUseCaseProvider);
  final result = await useCase();

  return result.fold(
    (error) => [],
    (notes) => notes,
  );
});

