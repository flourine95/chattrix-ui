import 'dart:async';

import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'messages_notifier.g.dart';

@riverpod
class MessagesNotifier extends _$MessagesNotifier {
  late final _getMessagesUsecase = ref.read(getMessagesUsecaseProvider);
  Timer? _pollingTimer;

  @override
  FutureOr<List<Message>> build(String conversationId) async {
    ref.keepAlive();

    final wsService = ref.watch(chatWebSocketServiceProvider);

    final subscription = wsService.messageStream.listen((message) {
      if (message.conversationId.toString() == conversationId.toString()) {
        refresh();
      }
    });

    _startPolling();

    ref.onDispose(() {
      subscription.cancel();
      _stopPolling();
    });

    return _fetchMessages(conversationId);
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

  Future<List<Message>> _fetchMessages(String conversationId) async {
    final result = await _getMessagesUsecase(
      conversationId: conversationId,
      sort: 'DESC',
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (messages) => messages,
    );
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() => _fetchMessages(conversationId));
  }
}
