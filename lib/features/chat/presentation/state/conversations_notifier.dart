import 'dart:async';

import 'package:chattrix_ui/core/domain/enums/conversation_filter.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/utils/retry_helper.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation_update.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:chattrix_ui/features/chat/domain/entities/user_status_update.dart';
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

  final Map<int, List<TypingUser>> _typingStates = {};

  @override
  FutureOr<List<Conversation>> build() async {
    // Check if user is logged in first
    final isLoggedIn = await ref.read(isLoggedInUseCaseProvider)();
    if (!isLoggedIn) {
      return [];
    }
    ref.keepAlive();

    final wsDataSource = ref.watch(chatWebSocketDataSourceProvider);

    // Listen to WebSocket message events
    _messageSubscription = wsDataSource.messageStream.listen((message) {
      _handleMessageEvent(message);
    });

    // Listen to WebSocket conversation updates
    _conversationUpdateSubscription = wsDataSource.conversationUpdateStream.listen((update) {
      _handleConversationUpdateEvent(update);
    });

    // Listen to WebSocket user status events
    _userStatusSubscription = wsDataSource.userStatusStream.listen((statusUpdate) {
      _handleUserStatusEvent(statusUpdate);
    });

    // Listen to WebSocket typing indicator events
    _typingSubscription = wsDataSource.typingStream.listen((typingIndicator) {
      _handleTypingIndicatorEvent(typingIndicator);
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
    final isConnected = wsDataSource.isConnected;

    if (!isConnected) {
      _startPolling();
    }

    // Start UI refresh timer to update last seen badges every minute
    _startUiRefreshTimer();

    ref.onDispose(() {
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
    _pollingTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      refresh();
    });
  }

  void _stopPolling() {
    if (_pollingTimer != null) {
      _pollingTimer?.cancel();
      _pollingTimer = null;
    }
  }

  void _startUiRefreshTimer() {
    _stopUiRefreshTimer();
    _uiRefreshTimer = Timer.periodic(const Duration(seconds: 60), (timer) {
      _refreshUi();
    });
  }

  void _stopUiRefreshTimer() {
    if (_uiRefreshTimer != null) {
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
  }

  Future<List<Conversation>> _fetchConversations() async {
    // Double check if user is still logged in before fetching
    final isLoggedIn = await ref.read(isLoggedInUseCaseProvider)();
    if (!isLoggedIn) {
      return [];
    }

    // Get current filter from FilterNotifier
    final currentFilter = ref.read(filterProvider);

    // Use retry logic for network errors (timeout, connection issues)
    return await RetryHelper.retry(
      operation: () async {
        final result = await _getConversationsUsecase(filter: currentFilter);

        return result.fold(
          (failure) {
            // Handle specific failure types
            failure.when(
              server: (message, code, requestId) {},
              network: (message, code) {},
              validation: (message, code, details, requestId) {},
              auth: (message, code, requestId) {
                // Stop polling on auth errors
                _stopPolling();
                // Clear tokens
                _handleAuthError();
              },
              notFound: (message, code, requestId) {},
              conflict: (message, code, requestId) {},
              rateLimit: (message, code, requestId) {},
            );

            throw failure;
          },
          (conversations) {
            final filtered = _filterAndSortConversations(conversations);
            return filtered;
          },
        );
      },
      maxAttempts: 3,
      shouldRetry: (error) {
        // Don't retry auth errors
        if (error is Failure) {
          return error.maybeWhen(
            network: (_, _) => true,
            auth: (_, _, _) => false, // Don't retry auth errors
            orElse: () => false,
          );
        }
        return RetryHelper.isNetworkError(error);
      },
    );
  }

  /// Handle authentication errors by clearing tokens
  void _handleAuthError() {
    try {
      final tokenCache = ref.read(tokenCacheServiceProvider);
      tokenCache.clearTokens();
    } catch (_) {
      // Ignore errors during token clearing
    }
  }

  /// Filter and sort conversations based on pin/hide settings
  List<Conversation> _filterAndSortConversations(List<Conversation> conversations) {
    final currentFilter = ref.read(filterProvider);

    // Filter based on current filter
    List<Conversation> filtered;
    if (currentFilter == ConversationFilter.hidden) {
      // Show ONLY hidden conversations
      filtered = conversations.where((c) => c.settings?.hidden == true).toList();
    } else {
      // Filter out hidden conversations (show visible only)
      filtered = conversations.where((c) => c.settings?.hidden != true).toList();
    }

    // Sort: pinned first (by pinOrder), then by last message time
    filtered.sort((a, b) {
      final aPinned = a.settings?.pinned ?? false;
      final bPinned = b.settings?.pinned ?? false;

      // Both pinned - sort by pinOrder
      if (aPinned && bPinned) {
        final aOrder = a.settings?.pinOrder ?? 999;
        final bOrder = b.settings?.pinOrder ?? 999;
        return aOrder.compareTo(bOrder);
      }

      // Only a is pinned
      if (aPinned && !bPinned) return -1;

      // Only b is pinned
      if (!aPinned && bPinned) return 1;

      // Neither pinned - sort by last message time (most recent first)
      final aTime = a.lastMessage?.sentAt ?? a.updatedAt;
      final bTime = b.lastMessage?.sentAt ?? b.updatedAt;
      return bTime.compareTo(aTime);
    });

    return filtered;
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(_fetchConversations);
  }

  /// Apply a filter to the conversation list
  Future<void> applyFilter(ConversationFilter filter) async {
    // Update filter in FilterNotifier
    ref.read(filterProvider.notifier).setFilter(filter);

    // Refresh conversations with new filter
    await refresh();
  }

  /// Handle incoming message events from WebSocket
  void _handleMessageEvent(Message message) {
    final currentState = state.value;
    if (currentState == null) {
      return;
    }

    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
      return;
    }

    // Find the conversation
    final conversationIndex = currentState.indexWhere((c) => c.id == message.conversationId);
    if (conversationIndex == -1) {
      // Conversation not in list, refresh to get it
      refresh();
      return;
    }

    final conversation = currentState[conversationIndex];

    // Clear typing state for this conversation when message arrives
    _typingStates.remove(conversation.id);

    // Calculate new unread count
    final isFromMe = message.senderId == currentUser.id;
    final newUnreadCount = isFromMe ? conversation.unreadCount : conversation.unreadCount + 1;

    // Update conversation with new last message
    final updatedConversation = conversation.copyWith(
      lastMessage: message,
      updatedAt: message.createdAt,
      // Increment unread count if message is not from current user
      unreadCount: newUnreadCount,
    );

    // Create new list with updated conversation moved to top
    final updatedList = <Conversation>[updatedConversation, ...currentState.where((c) => c.id != conversation.id)];

    // Apply pin/hide filtering and sorting
    final filtered = _filterAndSortConversations(updatedList);

    // Update state
    state = AsyncValue.data(filtered);
  }

  /// Handle conversation update events from WebSocket
  void _handleConversationUpdateEvent(ConversationUpdate update) {
    final currentState = state.value;
    if (currentState == null) return;

    // Find the conversation
    final conversationIndex = currentState.indexWhere((c) => c.id == update.conversationId);
    if (conversationIndex == -1) {
      // Conversation not in list, refresh entire list
      refresh();
      return;
    }

    // For now, just refresh the entire list to get updated data
    refresh();
  }

  /// Handle user status events from WebSocket
  void _handleUserStatusEvent(UserStatusUpdate statusUpdate) {
    final currentState = state.value;
    if (currentState == null) {
      return;
    }

    final userId = int.tryParse(statusUpdate.userId);
    if (userId == null) {
      return;
    }

    bool hasChanges = false;

    final updatedList = currentState.map((conversation) {
      // Find if this user is a participant in this conversation
      final participantIndex = conversation.participants.indexWhere((p) => p.userId == userId);
      if (participantIndex == -1) return conversation;

      // Update participant's lastSeen (online status is now in cache)
      final updatedParticipants = List.of(conversation.participants);
      updatedParticipants[participantIndex] = updatedParticipants[participantIndex].copyWith(
        // ❌ REMOVED: online field (now tracked in OnlineStatusCache)
        lastSeen: statusUpdate.lastSeen != null ? DateTime.tryParse(statusUpdate.lastSeen!) : null,
      );

      hasChanges = true;
      return conversation.copyWith(participants: updatedParticipants);
    }).toList();

    if (hasChanges) {
      state = AsyncValue.data(updatedList);
    }
  }

  /// Handle typing indicator events from WebSocket
  void _handleTypingIndicatorEvent(TypingIndicator typingIndicator) {
    final currentState = state.value;
    if (currentState == null) return;

    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    final conversationId = int.tryParse(typingIndicator.conversationId);
    if (conversationId == null) {
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
        typingText = 'Typing...';
      } else {
        typingText = '${typingUsers.length} people are typing...';
      }

      // Create a temporary message to display typing indicator
      displayMessage = Message(
        id: -1,
        // Temporary ID
        conversationId: conversationId,
        senderId: typingUsers.first.id.hashCode,
        // Temporary sender ID
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
  }

  /// Reset unread count for a conversation
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
  }
}
