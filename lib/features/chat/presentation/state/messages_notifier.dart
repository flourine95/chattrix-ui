import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'messages_notifier.g.dart';

/// Notifier for managing messages in a conversation
/// Handles fetching and caching messages with real-time updates
@riverpod
class MessagesNotifier extends _$MessagesNotifier {
  late final _getMessagesUsecase = ref.read(getMessagesUsecaseProvider);

  @override
  FutureOr<List<Message>> build(String conversationId) async {
    // Listen to WebSocket for real-time message updates
    final wsService = ref.watch(chatWebSocketServiceProvider);
    wsService.messageStream.listen((messageModel) {
      if (messageModel.conversationId == conversationId) {
        debugPrint(
          '📨 New message received in conversation $conversationId, refreshing',
        );
        refresh();
      }
    });

    return _fetchMessages(conversationId);
  }

  /// Fetch messages from repository
  /// Messages are fetched in DESC order (newest first) by default
  Future<List<Message>> _fetchMessages(String conversationId) async {
    final result = await _getMessagesUsecase(
      conversationId: conversationId,
      sort: 'DESC', // Newest messages first
    );

    return result.fold(
      (failure) {
        debugPrint('❌ Failed to fetch messages: ${failure.message}');
        throw Exception(failure.message);
      },
      (messages) {
        debugPrint(
          '✅ Fetched ${messages.length} messages for conversation $conversationId',
        );

        if (messages.isNotEmpty) {
          debugPrint('📊 First message ID: ${messages.first.id}, content: ${messages.first.content}');
          debugPrint('📊 Last message ID: ${messages.last.id}, content: ${messages.last.content}');
        }

        return messages;
      },
    );
  }

  /// Refresh messages list
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchMessages(conversationId));
  }
}
