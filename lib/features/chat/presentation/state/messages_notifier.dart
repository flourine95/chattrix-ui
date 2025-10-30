import 'dart:async';

import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'messages_notifier.g.dart';

/// Notifier for managing messages in a conversation
/// Handles fetching and caching messages with real-time updates
@riverpod
class MessagesNotifier extends _$MessagesNotifier {
  late final _getMessagesUsecase = ref.read(getMessagesUsecaseProvider);
  Timer? _pollingTimer;

  @override
  FutureOr<List<Message>> build(String conversationId) async {
    // Keep provider alive to maintain WebSocket subscription
    ref.keepAlive();

    debugPrint('🔧 [MessagesNotifier] Building for conversation: $conversationId');

    // Listen to WebSocket for real-time message updates
    // Use ref.watch to create dependency and keep WebSocket service alive
    final wsService = ref.watch(chatWebSocketServiceProvider);

    // Subscribe to message stream for this conversation
    final subscription = wsService.messageStream.listen((message) {
      debugPrint('🔔 [MessagesNotifier] Received message from WebSocket');
      debugPrint('   Message conversationId: ${message.conversationId}');
      debugPrint('   Current conversationId: $conversationId');
      debugPrint('   Match: ${message.conversationId.toString() == conversationId.toString()}');

      // Compare as strings to handle both int and string conversationIds
      if (message.conversationId.toString() == conversationId.toString()) {
        debugPrint('✅ [MessagesNotifier] Message matches! Calling refresh()...');
        refresh();
      } else {
        debugPrint('⏭️ [MessagesNotifier] Message for different conversation, skipping');
      }
    });

    debugPrint('✅ [MessagesNotifier] WebSocket subscription created');

    // Start periodic polling as a workaround for multimedia messages not being broadcast via WebSocket
    // This ensures recipients receive multimedia messages even if backend doesn't broadcast them
    _startPolling();

    // Clean up subscription when provider is disposed
    ref.onDispose(() {
      debugPrint('🗑️ [MessagesNotifier] Disposing subscription for conversation: $conversationId');
      subscription.cancel();
      _stopPolling();
    });

    return _fetchMessages(conversationId);
  }

  /// Start periodic polling to fetch new messages
  /// This is a workaround for multimedia messages not being broadcast via WebSocket
  void _startPolling() {
    _stopPolling(); // Cancel any existing timer

    // Poll every 5 seconds to check for new messages
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      debugPrint('🔄 [MessagesNotifier] Polling for new messages...');
      refresh();
    });

    debugPrint('✅ [MessagesNotifier] Started polling (5s interval)');
  }

  /// Stop periodic polling
  void _stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  /// Fetch messages from repository
  /// Messages are fetched in DESC order (newest first) by default
  Future<List<Message>> _fetchMessages(String conversationId) async {
    final result = await _getMessagesUsecase(
      conversationId: conversationId,
      sort: 'DESC', // Newest messages first
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (messages) => messages,
    );
  }

  /// Refresh messages list without showing loading indicator
  Future<void> refresh() async {
    debugPrint('🔄 [MessagesNotifier] refresh() called for conversation: $conversationId');
    debugPrint('   Current state: ${state.value?.length ?? 0} messages');
    state = await AsyncValue.guard(() => _fetchMessages(conversationId));
    debugPrint('✅ [MessagesNotifier] refresh() completed. New state: ${state.value?.length ?? 0} messages');
  }
}
