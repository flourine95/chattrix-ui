import 'dart:async';

import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'typing_providers.g.dart';

@riverpod
class TypingNotifier extends _$TypingNotifier {
  StreamSubscription<TypingIndicator>? _subscription;

  @override
  Map<String, List<TypingUser>> build() {
    _listenToTypingStream();

    ref.onDispose(() {
      _subscription?.cancel();
    });

    return {};
  }

  void _listenToTypingStream() {
    try {
      final dataSource = ref.read(chatWebSocketDataSourceProvider);
      _subscription = dataSource.typingStream.listen(
        (indicator) {
          state = {...state, indicator.conversationId: indicator.typingUsers};

          if (indicator.typingUsers.isEmpty) {
            Future.delayed(const Duration(milliseconds: 500), () {
              if (state[indicator.conversationId]?.isEmpty ?? false) {
                final newState = Map<String, List<TypingUser>>.from(state);
                newState.remove(indicator.conversationId);
                state = newState;
              }
            });
          }
        },
        onError: (error) {
          debugPrint('❌ [TypingNotifier] Error listening to typing stream: $error');
        },
      );
      debugPrint('✅ [TypingNotifier] Started listening to typing stream');
    } catch (e) {
      debugPrint('❌ [TypingNotifier] Failed to listen to typing stream: $e');
    }
  }

  /// Send typing start event
  void sendTypingStart(String conversationId) {
    try {
      final dataSource = ref.read(chatWebSocketDataSourceProvider);
      dataSource.sendTypingStart(conversationId);
      debugPrint('⌨️ [TypingNotifier] Sent typing start for conversation: $conversationId');
    } catch (e) {
      debugPrint('❌ [TypingNotifier] Failed to send typing start: $e');
    }
  }

  /// Send typing stop event
  void sendTypingStop(String conversationId) {
    try {
      final dataSource = ref.read(chatWebSocketDataSourceProvider);
      dataSource.sendTypingStop(conversationId);
      debugPrint('⌨️ [TypingNotifier] Sent typing stop for conversation: $conversationId');
    } catch (e) {
      debugPrint('❌ [TypingNotifier] Failed to send typing stop: $e');
    }
  }

  /// Get typing users for a specific conversation (excluding current user)
  List<TypingUser> getTypingUsers(String conversationId, {String? excludeUserId}) {
    final users = state[conversationId] ?? [];
    if (excludeUserId != null) {
      return users.where((user) => user.id != excludeUserId).toList();
    }
    return users;
  }
}

/// Convenience provider to get typing users for a specific conversation
@riverpod
List<TypingUser> conversationTypingUsers(Ref ref, String conversationId) {
  final currentUser = ref.watch(currentUserProvider);
  final typingUsers = ref.watch(typingProvider);

  final users = typingUsers[conversationId] ?? [];

  debugPrint(
    '⌨️ [conversationTypingUsersProvider] conversationId=$conversationId, totalUsers=${users.length}, currentUserId=${currentUser?.id}',
  );

  // Exclude current user
  if (currentUser != null) {
    final filtered = users.where((user) => user.id != currentUser.id.toString()).toList();
    debugPrint('⌨️ [conversationTypingUsersProvider] After filtering: ${filtered.length} users');
    if (filtered.isNotEmpty) {
      debugPrint(
        '⌨️ [conversationTypingUsersProvider] Filtered users: ${filtered.map((u) => '${u.fullName}(${u.id})').join(', ')}',
      );
    }
    return filtered;
  }

  return users;
}
