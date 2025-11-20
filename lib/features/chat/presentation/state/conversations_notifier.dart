import 'dart:async';

import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversations_notifier.g.dart';

@riverpod
class ConversationsNotifier extends _$ConversationsNotifier {
  late final _getConversationsUsecase = ref.read(getConversationsUsecaseProvider);
  Timer? _pollingTimer;
  StreamSubscription<bool>? _connectionSubscription;

  @override
  FutureOr<List<Conversation>> build() async {
    ref.keepAlive();

    final wsService = ref.watch(chatWebSocketServiceProvider);

    // Listen to WebSocket conversation updates for event-driven updates
    final conversationSub = wsService.conversationUpdateStream.listen((_) {
      refresh();
    });

    // Listen to WebSocket messages for event-driven updates
    final messageSub = wsService.messageStream.listen((_) {
      refresh();
    });

    // Listen to WebSocket connection state to toggle polling
    _connectionSubscription = wsService.connectionStream.listen((isConnected) {
      if (isConnected) {
        // WebSocket connected - disable polling
        _stopPolling();
      } else {
        // WebSocket disconnected - enable polling
        _startPolling();
      }
    });

    // Check initial connection state
    if (!wsService.isConnected) {
      _startPolling();
    }

    ref.onDispose(() {
      conversationSub.cancel();
      messageSub.cancel();
      _connectionSubscription?.cancel();
      _stopPolling();
    });

    return _fetchConversations();
  }

  void _startPolling() {
    _stopPolling();
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      refresh();
    });
  }

  void _stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  Future<List<Conversation>> _fetchConversations() async {
    final result = await _getConversationsUsecase();
    return result.fold((failure) => throw Exception(failure.message), (conversations) => conversations);
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(_fetchConversations);
  }
}
