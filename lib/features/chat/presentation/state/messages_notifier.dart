import 'dart:async';

import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_new.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/pinned_messages_provider.dart';
import 'package:chattrix_ui/features/poll/data/mappers/poll_mapper.dart';
import 'package:chattrix_ui/features/poll/data/models/poll_dto.dart';
import 'package:chattrix_ui/features/chat/data/models/event_dto.dart';
import 'package:chattrix_ui/features/chat/data/datasources/chat_websocket_datasource_impl.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_notifier.dart';
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

    // ✅ Listen to message deletions
    final messageDeletedSubscription = wsDataSource.messageDeletedStream.listen((update) {
      final messageId = update['messageId'] as int;
      final deleteConversationId = update['conversationId'] as int;
      
      if (deleteConversationId == conversationId) {
        state.whenData((messages) {
          final updatedMessages = messages.where((msg) => msg.id != messageId).toList();
          state = AsyncValue.data(updatedMessages);
          debugPrint('🗑️ Deleted message $messageId from conversation $conversationId');
        });
      }
    });

    // ✅ Listen to message updates (edit)
    final messageUpdatedSubscription = wsDataSource.messageUpdatedStream.listen((update) {
      final messageId = update['messageId'] as int;
      final updateConversationId = update['conversationId'] as int;
      final content = update['content'] as String?;
      final isEdited = update['isEdited'] as bool? ?? true;
      
      if (updateConversationId == conversationId && content != null) {
        state.whenData((messages) {
          final updatedMessages = messages.map((msg) {
            if (msg.id == messageId) {
              return msg.copyWith(
                content: content,
                edited: isEdited,
                editedAt: DateTime.now(),
              );
            }
            return msg;
          }).toList();
          state = AsyncValue.data(updatedMessages);
          debugPrint('✏️ Updated message $messageId content');
        });
      }
    });

    // ✅ Listen to message pin/unpin
    final messagePinSubscription = wsDataSource.messagePinStream.listen((update) {
      final action = update['action'] as String?;
      final messageData = update['message'] as Map<String, dynamic>?;
      
      if (messageData != null) {
        final messageId = messageData['id'] as int;
        final messageConversationId = messageData['conversationId'] as int;
        final pinned = action == 'MESSAGE_PINNED';
        
        if (messageConversationId == conversationId) {
          state.whenData((messages) {
            final updatedMessages = messages.map((msg) {
              if (msg.id == messageId) {
                return msg.copyWith(pinned: pinned);
              }
              return msg;
            }).toList();
            state = AsyncValue.data(updatedMessages);
            debugPrint('📌 ${pinned ? 'Pinned' : 'Unpinned'} message $messageId');
            
            // ✅ Refresh pinned messages provider to update banner
            ref.invalidate(pinnedMessagesProvider(conversationId));
          });
        }
      }
    });

    // ✅ Listen to message reactions
    final messageReactionSubscription = wsDataSource.messageReactionStream.listen((update) {
      final messageId = update['messageId'] as int;
      final reactions = update['reactions'] as Map<String, dynamic>?;
      
      if (reactions != null) {
        state.whenData((messages) {
          // Check if message exists in current conversation
          final messageExists = messages.any((m) => m.id == messageId);
          
          if (messageExists) {
            // Convert reactions map to proper format
            final reactionsMap = <String, List<int>>{};
            reactions.forEach((emoji, userIds) {
              if (userIds is List) {
                reactionsMap[emoji] = List<int>.from(userIds);
              }
            });
            
            final updatedMessages = messages.map((msg) {
              if (msg.id == messageId) {
                return msg.copyWith(reactions: reactionsMap);
              }
              return msg;
            }).toList();
            state = AsyncValue.data(updatedMessages);
            debugPrint('👍 Updated reactions for message $messageId');
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
      messageDeletedSubscription.cancel();
      messageUpdatedSubscription.cancel();
      messagePinSubscription.cancel();
      messageReactionSubscription.cancel();
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
      // Extract payload from WebSocket message
      final payload = event['payload'] ?? event['data'] ?? event;
      final eventType = payload['type'] as String?;
      final pollData = payload['poll'] as Map<String, dynamic>?;

      if (eventType == null) return;

      debugPrint('📊 [Poll Event] Received event type: $eventType');

      if (eventType == 'POLL_DELETED') {
        final pollId = payload['pollId'] as int?;
        if (pollId != null) _handlePollDeletedById(pollId);
        return;
      }

      // For POLL_CREATED, refresh immediately to fetch complete poll data with votes
      // Don't parse pollData because it contains hasVoted=null which causes parsing errors
      if (eventType == 'POLL_CREATED') {
        debugPrint('📊 [Poll Event] POLL_CREATED - refreshing messages immediately...');
        // Refresh immediately to get poll with current vote data
        Future.delayed(const Duration(milliseconds: 100), () {
          refresh();
          debugPrint('📊 [Poll Event] Messages refreshed after poll creation');
        });
        return;
      }

      if (pollData == null) return;

      // For POLL_VOTED events from WebSocket, use simplified parsing
      if (eventType == 'POLL_VOTED') {
        _handlePollVotedEvent(pollData);
        return;
      }

      // For other events, use full PollDto parsing
      final pollEntity = PollDto.fromJson(pollData).toEntity();

      // Only process polls for this conversation
      if (pollEntity.conversationId != conversationId) return;

      switch (eventType) {
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

  void _handlePollVotedEvent(Map<String, dynamic> pollData) {
    try {
      debugPrint('🔍 [Poll Voted] Raw payload: $pollData');
      
      final messageId = pollData['messageId'] as int?;
      final options = pollData['options'] as List<dynamic>?;
      final totalVotes = pollData['totalVotes'] as int? ?? 0;

      if (messageId == null || options == null) {
        debugPrint('❌ [Poll Voted] Missing messageId or options');
        return;
      }

      debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      debugPrint('📊 [Poll Voted] WebSocket event received');
      debugPrint('📊 [Poll Voted] Message ID: $messageId');
      debugPrint('📊 [Poll Voted] Total votes from payload: $totalVotes');

      // ✅ Extract currentUserVotedOptionIds from hasVoted flags
      final currentUserVotedOptionIds = <int>[];
      for (final wsOption in options) {
        final optionId = wsOption['id'] as int?;
        final hasVoted = wsOption['hasVoted'] as bool?;
        final voteCount = wsOption['voteCount'] as int? ?? 0;
        
        debugPrint('   Option $optionId: $voteCount votes, hasVoted: $hasVoted');
        
        if (hasVoted == true && optionId != null) {
          currentUserVotedOptionIds.add(optionId);
        }
      }

      debugPrint('📊 [Poll Voted] Current user voted options: $currentUserVotedOptionIds');

      state.whenData((messages) {
        debugPrint('🔍 [Poll Voted] Searching for poll in ${messages.length} messages...');
        
        bool foundPoll = false;
        final updatedMessages = messages.map((msg) {
          if (msg.type == 'POLL' && msg.id == messageId && msg.pollData != null) {
            foundPoll = true;
            debugPrint('🔄 [Poll Voted] Found poll! Updating in state...');
            
            // Update vote counts AND calculate percentages
            final updatedOptions = msg.pollData!.options.map((existingOption) {
              // Find matching option in WebSocket data
              final wsOption = options.firstWhere(
                (opt) => opt['id'] == existingOption.id,
                orElse: () => null,
              );

              if (wsOption != null) {
                final voteCount = wsOption['voteCount'] as int? ?? existingOption.voteCount;
                
                // ✅ Calculate percentage on client side (backend sends 0.0)
                final percentage = totalVotes > 0 ? (voteCount / totalVotes) * 100.0 : 0.0;
                
                debugPrint('   Updating option ${existingOption.id}: voteCount=$voteCount, percentage=${percentage.toStringAsFixed(1)}%');
                
                return existingOption.copyWith(
                  voteCount: voteCount,
                  percentage: percentage,
                );
              }
              return existingOption;
            }).toList();

            // ✅ ALWAYS use WebSocket data - it has complete personalized info
            // DO NOT fallback to old data - WebSocket is source of truth
            final updatedPollData = msg.pollData!.copyWith(
              options: updatedOptions,
              totalVoters: totalVotes,
              currentUserVotedOptionIds: currentUserVotedOptionIds,
            );

            debugPrint('✅ [Poll Voted] Poll updated successfully');
            return msg.copyWith(pollData: updatedPollData);
          }
          return msg;
        }).toList();

        if (!foundPoll) {
          debugPrint('⚠️ [Poll Voted] Poll $messageId NOT FOUND in current conversation!');
          debugPrint('⚠️ [Poll Voted] Available message IDs: ${messages.map((m) => '${m.id}(${m.type})').join(', ')}');
        }

        state = AsyncValue.data(updatedMessages);
        debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      });
    } catch (e, st) {
      debugPrint('❌ [Poll Voted] Error: $e');
      debugPrint('Stack: $st');
    }
  }

  void _updatePollInState(dynamic pollEntity) {
    state.whenData((messages) {
      debugPrint('🔄 [MessagesNotifier] Current messages count: ${messages.length}');
      final updatedMessages = messages.map((msg) {
        if (msg.type == 'POLL' && msg.pollData?.id == pollEntity.id) {
          debugPrint('🔄 [MessagesNotifier] Found poll message ${msg.id}, updating...');
          
          // ⚠️ IMPORTANT: Preserve currentUserVotedOptionIds from existing poll data
          // WebSocket broadcasts contain updated vote counts but may have empty currentUserVotedOptionIds
          // We should only update if the new data explicitly has voted options
          final existingVotedIds = msg.pollData?.currentUserVotedOptionIds ?? <int>[];
          final newVotedIds = pollEntity.currentUserVotedOptionIds ?? <int>[];
          
          // Keep existing voted IDs if new data is empty (from WebSocket broadcast)
          // Update only if new data has voted IDs (from API response after voting)
          final finalVotedIds = newVotedIds.isNotEmpty ? newVotedIds : existingVotedIds;
          
          debugPrint('🔄 [MessagesNotifier] Existing voted IDs: $existingVotedIds');
          debugPrint('🔄 [MessagesNotifier] New voted IDs: $newVotedIds');
          debugPrint('🔄 [MessagesNotifier] Final voted IDs: $finalVotedIds');
          
          final updatedPoll = pollEntity.copyWith(
            currentUserVotedOptionIds: finalVotedIds,
          );
          
          return msg.copyWith(pollData: updatedPoll);
        }
        return msg;
      }).toList();
      
      debugPrint('🔄 [MessagesNotifier] Updated messages, setting state...');
      state = AsyncValue.data(updatedMessages);
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
