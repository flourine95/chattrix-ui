import 'dart:async';

import 'package:chattrix_ui/core/constants/app_constants.dart';
import 'package:chattrix_ui/core/domain/enums/conversation_filter.dart';
import 'package:chattrix_ui/core/domain/enums/conversation_type.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/utils/retry_helper.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_notifier.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation_update.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/participant.dart';
import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:chattrix_ui/features/chat/domain/entities/user_status_update.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_new.dart';
import 'package:chattrix_ui/features/chat/presentation/state/filter_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversations_notifier.g.dart';

@Riverpod(keepAlive: true)
class ConversationsNotifier extends _$ConversationsNotifier {
  late final _getConversationsUsecase = ref.read(getConversationsUsecaseProvider);
  Timer? _pollingTimer;
  Timer? _uiRefreshTimer;
  StreamSubscription<bool>? _connectionSubscription;
  StreamSubscription<Message>? _messageSubscription;
  StreamSubscription<Map<String, dynamic>>? _conversationCreatedSubscription;
  StreamSubscription<ConversationUpdate>? _conversationUpdateSubscription;
  StreamSubscription<Map<String, dynamic>>? _permissionsUpdateSubscription;
  StreamSubscription<Map<String, dynamic>>? _memberLeftSubscription;
  StreamSubscription<Map<String, dynamic>>? _memberAddedSubscription;
  StreamSubscription<UserStatusUpdate>? _userStatusSubscription;
  StreamSubscription<TypingIndicator>? _typingSubscription;

  final Map<int, List<TypingUser>> _typingStates = {};

