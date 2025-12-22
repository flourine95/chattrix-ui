import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'marked_unread_provider.g.dart';

/// Provider to manage conversations marked as unread by user
///
/// This is a local-only feature (mock implementation) until API is ready.
/// State is persisted in SharedPreferences.
///
/// **Features:**
/// - Mark conversation as unread (adds to set)
/// - Remove unread mark (removes from set)
/// - Check if conversation is marked unread
/// - Persist state across app restarts
///
/// **Future API Integration:**
/// When API endpoint is ready, replace SharedPreferences with API calls:
/// - POST /v1/conversations/{id}/mark-unread
/// - DELETE /v1/conversations/{id}/mark-unread
@Riverpod(keepAlive: true)
class MarkedUnreadConversations extends _$MarkedUnreadConversations {
  static const String _storageKey = 'marked_unread_conversations';

  @override
  Set<int> build() {
    // Load from SharedPreferences on initialization
    _loadFromStorage();
    return {};
  }

  /// Load marked unread conversations from SharedPreferences
  Future<void> _loadFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? stored = prefs.getStringList(_storageKey);

      if (stored != null) {
        state = stored.map((id) => int.parse(id)).toSet();
      }
    } catch (e) {
      debugPrint('Error loading marked unread conversations: $e');
    }
  }

  /// Save marked unread conversations to SharedPreferences
  Future<void> _saveToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> toStore = state.map((id) => id.toString()).toList();
      await prefs.setStringList(_storageKey, toStore);
    } catch (e) {
      debugPrint('Error saving marked unread conversations: $e');
    }
  }

  /// Mark a conversation as unread
  ///
  /// **Parameters:**
  /// - [conversationId]: ID of the conversation to mark as unread
  ///
  /// **Effect:**
  /// - Adds conversation ID to the set
  /// - Persists to SharedPreferences
  /// - UI will show unread badge and bold text
  ///
  /// **Future API:**
  /// ```dart
  /// await dio.post('/v1/conversations/$conversationId/mark-unread');
  /// ```
  Future<void> markAsUnread(int conversationId) async {
    state = {...state, conversationId};
    await _saveToStorage();
    debugPrint('Marked conversation $conversationId as unread');
  }

  /// Remove unread mark from a conversation
  ///
  /// **Parameters:**
  /// - [conversationId]: ID of the conversation to remove mark from
  ///
  /// **Effect:**
  /// - Removes conversation ID from the set
  /// - Persists to SharedPreferences
  /// - UI will remove unread badge
  ///
  /// **Automatically called when:**
  /// - User opens the conversation
  /// - User explicitly marks as read
  ///
  /// **Future API:**
  /// ```dart
  /// await dio.delete('/v1/conversations/$conversationId/mark-unread');
  /// ```
  Future<void> removeUnreadMark(int conversationId) async {
    state = state.where((id) => id != conversationId).toSet();
    await _saveToStorage();
    debugPrint('Removed unread mark from conversation $conversationId');
  }

  /// Check if a conversation is marked as unread
  ///
  /// **Parameters:**
  /// - [conversationId]: ID of the conversation to check
  ///
  /// **Returns:**
  /// - `true` if conversation is marked as unread
  /// - `false` otherwise
  bool isMarkedUnread(int conversationId) {
    return state.contains(conversationId);
  }

  /// Clear all marked unread conversations
  ///
  /// **Use case:** Debug or reset functionality
  Future<void> clearAll() async {
    state = {};
    await _saveToStorage();
    debugPrint('Cleared all marked unread conversations');
  }
}
