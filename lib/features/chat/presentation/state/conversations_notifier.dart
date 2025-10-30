import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversations_notifier.g.dart';

@riverpod
class ConversationsNotifier extends _$ConversationsNotifier {
  late final _getConversationsUsecase = ref.read(
    getConversationsUsecaseProvider,
  );

  @override
  FutureOr<List<Conversation>> build() async {
    final wsService = ref.watch(chatWebSocketServiceProvider);

    final conversationSub = wsService.conversationUpdateStream.listen((_) {
      refresh();
    });

    final messageSub = wsService.messageStream.listen((_) {
      refresh();
    });

    ref.onDispose(() {
      conversationSub.cancel();
      messageSub.cancel();
    });

    return _fetchConversations();
  }

  Future<List<Conversation>> _fetchConversations() async {
    final result = await _getConversationsUsecase();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (conversations) => conversations,
    );
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(_fetchConversations);
  }
}
