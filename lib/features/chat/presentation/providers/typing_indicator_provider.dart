import 'dart:async';

import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'typing_indicator_provider.g.dart';

/// Provider for typing indicator state in a specific conversation
@riverpod
class TypingIndicatorNotifier extends _$TypingIndicatorNotifier {
  StreamSubscription<TypingIndicator>? _subscription;
  Timer? _typingTimer;
  Timer? _stopTimer;

  @override
  TypingIndicator build(String conversationId) {
    // Listen to typing indicator stream
    final wsDataSource = ref.watch(chatWebSocketDataSourceProvider);

    _subscription = wsDataSource.typingStream.listen((indicator) {
      if (indicator.conversationId == conversationId) {
        debugPrint('📨 [Typing] Received typing indicator for conversation: $conversationId');
        debugPrint('   Users typing: ${indicator.typingUsers.map((u) => u.fullName).join(", ")}');

        state = indicator;

        // Auto-clear typing indicator after 3 seconds of no updates
        _stopTimer?.cancel();
        _stopTimer = Timer(const Duration(seconds: 3), () {
          if (state.typingUsers.isNotEmpty) {
            debugPrint('⏰ [Typing] Auto-clearing typing indicator (timeout)');
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

  /// Start typing - sends typing.start event
  void startTyping() {
    final wsDataSource = ref.read(chatWebSocketDataSourceProvider);

    // Debug log
    debugPrint('🟢 [Typing] START typing in conversation: $conversationId');

    // Send typing start immediately
    wsDataSource.sendTypingStart(conversationId);

    // Cancel existing timer
    _typingTimer?.cancel();

    // Send typing.start every 3 seconds while user is typing
    _typingTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      debugPrint('🔄 [Typing] Sending periodic typing.start for conversation: $conversationId');
      wsDataSource.sendTypingStart(conversationId);
    });
  }

  /// Stop typing - sends typing.stop event
  void stopTyping() {
    final wsDataSource = ref.read(chatWebSocketDataSourceProvider);

    // Debug log
    debugPrint('🔴 [Typing] STOP typing in conversation: $conversationId');

    // Cancel timer
    _typingTimer?.cancel();

    // Send typing stop
    wsDataSource.sendTypingStop(conversationId);
  }
}
