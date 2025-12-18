import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/user_note_entity.dart';

part 'user_notes_provider.g.dart';

/// Provider for user notes/stories
///
/// Uses mock data until API is available
/// TODO: Replace with API calls when backend is ready
@riverpod
class UserNotes extends _$UserNotes {
  @override
  Map<String, UserNoteEntity> build() {
    // Initialize with mock data
    return _initializeMockData();
  }

  /// Initialize mock data for demonstration
  Map<String, UserNoteEntity> _initializeMockData() {
    return {
      // Mock notes for other users
      // These IDs match the mock online users (user2, user3, user4)
      '2': UserNoteEntity(userId: '2', content: 'Coding 💻', createdAt: DateTime.now()),
      '3': UserNoteEntity(userId: '3', content: 'At the gym 💪', createdAt: DateTime.now()),
      '4': UserNoteEntity(userId: '4', content: 'Lunch break 🍜', createdAt: DateTime.now()),
    };
  }

  /// Create or update current user's note
  ///
  /// TODO: Replace with API call
  /// POST /v1/users/me/note
  void createOrUpdateNote(String userId, String content) {
    state = {...state, userId: UserNoteEntity(userId: userId, content: content, createdAt: DateTime.now())};
  }

  /// Delete current user's note
  ///
  /// TODO: Replace with API call
  /// DELETE /v1/users/me/note
  void deleteNote(String userId) {
    final newState = Map<String, UserNoteEntity>.from(state);
    newState.remove(userId);
    state = newState;
  }

  /// Get note for specific user
  UserNoteEntity? getNoteForUser(String userId) {
    return state[userId];
  }
}
