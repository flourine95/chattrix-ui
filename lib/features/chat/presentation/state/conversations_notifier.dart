import 'dart:async';

import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_new.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversations_notifier.g.dart';

@riverpod
class ConversationsNotifier extends _$ConversationsNotifier {
  late final _getConversationsUsecase = ref.read(getConversationsUsecaseProvider);
  Timer? _pollingTimer;
  StreamSubscription<bool>? _connectionSubscription;

  @override
  FutureOr<List<Conversation>> build() async {
    AppLogger.debug('🏗️ Building ConversationsNotifier...', tag: 'ConversationsNotifier');

    // Check if user is logged in first
    final isLoggedIn = await ref.read(isLoggedInUseCaseProvider)();
    if (!isLoggedIn) {
      AppLogger.warning('⚠️ User not logged in, returning empty conversations list', tag: 'ConversationsNotifier');
      return [];
    }
    ref.keepAlive();

    final wsDataSource = ref.watch(chatWebSocketDataSourceProvider);

    // Listen to WebSocket conversation updates for event-driven updates
    final conversationSub = wsDataSource.conversationUpdateStream.listen((_) {
      AppLogger.debug('📨 Conversation update received via WebSocket', tag: 'ConversationsNotifier');
      refresh();
    });

    // Listen to WebSocket messages for event-driven updates
    final messageSub = wsDataSource.messageStream.listen((_) {
      AppLogger.debug('📨 Message received via WebSocket', tag: 'ConversationsNotifier');
      refresh();
    });

    // Listen to WebSocket connection state to toggle polling
    _connectionSubscription = wsDataSource.connectionStream.listen((isConnected) {
      AppLogger.info(
        'WebSocket connection state changed: ${isConnected ? "Connected" : "Disconnected"}',
        tag: 'ConversationsNotifier',
      );
      if (isConnected) {
        // WebSocket connected - disable polling
        _stopPolling();
      } else {
        // WebSocket disconnected - enable polling
        _startPolling();
      }
    });

    // Check initial connection state
    final isConnected = wsDataSource.isConnected;
    AppLogger.debug(
      '🔌 Initial WebSocket connection state: ${isConnected ? "Connected" : "Disconnected"}',
      tag: 'ConversationsNotifier',
    );

    if (!isConnected) {
      _startPolling();
    }

    ref.onDispose(() {
      AppLogger.debug('🧹 Disposing ConversationsNotifier...', tag: 'ConversationsNotifier');
      conversationSub.cancel();
      messageSub.cancel();
      _connectionSubscription?.cancel();
      _stopPolling();
    });

    return _fetchConversations();
  }

  void _startPolling() {
    _stopPolling();
    AppLogger.info('🔄 Starting conversation polling (every 10s)', tag: 'ConversationsNotifier');
    _pollingTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      AppLogger.debug('⏰ Polling timer triggered - refreshing conversations', tag: 'ConversationsNotifier');
      refresh();
    });
  }

  void _stopPolling() {
    if (_pollingTimer != null) {
      AppLogger.info('⏸️ Stopping conversation polling', tag: 'ConversationsNotifier');
      _pollingTimer?.cancel();
      _pollingTimer = null;
    }
  }

  Future<List<Conversation>> _fetchConversations() async {
    AppLogger.debug('🔄 Starting to fetch conversations...', tag: 'ConversationsNotifier');

    // Double check if user is still logged in before fetching
    final isLoggedIn = await ref.read(isLoggedInUseCaseProvider)();
    if (!isLoggedIn) {
      AppLogger.warning('⚠️ User not logged in, skipping fetch', tag: 'ConversationsNotifier');
      return [];
    }

    final result = await _getConversationsUsecase();

    return result.fold(
      (failure) {
        AppLogger.error(
          '❌ Failed to fetch conversations: ${failure.message}',
          tag: 'ConversationsNotifier',
        );
        throw Exception(failure.message);
      },
      (conversations) {
        AppLogger.info(
          '✅ Successfully fetched ${conversations.length} conversations',
          tag: 'ConversationsNotifier',
        );
        return conversations;
      },
    );
  }

  Future<void> refresh() async {
    AppLogger.debug('🔄 Refreshing conversations...', tag: 'ConversationsNotifier');
    state = await AsyncValue.guard(_fetchConversations);
  }
}
