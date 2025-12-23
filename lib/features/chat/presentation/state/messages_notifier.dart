import 'dart:async';

import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_new.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'messages_notifier.g.dart';

@riverpod
class MessagesNotifier extends _$MessagesNotifier {
  late final _getMessagesUsecase = ref.read(getMessagesUsecaseProvider);
  Timer? _pollingTimer;
  StreamSubscription<bool>? _connectionSubscription;

  @override
  FutureOr<List<Message>> build(String conversationId) async {
    ref.keepAlive();

    final wsDataSource = ref.watch(chatWebSocketDataSourceProvider);

    // Listen to WebSocket messages for event-driven updates
    final messageSubscription = wsDataSource.messageStream.listen((message) {
      if (message.conversationId.toString() == conversationId.toString()) {
        debugPrint('🔵 [MessagesNotifier] WebSocket message received, refreshing messages...');
        debugPrint('🔵 [MessagesNotifier] Message has replyToMessageId: ${message.replyToMessageId}');
        debugPrint(
          '🔵 [MessagesNotifier] Message has replyToMessage: ${message.replyToMessage != null ? "Present" : "NULL"}',
        );

        // Refresh immediately
        refresh();

        // If message has a replyToMessageId, refresh again after delay to ensure complete data
        if (message.replyToMessageId != null) {
          debugPrint('🔵 [MessagesNotifier] Reply message detected, scheduling second refresh...');
          Future.delayed(const Duration(milliseconds: 800), () {
            debugPrint('🔵 [MessagesNotifier] Executing delayed refresh for reply message...');
            refresh();
          });
        }
      }
    });

    // Listen to WebSocket connection state to toggle polling
    _connectionSubscription = wsDataSource.connectionStream.listen((isConnected) {
      if (isConnected) {
        // WebSocket connected - disable polling
        _stopPolling();
      } else {
        // WebSocket disconnected - enable polling
        _startPolling();
      }
    });

    // Check initial connection state
    if (!wsDataSource.isConnected) {
      _startPolling();
    }

    ref.onDispose(() {
      messageSubscription.cancel();
      _connectionSubscription?.cancel();
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
    final result = await _getMessagesUsecase(conversationId: conversationId, sort: 'DESC');

    return result.fold((failure) => throw Exception(failure.message), (messages) {
      // Debug: Log reply messages
      for (final msg in messages) {
        if (msg.replyToMessageId != null) {
          debugPrint('🔵 [_fetchMessages] Message #${msg.id} has replyToMessageId: ${msg.replyToMessageId}');
          debugPrint('🔵 [_fetchMessages] replyToMessage object: ${msg.replyToMessage != null ? "Present" : "NULL"}');
          if (msg.replyToMessage != null) {
            debugPrint('🔵 [_fetchMessages] replyToMessage content: "${msg.replyToMessage!.content}"');
          } else {
            debugPrint('❌ [_fetchMessages] replyToMessage is NULL - backend not returning nested object!');
          }
        }
      }

      // Debug: Log scheduled messages
      for (final msg in messages) {
        if (msg.sentAt != null && msg.createdAt != msg.sentAt) {
          final diff = msg.sentAt!.difference(msg.createdAt);
          debugPrint('🕐 Scheduled Message #${msg.id}:');
          debugPrint('   createdAt: ${msg.createdAt}');
          debugPrint('   sentAt: ${msg.sentAt}');
          debugPrint('   diff: ${diff.inMinutes} minutes');
        }
      }
      return messages;
    });
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() => _fetchMessages(conversationId));
  }
}
