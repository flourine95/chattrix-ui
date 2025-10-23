import 'package:chattrix_ui/features/chat/domain/entities/search_user.dart';
import 'package:chattrix_ui/features/chat/domain/entities/user_status.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// NOTE: conversationsProvider and messagesProvider are now in their respective Notifier files:
// - conversations_notifier.dart
// - messages_notifier.dart

// ========== Online Users State ==========

/// Provider for online users list
final onlineUsersProvider = FutureProvider((ref) async {
  final usecase = ref.watch(getOnlineUsersUsecaseProvider);
  final result = await usecase();

  return result.fold(
    (failure) => throw Exception(failure.message),
    (users) => users,
  );
});

// ========== User Status State ==========

/// Provider for a specific user's status
final userStatusProvider = FutureProvider.family<UserStatus, String>((
  ref,
  userId,
) async {
  final usecase = ref.watch(getUserStatusUsecaseProvider);
  final result = await usecase(userId);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (status) => status,
  );
});

// ========== Search Users State ==========

/// Provider for searching users
final searchUsersProvider = FutureProvider.family<List<SearchUser>, String>((
  ref,
  query,
) async {
  if (query.isEmpty) {
    return [];
  }

  final usecase = ref.watch(searchUsersUsecaseProvider);
  final result = await usecase(query: query);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (users) => users,
  );
});
