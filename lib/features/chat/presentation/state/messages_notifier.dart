import 'dart:async';

import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_new.dart';
import 'package:chattrix_ui/features/poll/data/mappers/poll_mapper.dart';
import 'package:chattrix_ui/features/poll/data/models/poll_dto.dart';
import 'package:chattrix_ui/features/chat/data/models/event_dto.dart';
import 'package:chattrix_ui/features/chat/data/datasources/chat_websocket_datasource_impl.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'messages_notifier.g.dart';

@riverpod
class MessagesNotifier extends _$MessagesNotifier {
  late final _getMessagesUsecase = ref.read(getMessagesUsecaseProvider);
  Timer? _pollingTimer;
  StreamSubscription<bool>? _connectionSubscription;

  @override
  FutureOr<List<Message>> build(int conversationId) async {
    ref.keepAlive();

    final wsDataSource = ref.watch(chatWebSocketDataSourceProvider) as ChatWebSocketDataSourceImpl;

    final messageSubscription = wsDataSource.messageStream.listen((message) {
      if (message.conversationId == conversationId) {
        // ✅ Optimistic update: Add or update message immediately to UI
        state.whenData((messages) {
          final existingIndex = messages.indexWhere((m) => m.id == message.id);
          
          if (existingIndex != -1) {
            // Message exists - update it (e.g., RSVP update, poll vote update)
            final updatedMessages = List<Message>.from(messages);
            updatedMessages[existingIndex] = message;
            
            // Sort by createdAt DESC (newest first)
            updatedMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            state = AsyncValue.data(updatedMessages);
            
            debugPrint('🔄 Updated existing message ${message.id} (type: ${message.type})');
          } else {
            // New message - add it
            final updatedMessages = [message, ...messages]
              ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
            state = AsyncValue.data(updatedMessages);
            
            debugPrint('➕ Added new message ${message.id} (type: ${message.type})');
          }
        });
      }
    });

    final pollEventSubscription = wsDataSource.pollEventStream.listen((event) {
      _handlePollEvent(event);
    });

    final eventEventSubscription = wsDataSource.eventEventStream.listen((event) {
      _handleEventEvent(event);
    });

    // ✅ Listen to message ID updates (temp ID → real ID)
    final messageIdUpdateSubscription = wsDataSource.messageIdUpdateStream.listen((update) {
      final tempId = update['tempId'] as int;
      final realId = update['realId'] as int;
      final updateConversationId = update['conversationId'] as int;
      
      if (updateConversationId == conversationId) {
        state.whenData((messages) {
          final updatedMessages = messages.map((msg) {
            // Update message ID if it matches temp ID
            if (msg.id == tempId) {
              return msg.copyWith(id: realId);
            }
            // Update replyToMessageId if it references the temp ID
            if (msg.replyToMessageId == tempId) {
              return msg.copyWith(replyToMessageId: realId);
            }
            return msg;
          }).toList();
          
          // Check if we actually found and updated any message
          final wasUpdated = messages.any((m) => m.id == tempId || m.replyToMessageId == tempId);
          if (wasUpdated) {
            // Sort by createdAt DESC after updating ID
            updatedMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            state = AsyncValue.data(updatedMessages);
            debugPrint('🔄 Updated message ID: $tempId → $realId');
          }
        });
      }
    });

    _connectionSubscription = wsDataSource.connectionStream.listen((isConnected) {
      isConnected ? _stopPolling() : _startPolling();
    });

    if (!wsDataSource.isConnected) _startPolling();

    ref.onDispose(() {
      messageSubscription.cancel();
      pollEventSubscription.cancel();
      eventEventSubscription.cancel();
      messageIdUpdateSubscription.cancel();
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

  Future<List<Message>> _fetchMessages(int conversationId) async {
    final result = await _getMessagesUsecase(conversationId: conversationId, sort: 'DESC');

    return result.fold(
      (failure) {
        throw Exception(failure.message);
      },
      (messages) {
        // Get current user ID to inject into poll parsing
        final currentUser = ref.read(currentUserProvider);
        final currentUserId = currentUser?.id;
        
        // If we have currentUserId, re-parse messages with poll data to include voted state
        if (currentUserId != null) {
          return messages.map((msg) {
            // Only re-parse POLL messages
            if (msg.type == 'POLL' && msg.pollData != null) {
              // Re-calculate currentUserVotedOptionIds
              final updatedOptions = msg.pollData!.options.map((opt) {
                return opt;
              }).toList();
              
              final currentUserVotedOptionIds = <int>[];
              for (var option in msg.pollData!.options) {
                if (option.voters.any((v) => v.id == currentUserId)) {
                  currentUserVotedOptionIds.add(option.id);
                }
              }
              
              final updatedPollData = msg.pollData!.copyWith(
                currentUserVotedOptionIds: currentUserVotedOptionIds,
              );
              
              return msg.copyWith(pollData: updatedPollData);
            }
            return msg;
          }).toList();
        }
        
        return messages;
      },
    );
  }

  Future<void> refresh() async {
    final newMessages = await _fetchMessages(conversationId);
    
    state.whenData((currentMessages) {
      // Build a map of messages by ID
      final messageMap = <int, Message>{};
      
      // First, add all messages from API (real IDs)
      for (final msg in newMessages) {
        messageMap[msg.id] = msg;
      }
      
      // Then, add temp messages (negative IDs) that don't have real counterparts yet
      // We keep temp messages until they're replaced by real ones from API
      for (final msg in currentMessages) {
        if (msg.id < 0) {
          // Only keep temp message if we don't have a real one with similar content/timestamp
          final hasSimilarReal = newMessages.any((realMsg) =>
            realMsg.content == msg.content &&
            realMsg.type == msg.type &&
            realMsg.senderId == msg.senderId &&
            realMsg.createdAt.difference(msg.createdAt).inSeconds.abs() < 5
          );
          
          if (!hasSimilarReal) {
            messageMap[msg.id] = msg;
          }
        }
      }
      
      // Convert back to list and sort by createdAt DESC (newest first)
      final mergedMessages = messageMap.values.toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      
      state = AsyncValue.data(mergedMessages);
    });
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

      if (pollEntity.conversationId == conversationId) return;

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
      debugPrint('🔄 [MessagesNotifier] Current messages count: ${messages.length}');
      final updatedMessages = messages.map((msg) {
        if (msg.type == 'POLL' && msg.pollData?.id == pollEntity.id) {
          debugPrint('🔄 [MessagesNotifier] Found poll message ${msg.id}, updating...');
          return msg.copyWith(pollData: pollEntity);
        }
        return msg;
      }).toList();
      
      debugPrint('🔄 [MessagesNotifier] Updated messages, setting state...');
      state = AsyncValue.data(updatedMessages);
    });
  }

  /// Public method to update poll data in message (called after voting)
  void updatePollData(dynamic pollEntity) {
    debugPrint('🔄 [MessagesNotifier] Updating poll data for poll ${pollEntity.id}');
    debugPrint('🔄 [MessagesNotifier] Poll options: ${pollEntity.options.length}');
    debugPrint('🔄 [MessagesNotifier] Current user voted: ${pollEntity.currentUserVotedOptionIds}');
    _updatePollInState(pollEntity);
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

      // Only process events for this conversation
      if (eventEntity.conversationId != conversationId) return;

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

  /// Public method to update event data in message (called after RSVP)
  void updateEventData(dynamic eventEntity) {
    _updateEventInState(eventEntity);
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
