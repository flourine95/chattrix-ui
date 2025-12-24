import 'dart:async';

import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_new.dart';
import 'package:chattrix_ui/features/poll/data/models/poll_dto.dart';
import 'package:chattrix_ui/features/poll/data/mappers/poll_mapper.dart';
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

    // Listen to poll events
    final pollEventSubscription = wsDataSource.pollEventStream.listen((event) {
      _handlePollEvent(event);
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
      pollEventSubscription.cancel();
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

  void _handlePollEvent(Map<String, dynamic> event) {
    try {
      final eventType = event['type'] as String?;
      final pollData = event['poll'] as Map<String, dynamic>?;

      if (eventType == null || pollData == null) {
        debugPrint('❌ [Poll Event] Missing type or poll data');
        return;
      }

      debugPrint('📊 [Poll Event] Received: $eventType');

      // Parse poll data
      final pollDto = PollDto.fromJson(pollData);
      final pollEntity = pollDto.toEntity();

      // Check if this poll belongs to current conversation
      if (pollEntity.conversationId.toString() != conversationId) {
        debugPrint('📊 [Poll Event] Poll not for this conversation, ignoring');
        return;
      }

      switch (eventType) {
        case 'POLL_CREATED':
          _handlePollCreated(pollEntity);
          break;
        case 'POLL_VOTED':
          _handlePollVoted(pollEntity, event);
          break;
        case 'POLL_CLOSED':
          _handlePollClosed(pollEntity);
          break;
        case 'POLL_DELETED':
          _handlePollDeleted(pollEntity);
          break;
        default:
          debugPrint('📊 [Poll Event] Unknown event type: $eventType');
      }
    } catch (e, st) {
      debugPrint('❌ [Poll Event] Error handling poll event: $e');
      debugPrint('Stack trace: $st');
    }
  }

  void _handlePollCreated(pollEntity) {
    debugPrint('📊 [Poll Event] POLL_CREATED - Poll ID: ${pollEntity.id}');

    // Create new message with poll data
    final pollMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch, // Temporary ID
      conversationId: pollEntity.conversationId,
      senderId: pollEntity.creator.id,
      senderUsername: pollEntity.creator.username,
      senderFullName: pollEntity.creator.fullName,
      content: pollEntity.question,
      type: 'POLL',
      createdAt: pollEntity.createdAt,
      pollData: pollEntity,
    );

    // Add to messages list at the beginning
    state.whenData((messages) {
      state = AsyncValue.data([pollMessage, ...messages]);
    });
  }

  void _handlePollVoted(pollEntity, Map<String, dynamic> event) {
    final voter = event['voter'] as Map<String, dynamic>?;
    final voterName = voter?['fullName'] as String? ?? 'Someone';

    debugPrint('📊 [Poll Event] POLL_VOTED - Poll ID: ${pollEntity.id}, Voter: $voterName');

    // Create NEW message at top with updated poll data ("nổi lên" feature)
    final pollMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch, // Temporary ID
      conversationId: pollEntity.conversationId,
      senderId: pollEntity.creator.id,
      senderUsername: pollEntity.creator.username,
      senderFullName: pollEntity.creator.fullName,
      content: pollEntity.question,
      type: 'POLL',
      systemMessageType: 'POLL_UPDATE', // Mark as update
      createdAt: DateTime.now(),
      pollData: pollEntity,
    );

    // Add to top of messages
    state.whenData((messages) {
      state = AsyncValue.data([pollMessage, ...messages]);
    });

    // TODO: Show notification toast
    debugPrint('📊 [Poll Event] $voterName đã vote');
  }

  void _handlePollClosed(pollEntity) {
    debugPrint('📊 [Poll Event] POLL_CLOSED - Poll ID: ${pollEntity.id}');

    // Update all poll instances in messages
    state.whenData((messages) {
      final updatedMessages = messages.map((msg) {
        if (msg.type == 'POLL' && msg.pollData?.id == pollEntity.id) {
          return msg.copyWith(pollData: pollEntity);
        }
        return msg;
      }).toList();

      state = AsyncValue.data(updatedMessages);
    });
  }

  void _handlePollDeleted(pollEntity) {
    debugPrint('📊 [Poll Event] POLL_DELETED - Poll ID: ${pollEntity.id}');

    // Remove all poll instances from messages
    state.whenData((messages) {
      final filteredMessages = messages.where((msg) {
        return !(msg.type == 'POLL' && msg.pollData?.id == pollEntity.id);
      }).toList();

      state = AsyncValue.data(filteredMessages);
    });
  }
}
