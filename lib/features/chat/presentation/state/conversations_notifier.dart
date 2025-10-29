import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider.dart';
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
    // Listen to WebSocket for updates
    final wsService = ref.read(chatWebSocketServiceProvider);

    // Listen to conversation updates
    final conversationSub = wsService.conversationUpdateStream.listen((_) => refresh());

    // Listen to new messages to update last message in conversation list
    final messageSub = wsService.messageStream.listen((_) => refresh());

    // Clean up subscriptions when provider is disposed
    ref.onDispose(() {
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
