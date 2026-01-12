import 'dart:async';

import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_new.dart';
import 'package:chattrix_ui/features/poll/data/mappers/poll_mapper.dart';
import 'package:chattrix_ui/features/poll/data/models/poll_dto.dart';
import 'package:chattrix_ui/features/chat/data/mappers/event_mapper.dart';
import 'package:chattrix_ui/features/chat/data/models/event_dto.dart';
import 'package:chattrix_ui/features/chat/data/datasources/chat_websocket_datasource_impl.dart';
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

    final wsDataSource = ref.watch(chatWebSocketDataSourceProvider) as ChatWebSocketDataSourceImpl;

    final messageSubscription = wsDataSource.messageStream.listen((message) {
      if (message.conversationId.toString() == conversationId) {
        refresh();

        if (message.replyToMessageId != null) {
          Future.delayed(const Duration(milliseconds: 800), () => refresh());
        }
      }
    });

    final pollEventSubscription = wsDataSource.pollEventStream.listen((event) {
      _handlePollEvent(event);
    });

    final eventEventSubscription = wsDataSource.eventEventStream.listen((event) {
      _handleEventEvent(event);
    });

    _connectionSubscription = wsDataSource.connectionStream.listen((isConnected) {
      isConnected ? _stopPolling() : _startPolling();
    });

    if (!wsDataSource.isConnected) _startPolling();

    ref.onDispose(() {
      messageSubscription.cancel();
      pollEventSubscription.cancel();
      eventEventSubscription.cancel();
      _connectionSubscription?.cancel();
      _stopPolling();
    });

    return _fetchMessages(conversationId);
  }

  void _startPolling() {
    _stopPolling();
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (timer) => refresh());
  }

  void _stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  Future<List<Message>> _fetchMessages(String conversationId) async {
    final result = await _getMessagesUsecase(conversationId: conversationId, sort: 'DESC');

    return result.fold((failure) => throw Exception(failure.message), (messages) => messages);
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() => _fetchMessages(conversationId));
  }

  void _handlePollEvent(Map<String, dynamic> event) {
    try {
      final eventType = event['type'] as String?;
      final pollData = event['poll'] as Map<String, dynamic>?;

      if (eventType == null) return;

      if (eventType == 'POLL_DELETED') {
        final pollId = event['pollId'] as int?;
        if (pollId != null) _handlePollDeletedById(pollId);
        return;
      }

      if (pollData == null) return;

      final pollEntity = PollDto.fromJson(pollData).toEntity();

      if (pollEntity.conversationId.toString() != conversationId) return;

      switch (eventType) {
        case 'POLL_CREATED':
          Future.delayed(const Duration(milliseconds: 500), () => refresh());
          break;
        case 'POLL_VOTED':
        case 'POLL_CLOSED':
          _updatePollInState(pollEntity);
          break;
        default:
          debugPrint('📊 [Poll Event] Unknown type: $eventType');
      }
    } catch (e, st) {
      debugPrint('❌ [Poll Event] Error: $e \n $st');
    }
  }

  void _updatePollInState(dynamic pollEntity) {
    state.whenData((messages) {
      state = AsyncValue.data(
        messages.map((msg) {
          if (msg.type == 'POLL' && msg.pollData?.id == pollEntity.id) {
            return msg.copyWith(pollData: pollEntity);
          }
          return msg;
        }).toList(),
      );
    });
  }

  void _handlePollDeletedById(int pollId) {
    state.whenData((messages) {
      state = AsyncValue.data(
        messages.where((msg) {
          return !(msg.type == 'POLL' && msg.pollData?.id == pollId);
        }).toList(),
      );
    });
  }

  void _handleEventEvent(Map<String, dynamic> event) {
    try {
      final eventType = event['type'] as String?;
      final eventData = event['event'] as Map<String, dynamic>?;

      if (eventType == null) return;

      if (eventType == 'EVENT_DELETED') {
        final eventId = event['eventId'] as int?;
        if (eventId != null) _handleEventDeletedById(eventId);
        return;
      }

      if (eventData == null) return;

      final eventEntity = EventDto.fromJson(eventData).toEntity();

      if (eventEntity.conversationId.toString() != conversationId) return;

      switch (eventType) {
        case 'EVENT_CREATED':
          Future.delayed(const Duration(milliseconds: 500), () => refresh());
          break;
        case 'EVENT_UPDATED':
        case 'EVENT_RSVP_UPDATED':
          _updateEventInState(eventEntity);
          break;
        default:
          debugPrint('📅 [Event Event] Unknown type: $eventType');
      }
    } catch (e, st) {
      debugPrint('❌ [Event Event] Error: $e \n $st');
    }
  }

  void _updateEventInState(dynamic eventEntity) {
    state.whenData((messages) {
      state = AsyncValue.data(
        messages.map((msg) {
          if (msg.type == 'EVENT' && msg.eventData?.id == eventEntity.id) {
            return msg.copyWith(eventData: eventEntity);
          }
          return msg;
        }).toList(),
      );
    });
  }

  void _handleEventDeletedById(int eventId) {
    state.whenData((messages) {
      state = AsyncValue.data(
        messages.where((msg) {
          return !(msg.type == 'EVENT' && msg.eventData?.id == eventId);
        }).toList(),
      );
    });
  }
}
