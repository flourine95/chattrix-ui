import 'package:chattrix_ui/features/chat/domain/entities/search_user.dart';
import 'package:chattrix_ui/features/chat/domain/entities/user_status.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final onlineUsersProvider = FutureProvider((ref) async {
  final usecase = ref.watch(getOnlineUsersUsecaseProvider);
  final result = await usecase();

  return result.fold((failure) => throw Exception(failure.message), (users) => users);
});

final userStatusProvider = FutureProvider.family<UserStatus, String>((ref, userId) async {
  final usecase = ref.watch(getUserStatusUsecaseProvider);
  final result = await usecase(userId);

  return result.fold((failure) => throw Exception(failure.message), (status) => status);
});

final searchUsersProvider = FutureProvider.family<List<SearchUser>, String>((ref, query) async {
  if (query.isEmpty) {
    return [];
  }

  final usecase = ref.watch(searchUsersUsecaseProvider);
  final result = await usecase(query: query);

  return result.fold((failure) => throw Exception(failure.message), (users) => users);
});

/// Global map to store message ID to scroll to
/// Used when navigating from search results to chat view
final _scrollToMessageMap = <String, int?>{};

/// Get message ID to scroll to for a conversation
int? getScrollToMessage(String conversationId) {
  return _scrollToMessageMap[conversationId];
}

/// Set message ID to scroll to for a conversation
void setScrollToMessage(String conversationId, int? messageId) {
  _scrollToMessageMap[conversationId] = messageId;
}

/// Clear message ID to scroll to for a conversation
void clearScrollToMessage(String conversationId) {
  _scrollToMessageMap.remove(conversationId);
}
