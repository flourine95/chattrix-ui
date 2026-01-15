import 'dart:async';

import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'typing_indicator_provider.g.dart';

@riverpod
class TypingIndicatorNotifier extends _$TypingIndicatorNotifier {
  StreamSubscription<TypingIndicator>? _subscription;
  Timer? _typingTimer;
  Timer? _stopTimer;

  @override
  TypingIndicator build(int conversationId) {
    final wsDataSource = ref.watch(chatWebSocketDataSourceProvider);

    _subscription = wsDataSource.typingStream.listen((indicator) {
      if (indicator.conversationId == conversationId) {
        state = indicator;

        _stopTimer?.cancel();
        _stopTimer = Timer(const Duration(seconds: 3), () {
          if (state.typingUsers.isNotEmpty) {
            state = TypingIndicator(conversationId: conversationId, typingUsers: []);
          }
        });
      }
    });

    ref.onDispose(() {
      _subscription?.cancel();
      _typingTimer?.cancel();
      _stopTimer?.cancel();
    });

    return TypingIndicator(conversationId: conversationId, typingUsers: []);
  }

  void startTyping() {
    final wsDataSource = ref.read(chatWebSocketDataSourceProvider);

    wsDataSource.sendTypingStart(conversationId);

    _typingTimer?.cancel();

    _typingTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      wsDataSource.sendTypingStart(conversationId);
    });
  }

  void stopTyping() {
    final wsDataSource = ref.read(chatWebSocketDataSourceProvider);

    _typingTimer?.cancel();

    wsDataSource.sendTypingStop(conversationId);
  }
}
