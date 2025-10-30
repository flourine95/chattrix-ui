import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversations_notifier.g.dart';

/// Notifier for managing conversations list
/// Handles fetching and caching conversations with real-time updates
@riverpod
class ConversationsNotifier extends _$ConversationsNotifier {
  late final _getConversationsUsecase = ref.read(
    getConversationsUsecaseProvider,
  );

  @override
  FutureOr<List<Conversation>> build() async {
    debugPrint('🔧 [ConversationsNotifier] Building...');

    // Listen to WebSocket for updates
    // Use ref.watch to create dependency and keep WebSocket service alive
    final wsService = ref.watch(chatWebSocketServiceProvider);

    // Listen to conversation updates
    final conversationSub = wsService.conversationUpdateStream.listen((_) {
      debugPrint('🔔 [ConversationsNotifier] Conversation update received');
      refresh();
    });

    // Listen to new messages to update last message in conversation list
    final messageSub = wsService.messageStream.listen((_) {
      debugPrint('🔔 [ConversationsNotifier] Message received, refreshing conversations');
      refresh();
    });

    debugPrint('✅ [ConversationsNotifier] WebSocket subscriptions created');

    // Clean up subscriptions when provider is disposed
    ref.onDispose(() {
      debugPrint('🗑️ [ConversationsNotifier] Disposing subscriptions');
      conversationSub.cancel();
      messageSub.cancel();
    });

    return _fetchConversations();
  }

  /// Fetch conversations from repository
  Future<List<Conversation>> _fetchConversations() async {
    final result = await _getConversationsUsecase();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (conversations) => conversations,
    );
  }

  /// Refresh conversations list without showing loading indicator
  Future<void> refresh() async {
    state = await AsyncValue.guard(_fetchConversations);
  }
}