  @override
  FutureOr<List<Conversation>> build() async {
    ref.keepAlive();

    // Check if user is logged in
    final currentUser = ref.read(currentUserProvider);

    if (currentUser == null) {
      // No user logged in - return empty list
      // Router guard should prevent accessing this page without login
      return [];
    }

    final wsDataSource = ref.watch(chatWebSocketDataSourceProvider);

    // Listen to WebSocket message events
    _messageSubscription = wsDataSource.messageStream.listen((message) {
      _handleMessageEvent(message);
    });

    // Listen to WebSocket conversation created events
    _conversationCreatedSubscription = wsDataSource.conversationCreatedStream.listen((data) {
      _handleConversationCreatedEvent(data);
    });

    // Listen to WebSocket conversation updates
    _conversationUpdateSubscription = wsDataSource.conversationUpdateStream.listen((update) {
      _handleConversationUpdateEvent(update);
    });

    // Listen to WebSocket permissions updates
    _permissionsUpdateSubscription = wsDataSource.conversationPermissionsUpdatedStream.listen((data) {
      _handlePermissionsUpdatedEvent(data);
    });

    // Listen to WebSocket member left events
    _memberLeftSubscription = wsDataSource.conversationMemberLeftStream.listen((data) {
      _handleMemberLeftEvent(data);
    });

    // Listen to WebSocket member added events
    _memberAddedSubscription = wsDataSource.conversationMemberAddedStream.listen((data) {
      _handleMemberAddedEvent(data);
    });

    // Listen to WebSocket user status events
    _userStatusSubscription = wsDataSource.userStatusStream.listen((statusUpdate) {
      _handleUserStatusEvent(statusUpdate);
    });

    // Listen to WebSocket typing indicator events
    _typingSubscription = wsDataSource.typingStream.listen((typingIndicator) {
      _handleTypingIndicatorEvent(typingIndicator);
    });

    // Listen to WebSocket connection state to toggle fast polling
    _connectionSubscription = wsDataSource.connectionStream.listen((isConnected) {
      if (isConnected) {
        // WebSocket connected - use slow polling (60s) as backup
        _stopPolling();
        _startSlowPolling();
      } else {
        // WebSocket disconnected - use fast polling (10s)
        _stopPolling();
        _startPolling();
      }
    });

    // Check initial connection state
    final isConnected = wsDataSource.isConnected;

    if (!isConnected) {
      _startPolling();
    } else {
      _startSlowPolling();
    }

    // Start UI refresh timer to update last seen badges every minute
    _startUiRefreshTimer();

    ref.onDispose(() {
      _messageSubscription?.cancel();
      _conversationCreatedSubscription?.cancel();
      _conversationUpdateSubscription?.cancel();
      _permissionsUpdateSubscription?.cancel();
      _memberLeftSubscription?.cancel();
      _memberAddedSubscription?.cancel();
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
    _pollingTimer = Timer.periodic(AppConstants.fastPollingInterval, (timer) {
      refresh();
    });
  }

  void _startSlowPolling() {
    _stopPolling();
    _pollingTimer = Timer.periodic(AppConstants.slowPollingInterval, (timer) {
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
    _uiRefreshTimer = Timer.periodic(AppConstants.uiRefreshInterval, (timer) {
      _refreshUi();
    });
  }

  void _stopUiRefreshTimer() {
    if (_uiRefreshTimer != null) {
      _uiRefreshTimer?.cancel();
      _uiRefreshTimer = null;
    }
  }

  void _refreshUi() {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(List.of(currentState));
  }

  Future<List<Conversation>> _fetchConversations() async {
    // Double check if user is still logged in before fetching
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
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

    final conversation = currentState[conversationIndex];

    // Update conversation with new lastMessage if provided
    if (update.lastMessage != null) {
      final lastMessageInfo = update.lastMessage!;
      final updatedMessage = Message(
        id: lastMessageInfo.id,
        conversationId: update.conversationId,
        senderId: lastMessageInfo.senderId,
        senderUsername: lastMessageInfo.senderUsername,
        content: lastMessageInfo.content,
        type: lastMessageInfo.type,
        createdAt: DateTime.parse(lastMessageInfo.sentAt),
        sentAt: DateTime.parse(lastMessageInfo.sentAt),
      );

      final updatedConversation = conversation.copyWith(
        lastMessage: updatedMessage,
        updatedAt: DateTime.parse(update.updatedAt),
      );

      // Update list with new conversation
      final updatedList = currentState.map((c) {
        if (c.id == update.conversationId) {
          return updatedConversation;
        }
        return c;
      }).toList();

      // Apply sorting (move to top if has new message)
      final filtered = _filterAndSortConversations(updatedList);
      state = AsyncValue.data(filtered);
    } else {
      // No lastMessage info, refresh to get full data
      refresh();
    }
  }

  /// Handle conversation created events from WebSocket
  void _handleConversationCreatedEvent(Map<String, dynamic> data) {
    try {
      final conversationData = data['conversation'] as Map<String, dynamic>?;
      if (conversationData == null) {
        return;
      }

      // Parse conversation manually to avoid importing data layer models
      final conversation = _parseConversationFromWebSocket(conversationData);

      if (conversation != null) {
        // Check if this is an update (conversation already exists)
        final currentState = state.value;
        if (currentState != null) {
          final existingIndex = currentState.indexWhere((c) => c.id == conversation.id);
          if (existingIndex != -1) {
            // This is an update - merge with existing conversation
            final existing = currentState[existingIndex];
            final updated = existing.copyWith(
              name: conversation.name ?? existing.name,
              avatarUrl: conversation.avatarUrl ?? existing.avatarUrl,
              updatedAt: conversation.updatedAt,
            );

            // Update the conversation in the list
            final updatedList = currentState.map((c) => c.id == conversation.id ? updated : c).toList();
            final filtered = _filterAndSortConversations(updatedList);
            state = AsyncValue.data(filtered);
            return;
          }
        }

        // New conversation - add it
        addConversation(conversation);
      } else {
        refresh();
      }
    } catch (e) {
      // Fallback: refresh entire list
      refresh();
    }
  }

  /// Parse conversation from WebSocket data without importing data layer
  Conversation? _parseConversationFromWebSocket(Map<String, dynamic> json) {
    try {
      // Parse basic fields
      final id = json['id'] as int?;
      if (id == null) return null;

      final typeStr = (json['type'] as String?)?.toUpperCase();
      final type = typeStr == 'DIRECT' ? ConversationType.direct : ConversationType.group;

      // Parse participants
      final participantsJson = json['participants'] as List?;
      final participants = <Participant>[];

      if (participantsJson != null) {
        for (final p in participantsJson) {
          if (p is Map<String, dynamic>) {
            final participant = Participant(
              userId: p['userId'] as int? ?? p['id'] as int? ?? 0,
              username: p['username'] as String? ?? '',
              fullName: p['fullName'] as String? ?? '',
              role: p['role'] as String? ?? 'MEMBER',
              email: p['email'] as String?,
              nickname: p['nickname'] as String?,
              avatarUrl: p['avatarUrl'] as String?,
              lastSeen: p['lastSeen'] != null ? DateTime.tryParse(p['lastSeen'] as String) : null,
            );
            participants.add(participant);
          }
        }
      }

      // Parse last message if exists
      Message? lastMessage;
      final lastMessageJson = json['lastMessage'];
      if (lastMessageJson != null && lastMessageJson is Map<String, dynamic>) {
        lastMessage = Message(
          id: lastMessageJson['id'] as int? ?? 0,
          conversationId: id,
          senderId: lastMessageJson['senderId'] as int? ?? 0,
          senderUsername: lastMessageJson['senderUsername'] as String?,
          senderFullName: lastMessageJson['senderFullName'] as String?,
          content: lastMessageJson['content'] as String? ?? '',
          type: lastMessageJson['type'] as String? ?? 'TEXT',
          createdAt: lastMessageJson['createdAt'] != null
              ? DateTime.parse(lastMessageJson['createdAt'] as String)
              : DateTime.now(),
          sentAt: lastMessageJson['sentAt'] != null ? DateTime.parse(lastMessageJson['sentAt'] as String) : null,
        );
      }

      // Create conversation entity (description is not part of Conversation entity)
      return Conversation(
        id: id,
        name: json['name'] as String?,
        type: type,
        avatarUrl: json['avatarUrl'] as String?,
        createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : DateTime.now(),
        updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : DateTime.now(),
        participants: participants,
        lastMessage: lastMessage,
        unreadCount: json['unreadCount'] as int? ?? 0,
        settings: null, // Settings will be loaded on refresh
      );
    } catch (e) {
      return null;
    }
  }

  /// Handle permissions updated events from WebSocket
  void _handlePermissionsUpdatedEvent(Map<String, dynamic> data) {
    try {
      final conversationId = data['conversationId'] as int?;
      final permissions = data['permissions'] as Map<String, dynamic>?;
      final updatedByUsername = data['updatedByUsername'] as String?;

      if (conversationId == null || permissions == null) {
        debugPrint('⚠️ [Permissions] Invalid permissions update event');
        return;
      }

      debugPrint('🔧 [Permissions] Conversation $conversationId permissions updated by $updatedByUsername');
      debugPrint('🔧 [Permissions] New permissions: $permissions');

      // Notify permissions notifier if it's watching this conversation
      // The permissions notifier will handle the update via its own listener
      // We don't need to do anything here since permissions are not part of Conversation entity
    } catch (e) {
      debugPrint('❌ [Permissions] Error handling permissions update: $e');
    }
  }

  /// Handle member left events from WebSocket
  void _handleMemberLeftEvent(Map<String, dynamic> data) {
    try {
      final conversationId = data['conversationId'] as int?;
      final members = data['members'] as List?;

      if (conversationId == null || members == null) {
        debugPrint('⚠️ [MemberLeft] Invalid member left event');
        return;
      }

      debugPrint('👋 [MemberLeft] Members left conversation $conversationId');

      final currentState = state.value;
      if (currentState == null) return;

      // Check if current user is in the removed members list
      final currentUser = ref.read(currentUserProvider);
      if (currentUser != null) {
        final removedUserIds = members
            .whereType<Map<String, dynamic>>()
            .map((m) => m['userId'] as int?)
            .whereType<int>()
            .toList();

        if (removedUserIds.contains(currentUser.id)) {
          debugPrint('🚫 [MemberLeft] Current user was removed from conversation $conversationId');
          
          // Remove this conversation from the list entirely
          final updatedList = currentState.where((c) => c.id != conversationId).toList();
          final filtered = _filterAndSortConversations(updatedList);
          state = AsyncValue.data(filtered);
          
          debugPrint('✅ [MemberLeft] Removed conversation $conversationId from list');
          return;
        }
      }

      // Find the conversation
      final conversationIndex = currentState.indexWhere((c) => c.id == conversationId);
      if (conversationIndex == -1) {
        // Conversation not in list, might have been deleted
        refresh();
        return;
      }

      final conversation = currentState[conversationIndex];

      // Extract user IDs of members who left
      final leftUserIds = <int>[];
      for (final member in members) {
        if (member is Map<String, dynamic>) {
          final userId = member['userId'] as int?;
          if (userId != null) {
            leftUserIds.add(userId);
          }
        }
      }

      if (leftUserIds.isEmpty) {
        debugPrint('⚠️ [MemberLeft] No valid user IDs found');
        return;
      }

      debugPrint('👋 [MemberLeft] User IDs who left: $leftUserIds');

      // Remove the members from participants list
      final updatedParticipants = conversation.participants.where((p) => !leftUserIds.contains(p.userId)).toList();

      // Update conversation with new participants list
      final updatedConversation = conversation.copyWith(
        participants: updatedParticipants,
        updatedAt: DateTime.now(),
      );

      // Update list with new conversation
      final updatedList = currentState.map((c) {
        if (c.id == conversationId) {
          return updatedConversation;
        }
        return c;
      }).toList();

      // Apply sorting
      final filtered = _filterAndSortConversations(updatedList);
      state = AsyncValue.data(filtered);

      debugPrint('✅ [MemberLeft] Updated conversation $conversationId, now has ${updatedParticipants.length} participants');
    } catch (e) {
      debugPrint('❌ [MemberLeft] Error handling member left: $e');
      // Fallback: refresh entire list
      refresh();
    }
  }

  /// Handle member added events from WebSocket
  void _handleMemberAddedEvent(Map<String, dynamic> data) {
    try {
      final conversationId = data['conversationId'] as int?;
      final members = data['members'] as List?;

      if (conversationId == null || members == null) {
        debugPrint('⚠️ [MemberAdded] Invalid member added event');
        return;
      }

      debugPrint('👤 [MemberAdded] Members added to conversation $conversationId');

      final currentState = state.value;
      final currentUser = ref.read(currentUserProvider);
      
      if (currentUser == null) {
        debugPrint('⚠️ [MemberAdded] No current user');
        return;
      }

      // Check if current user is in the added members list
      final addedUserIds = members
          .whereType<Map<String, dynamic>>()
          .map((m) => m['userId'] as int?)
          .whereType<int>()
          .toList();

      if (addedUserIds.contains(currentUser.id)) {
        debugPrint('🎉 [MemberAdded] Current user was added to conversation $conversationId');
        // Current user was added to a new group - refresh entire list to fetch the new conversation
        refresh();
        return;
      }

      // Not current user - update existing conversation's participants
      if (currentState == null) {
        // No state yet, refresh to get full data
        refresh();
        return;
      }

      // Find the conversation
      final conversationIndex = currentState.indexWhere((c) => c.id == conversationId);
      if (conversationIndex == -1) {
        // Conversation not in list, but current user wasn't added, so ignore
        debugPrint('ℹ️ [MemberAdded] Conversation $conversationId not in list');
        return;
      }

      final conversation = currentState[conversationIndex];

      // Parse new members
      final newParticipants = <Participant>[];
      for (final member in members) {
        if (member is Map<String, dynamic>) {
          try {
            final participant = Participant(
              userId: member['userId'] as int? ?? 0,
              username: member['username'] as String? ?? '',
              fullName: member['fullName'] as String? ?? '',
              role: member['role'] as String? ?? 'MEMBER',
              email: member['email'] as String?,
              nickname: member['nickname'] as String?,
              avatarUrl: member['avatarUrl'] as String?,
              lastSeen: member['lastSeen'] != null ? DateTime.tryParse(member['lastSeen'] as String) : null,
            );
            newParticipants.add(participant);
          } catch (e) {
            debugPrint('⚠️ [MemberAdded] Error parsing participant: $e');
          }
        }
      }

      if (newParticipants.isEmpty) {
        debugPrint('⚠️ [MemberAdded] No valid participants found');
        return;
      }

      debugPrint('👤 [MemberAdded] Adding ${newParticipants.length} new participants');

      // Merge with existing participants (avoid duplicates)
      final existingUserIds = conversation.participants.map((p) => p.userId).toSet();
      final participantsToAdd = newParticipants.where((p) => !existingUserIds.contains(p.userId)).toList();

      if (participantsToAdd.isEmpty) {
        debugPrint('ℹ️ [MemberAdded] All members already in conversation');
        return;
      }

      final updatedParticipants = [...conversation.participants, ...participantsToAdd];

      // Update conversation with new participants list
      final updatedConversation = conversation.copyWith(
        participants: updatedParticipants,
        updatedAt: DateTime.now(),
      );

      // Update list with new conversation
      final updatedList = currentState.map((c) {
        if (c.id == conversationId) {
          return updatedConversation;
        }
        return c;
      }).toList();

      // Apply sorting
      final filtered = _filterAndSortConversations(updatedList);
      state = AsyncValue.data(filtered);

      debugPrint('✅ [MemberAdded] Updated conversation $conversationId, now has ${updatedParticipants.length} participants');
    } catch (e) {
      debugPrint('❌ [MemberAdded] Error handling member added: $e');
      // Fallback: refresh entire list
      refresh();
    }
  }

  void _handleUserStatusEvent(UserStatusUpdate statusUpdate) {
    final currentState = state.value;
    if (currentState == null) return;

    final userId = int.tryParse(statusUpdate.userId);
    if (userId == null) return;

    final updatedList = currentState.map((conversation) {
      final participantIndex = conversation.participants.indexWhere((p) => p.userId == userId);
      if (participantIndex == -1) return conversation;

      final updatedParticipants = List.of(conversation.participants);
      updatedParticipants[participantIndex] = updatedParticipants[participantIndex].copyWith(
        lastSeen: statusUpdate.lastSeen != null ? DateTime.tryParse(statusUpdate.lastSeen!) : null,
      );

      return conversation.copyWith(participants: updatedParticipants);
    }).toList();

    state = AsyncValue.data(updatedList);
  }

  /// Handle typing indicator events from WebSocket
  void _handleTypingIndicatorEvent(TypingIndicator typingIndicator) {
    final currentState = state.value;
    if (currentState == null) return;

    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    final conversationId = typingIndicator.conversationId;

    // Update typing state
    final typingUsers = typingIndicator.typingUsers.where((user) => user.id != currentUser.id).toList();

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

  /// Add a new conversation to the list (optimistic update)
  void addConversation(Conversation conversation) {
    final currentState = state.value;
    if (currentState == null) {
      state = AsyncValue.data([conversation]);
      return;
    }

    // Check if conversation already exists
    final exists = currentState.any((c) => c.id == conversation.id);
    if (exists) {
      // Update existing conversation
      final updatedList = currentState.map((c) {
        if (c.id == conversation.id) {
          return conversation;
        }
        return c;
      }).toList();

      final filtered = _filterAndSortConversations(updatedList);
      state = AsyncValue.data(filtered);
    } else {
      // Add new conversation at the top
      final updatedList = [conversation, ...currentState];
      final filtered = _filterAndSortConversations(updatedList);
      state = AsyncValue.data(filtered);
    }
  }
}
