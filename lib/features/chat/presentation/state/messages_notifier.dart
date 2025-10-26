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

  @override
  FutureOr<List<Message>> build(String conversationId) async {
    // Listen to WebSocket for real-time message updates
    final wsService = ref.read(chatWebSocketServiceProvider);

    // Subscribe to message stream for this conversation
    final subscription = wsService.messageStream.listen((message) {
      // Compare as strings to handle both int and string conversationIds
      if (message.conversationId.toString() == conversationId.toString()) {
        refresh();
      }
    });

    // Clean up subscription when provider is disposed
    ref.onDispose(subscription.cancel);

    return _fetchMessages(conversationId);
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
    state = await AsyncValue.guard(() => _fetchMessages(conversationId));
  }
}
