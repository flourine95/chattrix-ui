import 'dart:async';

import 'package:chattrix_ui/core/domain/enums/conversation_filter.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:chattrix_ui/core/utils/retry_helper.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation_update.dart';
import 'package:chattrix_ui/features/chat/domain/entities/user_status_update.dart';
import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_new.dart';
import 'package:chattrix_ui/features/chat/presentation/state/filter_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversations_notifier.g.dart';

@riverpod
class ConversationsNotifier extends _$ConversationsNotifier {
  late final _getConversationsUsecase = ref.read(getConversationsUsecaseProvider);
  Timer? _pollingTimer;
  Timer? _uiRefreshTimer;
  StreamSubscription<bool>? _connectionSubscription;
  StreamSubscription<Message>? _messageSubscription;
  StreamSubscription<ConversationUpdate>? _conversationUpdateSubscription;
  StreamSubscription<UserStatusUpdate>? _userStatusSubscription;
  StreamSubscription<TypingIndicator>? _typingSubscription;

  // Track typing states per conversation
  final Map<int, List<TypingUser>> _typingStates = {};

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

    // Listen to WebSocket message events
    _messageSubscription = wsDataSource.messageStream.listen((message) {
      AppLogger.debug(
        '📨 Message received via WebSocket for conversation ${message.conversationId}',
        tag: 'ConversationsNotifier',
      );
      _handleMessageEvent(message);
    });

    // Listen to WebSocket conversation updates
    _conversationUpdateSubscription = wsDataSource.conversationUpdateStream.listen((update) {
      AppLogger.debug(
        '📨 Conversation update received via WebSocket for conversation ${update.conversationId}',
        tag: 'ConversationsNotifier',
      );
      _handleConversationUpdateEvent(update);
    });

    // Listen to WebSocket user status events
    _userStatusSubscription = wsDataSource.userStatusStream.listen((statusUpdate) {
      AppLogger.debug(
        '📨 User status update received via WebSocket for user ${statusUpdate.userId}',
        tag: 'ConversationsNotifier',
      );
      _handleUserStatusEvent(statusUpdate);
    });

