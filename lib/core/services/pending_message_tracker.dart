import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:flutter/foundation.dart';

/// Service to track pending messages with temp IDs
/// 
/// Backend uses Write-Behind pattern:
/// - Messages get temp ID (negative: -1, -2, -3...)
/// - Server responds immediately with temp ID
/// - After 30s or 3000 messages → Flush to DB → Real ID
/// - Server sends `message.id.update` event to sync temp → real ID
class PendingMessageTracker {
  // Singleton pattern
  static final PendingMessageTracker _instance = PendingMessageTracker._internal();
  factory PendingMessageTracker() => _instance;
  PendingMessageTracker._internal();

  /// Map of temp ID → pending message
  final Map<int, Message> _pendingMessages = {};

  /// Map of temp ID → callback for when real ID is received
  final Map<int, Function(Message)> _callbacks = {};

  /// Counter for generating local temp IDs
  int _localTempIdCounter = -1;

  /// Generate a new local temp ID
  /// 
  /// Returns negative number (e.g., -1, -2, -3...)
  int generateLocalTempId() {
    return _localTempIdCounter--;
  }

  /// Add a pending message
  void addPending(int tempId, Message message, {Function(Message)? onRealIdReceived}) {
    _pendingMessages[tempId] = message;
    if (onRealIdReceived != null) {
      _callbacks[tempId] = onRealIdReceived;
    }
    debugPrint('📝 [PendingTracker] Added pending message with temp ID: $tempId');
  }

  /// Get a pending message by temp ID
  Message? getPending(int tempId) {
    return _pendingMessages[tempId];
  }

  /// Check if a message is pending
  bool isPending(int messageId) {
    return messageId < 0 && _pendingMessages.containsKey(messageId);
  }

  /// Update temp ID to real ID
  /// 
  /// Called when receiving `message.id.update` event
  Message? updateToRealId(int tempId, int realId) {
    final pendingMessage = _pendingMessages[tempId];
    if (pendingMessage == null) {
      debugPrint('⚠️ [PendingTracker] No pending message found for temp ID: $tempId');
      return null;
    }

    // Create updated message with real ID
    final updatedMessage = pendingMessage.copyWith(id: realId);

    // Remove from pending
    _pendingMessages.remove(tempId);

    // Call callback if exists
    final callback = _callbacks[tempId];
    if (callback != null) {
      callback(updatedMessage);
      _callbacks.remove(tempId);
    }

    debugPrint('🔄 [PendingTracker] Updated message ID: $tempId → $realId');
    return updatedMessage;
  }

  /// Find pending message by content (for matching server temp ID)
  /// 
  /// When server sends back temp ID, we need to match it with our local temp ID
  /// by comparing conversationId, senderId, and content
  int? findLocalTempId({
    required int conversationId,
    required int senderId,
    required String content,
  }) {
    for (final entry in _pendingMessages.entries) {
      final message = entry.value;
      if (message.conversationId == conversationId &&
          message.senderId == senderId &&
          message.content == content) {
        return entry.key;
      }
    }
    return null;
  }

  /// Get all pending messages for a conversation
  List<Message> getPendingForConversation(int conversationId) {
    return _pendingMessages.values
        .where((msg) => msg.conversationId == conversationId)
        .toList();
  }

  /// Remove a pending message
  void remove(int tempId) {
    _pendingMessages.remove(tempId);
    _callbacks.remove(tempId);
    debugPrint('🗑️ [PendingTracker] Removed pending message: $tempId');
  }

  /// Clear all pending messages
  void clear() {
    _pendingMessages.clear();
    _callbacks.clear();
    _localTempIdCounter = -1;
    debugPrint('🧹 [PendingTracker] Cleared all pending messages');
  }

  /// Clear pending messages for a specific conversation
  void clearConversation(int conversationId) {
    _pendingMessages.removeWhere((_, msg) => msg.conversationId == conversationId);
    debugPrint('🧹 [PendingTracker] Cleared pending messages for conversation: $conversationId');
  }

  /// Clean up stale pending messages (older than 60 seconds)
  void cleanupStale() {
    final now = DateTime.now();
    final staleIds = <int>[];

    for (final entry in _pendingMessages.entries) {
      final message = entry.value;
      final age = now.difference(message.createdAt).inSeconds;
      if (age > 60) {
        staleIds.add(entry.key);
      }
    }

    for (final tempId in staleIds) {
      debugPrint('⚠️ [PendingTracker] Removing stale pending message: $tempId');
      remove(tempId);
    }

    if (staleIds.isNotEmpty) {
      debugPrint('🧹 [PendingTracker] Cleaned up ${staleIds.length} stale messages');
    }
  }

  /// Get count of pending messages
  int getPendingCount() {
    return _pendingMessages.length;
  }

  /// Debug: Print current state
  void debugPrintState() {
    debugPrint('📊 [PendingTracker] Current state:');
    debugPrint('   Pending messages: ${_pendingMessages.length}');
    debugPrint('   Temp IDs: ${_pendingMessages.keys.toList()}');
  }
}
