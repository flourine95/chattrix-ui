import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/data/datasources/chat_remote_datasource_impl.dart';
import 'package:chattrix_ui/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:chattrix_ui/features/chat/data/repositories/user_status_repository_impl.dart';
import 'package:chattrix_ui/features/chat/data/services/chat_websocket_service.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/chat_remote_datasource.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/user_status_repository.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/create_conversation_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_conversation_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_conversations_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_online_users_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_user_status_usecase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ========== Data Sources ==========

final chatRemoteDatasourceProvider = Provider<ChatRemoteDatasource>((ref) {
  final dio = ref.watch(dioProvider);
  return ChatRemoteDatasourceImpl(dio: dio);
});

// ========== Repositories ==========

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final remoteDatasource = ref.watch(chatRemoteDatasourceProvider);
  return ChatRepositoryImpl(remoteDatasource: remoteDatasource);
});

final userStatusRepositoryProvider = Provider<UserStatusRepository>((ref) {
  final remoteDatasource = ref.watch(chatRemoteDatasourceProvider);
  return UserStatusRepositoryImpl(remoteDatasource: remoteDatasource);
});

// ========== Use Cases ==========

final createConversationUsecaseProvider = Provider<CreateConversationUsecase>((
  ref,
) {
  final repository = ref.watch(chatRepositoryProvider);
  return CreateConversationUsecase(repository);
});

final getConversationsUsecaseProvider = Provider<GetConversationsUsecase>((
  ref,
) {
  final repository = ref.watch(chatRepositoryProvider);
  return GetConversationsUsecase(repository);
});

final getConversationUsecaseProvider = Provider<GetConversationUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return GetConversationUsecase(repository);
});

final getMessagesUsecaseProvider = Provider<GetMessagesUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return GetMessagesUsecase(repository);
});

final getOnlineUsersUsecaseProvider = Provider<GetOnlineUsersUsecase>((ref) {
  final repository = ref.watch(userStatusRepositoryProvider);
  return GetOnlineUsersUsecase(repository);
});

final getUserStatusUsecaseProvider = Provider<GetUserStatusUsecase>((ref) {
  final repository = ref.watch(userStatusRepositoryProvider);
  return GetUserStatusUsecase(repository);
});

// ========== WebSocket Service ==========

final chatWebSocketServiceProvider = Provider<ChatWebSocketService>((ref) {
  final service = ChatWebSocketService();

  // Auto-dispose when provider is disposed
  ref.onDispose(() {
    service.dispose();
  });

  return service;
});

// ========== State Providers ==========

/// Provider for conversations list state
final conversationsProvider = FutureProvider((ref) async {
  final usecase = ref.watch(getConversationsUsecaseProvider);
  final result = await usecase();

  return result.fold(
    (failure) => throw Exception(failure.message),
    (conversations) => conversations,
  );
});

/// Provider for messages in a specific conversation
final messagesProvider = FutureProvider.family((
  ref,
  String conversationId,
) async {
  final usecase = ref.watch(getMessagesUsecaseProvider);
  final result = await usecase(conversationId: conversationId);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (messages) => messages,
  );
});

/// Provider for online users
final onlineUsersProvider = FutureProvider((ref) async {
  final usecase = ref.watch(getOnlineUsersUsecaseProvider);
  final result = await usecase();

  return result.fold(
    (failure) => throw Exception(failure.message),
    (users) => users,
  );
});

/// Provider for user status
final userStatusProvider = FutureProvider.family((ref, String userId) async {
  final usecase = ref.watch(getUserStatusUsecaseProvider);
  final result = await usecase(userId);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (status) => status,
  );
});