    // Listen to WebSocket typing indicator events
    _typingSubscription = wsDataSource.typingStream.listen((typingIndicator) {
      AppLogger.debug(
        '📨 Typing indicator received via WebSocket for conversation ${typingIndicator.conversationId}',
        tag: 'ConversationsNotifier',
      );
      _handleTypingIndicatorEvent(typingIndicator);
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

    // Start UI refresh timer to update last seen badges every minute
    _startUiRefreshTimer();

    ref.onDispose(() {
      AppLogger.debug('🧹 Disposing ConversationsNotifier...', tag: 'ConversationsNotifier');
      _messageSubscription?.cancel();
      _conversationUpdateSubscription?.cancel();
      _userStatusSubscription?.cancel();
      _typingSubscription?.cancel();
      _connectionSubscription?.cancel();
      _stopPolling();
      _stopUiRefreshTimer();
      _typingStates.clear();
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

  void _startUiRefreshTimer() {
    _stopUiRefreshTimer();
    AppLogger.debug('⏰ Starting UI refresh timer (every 60s) for last seen badges', tag: 'ConversationsNotifier');
    _uiRefreshTimer = Timer.periodic(const Duration(seconds: 60), (timer) {
      AppLogger.debug('⏰ UI refresh timer triggered - updating last seen badges', tag: 'ConversationsNotifier');
      _refreshUi();
    });
  }

  void _stopUiRefreshTimer() {
    if (_uiRefreshTimer != null) {
      AppLogger.debug('⏸️ Stopping UI refresh timer', tag: 'ConversationsNotifier');
      _uiRefreshTimer?.cancel();
      _uiRefreshTimer = null;
    }
  }

  /// Trigger a lightweight UI refresh without fetching new data
  /// This updates the UI to reflect time-based changes (e.g., "2m" → "3m")
  void _refreshUi() {
    final currentState = state.value;
    if (currentState == null) return;

    // Trigger rebuild by creating a new list reference
    // The UI will recalculate time-based displays (badges, timestamps)
    state = AsyncValue.data(List.of(currentState));
    AppLogger.debug('✅ UI refreshed for time-based updates', tag: 'ConversationsNotifier');
  }

  Future<List<Conversation>> _fetchConversations() async {
    AppLogger.debug('🔄 Starting to fetch conversations...', tag: 'ConversationsNotifier');

    // Double check if user is still logged in before fetching
    final isLoggedIn = await ref.read(isLoggedInUseCaseProvider)();
    if (!isLoggedIn) {
      AppLogger.warning('⚠️ User not logged in, skipping fetch', tag: 'ConversationsNotifier');
      return [];
    }

    // Get current filter from FilterNotifier
    final currentFilter = ref.read(filterProvider);
    AppLogger.debug('🔍 Using filter: $currentFilter', tag: 'ConversationsNotifier');

    // Use retry logic for network errors (timeout, connection issues)
    return await RetryHelper.retry(
      operation: () async {
        final result = await _getConversationsUsecase(filter: currentFilter);

        return result.fold(
          (failure) {
            AppLogger.error('❌ Failed to fetch conversations: ${failure.message}', tag: 'ConversationsNotifier');

            // Handle specific failure types
            failure.when(
              server: (message, code, requestId) {
                AppLogger.error('Server error: $code - $message', tag: 'ConversationsNotifier');
              },
              network: (message, code) {
                AppLogger.error('Network error: $code - $message', tag: 'ConversationsNotifier');
              },
              validation: (message, code, details, requestId) {
                AppLogger.error('Validation error: $code - $message', tag: 'ConversationsNotifier');
              },
              auth: (message, code, requestId) {
                AppLogger.error('Auth error: $code - $message', tag: 'ConversationsNotifier');
                // Auth errors will be handled in UI layer (redirect to login)
              },
              notFound: (message, code, requestId) {
                AppLogger.error('Not found error: $code - $message', tag: 'ConversationsNotifier');
              },
              conflict: (message, code, requestId) {
                AppLogger.error('Conflict error: $code - $message', tag: 'ConversationsNotifier');
              },
              rateLimit: (message, code, requestId) {
                AppLogger.error('Rate limit error: $code - $message', tag: 'ConversationsNotifier');
              },
            );

            throw failure;
          },
          (conversations) {
            AppLogger.info(
              '✅ Successfully fetched ${conversations.length} conversations',
              tag: 'ConversationsNotifier',
            );
            return conversations;
          },
        );
      },
      maxAttempts: 3,
      shouldRetry: (error) {
        // Only retry network errors (timeout, connection issues)
        if (error is Failure) {
          return error.maybeWhen(network: (_, _) => true, orElse: () => false);
        }
        return RetryHelper.isNetworkError(error);
      },
    );
  }

  Future<void> refresh() async {
    AppLogger.debug('🔄 Refreshing conversations...', tag: 'ConversationsNotifier');
    state = await AsyncValue.guard(_fetchConversations);
  }

  /// Apply a filter to the conversation list
  ///
  /// **Parameters:**
  /// - [filter]: The filter to apply (all, unread, groups)
  ///
  /// **Requirements**: 2.1, 2.2, 2.3
  Future<void> applyFilter(ConversationFilter filter) async {
    AppLogger.info('🔍 Applying filter: $filter', tag: 'ConversationsNotifier');

    // Update filter in FilterNotifier
    ref.read(filterProvider.notifier).setFilter(filter);

    // Refresh conversations with new filter
    await refresh();
  }

  /// Handle incoming message events from WebSocket
  ///
  /// Updates the conversation's last message, moves it to top of list,
  /// and increments unread count if message is not from current user.
  ///
  /// **Requirements**: 1.3, 1.4, 12.3
  void _handleMessageEvent(Message message) {
    final currentState = state.value;
    if (currentState == null) {
      AppLogger.warning('⚠️ No current state, cannot handle message event', tag: 'ConversationsNotifier');
      return;
    }

    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
      AppLogger.warning('⚠️ No current user, cannot handle message event', tag: 'ConversationsNotifier');
      return;
    }

    AppLogger.debug(
      '📨 Processing message event: conversationId=${message.conversationId}, senderId=${message.senderId}, currentUserId=${currentUser.id}',
      tag: 'ConversationsNotifier',
    );

    // Find the conversation
    final conversationIndex = currentState.indexWhere((c) => c.id == message.conversationId);
    if (conversationIndex == -1) {
      // Conversation not in list, refresh to get it
      AppLogger.debug(
        'Conversation ${message.conversationId} not found, refreshing list',
        tag: 'ConversationsNotifier',
      );
      refresh();
      return;
    }

    final conversation = currentState[conversationIndex];

    // Clear typing state for this conversation when message arrives
    _typingStates.remove(conversation.id);

    // Calculate new unread count
    final isFromMe = message.senderId == currentUser.id;
    final newUnreadCount = isFromMe ? conversation.unreadCount : conversation.unreadCount + 1;

    AppLogger.debug(
      '📊 Unread count update: isFromMe=$isFromMe, oldCount=${conversation.unreadCount}, newCount=$newUnreadCount',
      tag: 'ConversationsNotifier',
    );

    // Update conversation with new last message
    final updatedConversation = conversation.copyWith(
      lastMessage: message,
      updatedAt: message.createdAt,
      // Increment unread count if message is not from current user
      unreadCount: newUnreadCount,
    );

    // Create new list with updated conversation moved to top
    final updatedList = <Conversation>[updatedConversation, ...currentState.where((c) => c.id != conversation.id)];

    // Update state
    state = AsyncValue.data(updatedList);
    AppLogger.info(
      '✅ Updated conversation ${conversation.id} with new message (unread: $newUnreadCount)',
      tag: 'ConversationsNotifier',
    );
  }

  /// Handle conversation update events from WebSocket
  ///
  /// Refreshes the affected conversation to get latest data.
  ///
  /// **Requirements**: 1.3, 12.4
  void _handleConversationUpdateEvent(ConversationUpdate update) {
    final currentState = state.value;
    if (currentState == null) return;

    // Find the conversation
    final conversationIndex = currentState.indexWhere((c) => c.id == update.conversationId);
    if (conversationIndex == -1) {
      // Conversation not in list, refresh entire list
      AppLogger.debug('Conversation ${update.conversationId} not found, refreshing list', tag: 'ConversationsNotifier');
      refresh();
      return;
    }

    // For now, just refresh the entire list to get updated data
    // In a more optimized version, we could fetch just the single conversation
    AppLogger.debug(
      'Refreshing conversations due to update for conversation ${update.conversationId}',
      tag: 'ConversationsNotifier',
    );
    refresh();
  }

  /// Handle user status events from WebSocket
  ///
  /// Updates the participant's online status in all conversations where they appear.
  ///
  /// **Requirements**: 3.5, 7.3, 12.5
  void _handleUserStatusEvent(UserStatusUpdate statusUpdate) {
    final currentState = state.value;
    if (currentState == null) {
      AppLogger.debug('No current state, skipping user status update', tag: 'ConversationsNotifier');
      return;
    }

    final userId = int.tryParse(statusUpdate.userId);
    if (userId == null) {
      AppLogger.warning('Invalid userId in status update: ${statusUpdate.userId}', tag: 'ConversationsNotifier');
      return;
    }

    AppLogger.debug(
      '🔄 Processing user status update: userId=$userId, online=${statusUpdate.isOnline}, lastSeen=${statusUpdate.lastSeen}',
      tag: 'ConversationsNotifier',
    );

    bool hasChanges = false;
    int conversationsUpdated = 0;

    final updatedList = currentState.map((conversation) {
      // Find if this user is a participant in this conversation
      final participantIndex = conversation.participants.indexWhere((p) => p.userId == userId);
      if (participantIndex == -1) return conversation;

      final oldParticipant = conversation.participants[participantIndex];
      AppLogger.debug(
        '  📝 Found user $userId in conversation ${conversation.id}: old online=${oldParticipant.online}, new online=${statusUpdate.isOnline}',
        tag: 'ConversationsNotifier',
      );

      // Update participant's online status and lastSeen
      final updatedParticipants = List.of(conversation.participants);
      updatedParticipants[participantIndex] = updatedParticipants[participantIndex].copyWith(
        online: statusUpdate.isOnline,
        lastSeen: statusUpdate.lastSeen != null ? DateTime.tryParse(statusUpdate.lastSeen!) : null,
      );

      hasChanges = true;
      conversationsUpdated++;
      return conversation.copyWith(participants: updatedParticipants);
    }).toList();

    if (hasChanges) {
      state = AsyncValue.data(updatedList);
      AppLogger.info(
        '✅ Updated online status for user $userId to ${statusUpdate.isOnline} in $conversationsUpdated conversation(s)',
        tag: 'ConversationsNotifier',
      );
    } else {
      AppLogger.debug('⚠️ No conversations found with user $userId as participant', tag: 'ConversationsNotifier');
    }
  }

  /// Handle typing indicator events from WebSocket
  ///
  /// Shows "Đang soạn tin..." when users are typing, reverts to actual last message when typing stops.
  /// Handles multiple users typing in groups.
  ///
  /// **Requirements**: 4.1, 4.2, 4.3, 4.4, 4.5
  void _handleTypingIndicatorEvent(TypingIndicator typingIndicator) {
    final currentState = state.value;
    if (currentState == null) return;

    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    final conversationId = int.tryParse(typingIndicator.conversationId);
    if (conversationId == null) {
      AppLogger.warning(
        'Invalid conversationId in typing indicator: ${typingIndicator.conversationId}',
        tag: 'ConversationsNotifier',
      );
      return;
    }

    // Update typing state
    final typingUsers = typingIndicator.typingUsers.where((user) => user.id != currentUser.id.toString()).toList();

    if (typingUsers.isEmpty) {
      _typingStates.remove(conversationId);
    } else {
      _typingStates[conversationId] = typingUsers;
    }

    // Find the conversation
    final conversationIndex = currentState.indexWhere((c) => c.id == conversationId);
    if (conversationIndex == -1) return;

    final conversation = currentState[conversationIndex];

    // Create a temporary message for typing indicator
    Message? displayMessage;
    if (typingUsers.isNotEmpty) {
      String typingText;
      if (typingUsers.length == 1) {
        typingText = 'Đang soạn tin...';
      } else {
        typingText = '${typingUsers.length} người đang soạn tin...';
      }

      // Create a temporary message to display typing indicator
      displayMessage = Message(
        id: -1, // Temporary ID
        conversationId: conversationId,
        senderId: typingUsers.first.id.hashCode, // Temporary sender ID
        senderUsername: typingUsers.first.username,
        content: typingText,
        type: 'TEXT',
        createdAt: DateTime.now(),
      );
    } else {
      // Revert to actual last message
      displayMessage = conversation.lastMessage;
    }

    // Update conversation with typing indicator or revert to last message
    final updatedConversation = conversation.copyWith(lastMessage: displayMessage);

    // Create new list with updated conversation
    final updatedList = currentState.map((c) => c.id == conversationId ? updatedConversation : c).toList();

    // Update state
    state = AsyncValue.data(updatedList);
    AppLogger.debug(
      'Updated typing indicator for conversation $conversationId: ${typingUsers.length} users typing',
      tag: 'ConversationsNotifier',
    );
  }

  /// Reset unread count for a conversation
  ///
  /// Called after marking conversation as read via API.
  /// Updates the local state immediately for better UX.
  ///
  /// **Parameters:**
  /// - [conversationId]: ID of the conversation to reset unread count
  void resetUnreadCount(int conversationId) {
    final currentState = state.value;
    if (currentState == null) return;

    final updatedList = currentState.map((conversation) {
      if (conversation.id == conversationId) {
        return conversation.copyWith(unreadCount: 0);
      }
      return conversation;
    }).toList();

    state = AsyncValue.data(updatedList);
    AppLogger.debug('✅ Reset unread count for conversation $conversationId', tag: 'ConversationsNotifier');
  }
}
