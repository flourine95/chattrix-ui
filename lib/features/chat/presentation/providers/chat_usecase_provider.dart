import 'package:chattrix_ui/features/chat/domain/usecases/create_conversation_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_conversation_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_conversations_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_online_users_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_user_status_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/search_users_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/toggle_reaction_usecase.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ========== Conversation Use Cases ==========

/// Provider for creating a new conversation
final createConversationUsecaseProvider = Provider<CreateConversationUsecase>((
  ref,
) {
  final repository = ref.watch(chatRepositoryProvider);
  return CreateConversationUsecase(repository);
});

/// Provider for getting all conversations
final getConversationsUsecaseProvider = Provider<GetConversationsUsecase>((
  ref,
) {
  final repository = ref.watch(chatRepositoryProvider);
  return GetConversationsUsecase(repository);
});

/// Provider for getting a specific conversation
final getConversationUsecaseProvider = Provider<GetConversationUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return GetConversationUsecase(repository);
});

// ========== Message Use Cases ==========

/// Provider for getting messages in a conversation
final getMessagesUsecaseProvider = Provider<GetMessagesUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return GetMessagesUsecase(repository);
});

/// Provider for sending a message
final sendMessageUsecaseProvider = Provider<SendMessageUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return SendMessageUsecase(repository);
});

// ========== User Status Use Cases ==========

/// Provider for getting online users
final getOnlineUsersUsecaseProvider = Provider<GetOnlineUsersUsecase>((ref) {
  final repository = ref.watch(userStatusRepositoryProvider);
  return GetOnlineUsersUsecase(repository);
});

/// Provider for getting user status
final getUserStatusUsecaseProvider = Provider<GetUserStatusUsecase>((ref) {
  final repository = ref.watch(userStatusRepositoryProvider);
  return GetUserStatusUsecase(repository);
});

// ========== Search Use Cases ==========

/// Provider for searching users
final searchUsersUsecaseProvider = Provider<SearchUsersUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return SearchUsersUsecase(repository);
});

// ========== Reaction Use Cases ==========

/// Provider for toggling reactions
final toggleReactionUsecaseProvider = Provider<ToggleReactionUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ToggleReactionUsecase(repository);
});
