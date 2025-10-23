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
    // Listen to WebSocket for conversation updates
    final wsService = ref.watch(chatWebSocketServiceProvider);
    wsService.conversationUpdateStream.listen((update) {
      debugPrint(
        '🔄 Conversation ${update.conversationId} updated, refreshing list',
      );
      refresh();
    });

    return _fetchConversations();
  }

  /// Fetch conversations from repository
  Future<List<Conversation>> _fetchConversations() async {
    final result = await _getConversationsUsecase();

    return result.fold(
      (failure) {
        debugPrint('❌ Failed to fetch conversations: ${failure.message}');
        throw Exception(failure.message);
      },
      (conversations) {
        debugPrint('✅ Fetched ${conversations.length} conversations');
        return conversations;
      },
    );
  }

  /// Refresh conversations list
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchConversations());
  }
}
