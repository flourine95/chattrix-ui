import 'dart:async';

import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/features/contacts/presentation/providers/contact_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_new.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'online_users_notifier.g.dart';

/// Notifier for managing online users list
///
/// Fetches online users from contacts and listens to WebSocket user status events
/// to update the list in real-time.
@riverpod
class OnlineUsersNotifier extends _$OnlineUsersNotifier {
  StreamSubscription<dynamic>? _userStatusSubscription;

  @override
  FutureOr<List<User>> build() async {
    // Keep alive to maintain state across navigation
    ref.keepAlive();

    final wsDataSource = ref.watch(chatWebSocketDataSourceProvider);

    // Listen to WebSocket user status events
    _userStatusSubscription = wsDataSource.userStatusStream.listen((statusUpdate) {
      _handleUserStatusUpdate(userId: statusUpdate.userId, isOnline: statusUpdate.isOnline);
    });

    ref.onDispose(() {
      _userStatusSubscription?.cancel();
    });

    return _fetchOnlineUsers();
  }

  /// Fetch online users from contacts
  Future<List<User>> _fetchOnlineUsers() async {
    // Get all contacts
    final contactsState = ref.read(contactProvider);

    // Filter online contacts and convert to User entities
    final onlineUsers = contactsState.contacts
        .where((contact) => contact.online)
        .map(
          (contact) => User(
            id: contact.contactUserId,
            username: contact.username,
            email: '', // Not available in Contact entity
            emailVerified: false, // Not available in Contact entity
            fullName: contact.fullName,
            avatarUrl: contact.avatarUrl,
            online: contact.online,
            lastSeen: contact.lastSeen,
            createdAt: contact.createdAt,
          ),
        )
        .toList();

    // TODO: Remove mock users when real online users are available
    // Add mock users for testing notes feature
    if (onlineUsers.isEmpty) {
      return [
        User(
          id: 2,
          username: 'user2',
          email: 'user2@example.com',
          emailVerified: true,
          fullName: 'John Doe',
          avatarUrl: 'https://i.pravatar.cc/150?img=1',
          online: true,
          lastSeen: DateTime.now(),
          createdAt: DateTime.now(),
        ),
        User(
          id: 3,
          username: 'user3',
          email: 'user3@example.com',
          emailVerified: true,
          fullName: 'Jane Smith',
          avatarUrl: 'https://i.pravatar.cc/150?img=2',
          online: true,
          lastSeen: DateTime.now(),
          createdAt: DateTime.now(),
        ),
        User(
          id: 4,
          username: 'user4',
          email: 'user4@example.com',
          emailVerified: true,
          fullName: 'Bob Wilson',
          avatarUrl: 'https://i.pravatar.cc/150?img=3',
          online: true,
          lastSeen: DateTime.now(),
          createdAt: DateTime.now(),
        ),
      ];
    }

    return onlineUsers;
  }

  /// Refresh online users list
  Future<void> refresh() async {
    // Reload contacts first to get latest data
    await ref.read(contactProvider.notifier).loadContacts();

    // Then refresh online users
    state = await AsyncValue.guard(() => _fetchOnlineUsers());
  }

  /// Update user online status
  ///
  /// Called when receiving WebSocket user status events
  void _handleUserStatusUpdate({required String userId, required bool isOnline}) {
    final currentState = state.value;
    if (currentState == null) return;

    final userIdInt = int.tryParse(userId);
    if (userIdInt == null) return;

    if (isOnline) {
      // User came online - add to list if not already present
      if (!currentState.any((user) => user.id == userIdInt)) {
        // User not in list, need to fetch from contacts
        refresh();
      } else {
        // User already in list, just update status
        final updatedUsers = currentState.map((user) {
          if (user.id == userIdInt) {
            return user.copyWith(online: true, lastSeen: null);
          }
          return user;
        }).toList();

        state = AsyncValue.data(updatedUsers);
      }
    } else {
      // User went offline - remove from list
      final updatedUsers = currentState.where((user) => user.id != userIdInt).toList();

      state = AsyncValue.data(updatedUsers);
    }
  }

  /// Update user status manually (for testing or manual updates)
  void updateUserStatus(String userId, bool isOnline) {
    _handleUserStatusUpdate(userId: userId, isOnline: isOnline);
  }
}
