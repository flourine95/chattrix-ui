import 'package:chattrix_ui/core/errors/failures.dart';
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
  final datasource = ref.watch(notesRemoteDatasourceProvider) as NotesRemoteDatasourceImpl;
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

  return result.fold((failure) => throw _mapFailureToException(failure), (note) => note);
});

final contactNotesProvider = FutureProvider<List<UserNote>>((ref) async {
  final useCase = ref.watch(getContactNotesUseCaseProvider);
  final result = await useCase();

  return result.fold((failure) => throw _mapFailureToException(failure), (notes) => notes);
});

/// Map Failure to Exception for providers
Exception _mapFailureToException(Failure failure) {
  return failure.when(
    server: (message, code, requestId) => ServerException(message, code),
    network: (message, code) => NetworkException(message),
    validation: (message, code, details, requestId) => ValidationException(message, details),
    auth: (message, code, requestId) => AuthException(message, code),
    notFound: (message, code, requestId) => NotFoundException(message, code),
    conflict: (message, code, requestId) => ConflictException(message, code),
    rateLimit: (message, code, requestId) => RateLimitException(message),
  );
}

/// Custom exceptions matching Failure types
class ServerException implements Exception {
  final String message;
  final String? code;
  ServerException(this.message, [this.code]);

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => message;
}

class ValidationException implements Exception {
  final String message;
  final Map<String, String>? details;
  ValidationException(this.message, [this.details]);

  @override
  String toString() {
    if (details != null && details!.isNotEmpty) {
      return details!.values.join(', ');
    }
    return message;
  }
}

class AuthException implements Exception {
  final String message;
  final String? code;
  AuthException(this.message, [this.code]);

  @override
  String toString() => message;
}

class NotFoundException implements Exception {
  final String message;
  final String? code;
  NotFoundException(this.message, [this.code]);

  @override
  String toString() => message;
}

class ConflictException implements Exception {
  final String message;
  final String? code;
  ConflictException(this.message, [this.code]);

  @override
  String toString() => message;
}

class RateLimitException implements Exception {
  final String message;
  RateLimitException(this.message);

  @override
  String toString() => message;
}
