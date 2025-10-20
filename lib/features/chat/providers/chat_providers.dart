import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/data/datasources/chat_remote_datasource_impl.dart';
import 'package:chattrix_ui/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:chattrix_ui/features/chat/data/repositories/user_status_repository_impl.dart';
import 'package:chattrix_ui/features/chat/data/services/chat_websocket_service.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/chat_remote_datasource.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/user_status_repository.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/create_conversation_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_conversation_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_conversations_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_online_users_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_user_status_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:flutter/foundation.dart';
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

final sendMessageUsecaseProvider = Provider<SendMessageUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return SendMessageUsecase(repository);
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

// ========== WebSocket Connection Manager ==========

class WebSocketConnectionState {
  final bool isConnected;
  final String? error;

  WebSocketConnectionState({
    this.isConnected = false,
    this.error,
  });

  WebSocketConnectionState copyWith({
    bool? isConnected,
    String? error,
    bool clearError = false,
  }) {
    return WebSocketConnectionState(
      isConnected: isConnected ?? this.isConnected,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class WebSocketConnectionNotifier extends Notifier<WebSocketConnectionState> {
  @override
  WebSocketConnectionState build() {
    _initializeConnection();
    return WebSocketConnectionState();
  }

  Future<void> _initializeConnection() async {
    try {
      // Get access token from secure storage
      final secureStorage = ref.read(secureStorageProvider);
      final accessToken = await secureStorage.read(key: ApiConstants.accessTokenKey);

      if (accessToken == null) {
        debugPrint('⚠️ No access token found, skipping WebSocket connection');
        return;
      }

      // Connect to WebSocket
      final wsService = ref.read(chatWebSocketServiceProvider);
      await wsService.connect(accessToken);

      // Listen to connection status
      wsService.connectionStream.listen((isConnected) {
        state = state.copyWith(isConnected: isConnected, clearError: true);
      });

      state = state.copyWith(isConnected: true, clearError: true);
      debugPrint('✅ WebSocket connection initialized');
    } catch (e) {
      debugPrint('❌ Failed to initialize WebSocket: $e');
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> reconnect() async {
    await _initializeConnection();
  }

  Future<void> disconnect() async {
    final wsService = ref.read(chatWebSocketServiceProvider);
    await wsService.disconnect();
    state = state.copyWith(isConnected: false, clearError: true);
  }
}

/// Provider to manage WebSocket connection state
final webSocketConnectionProvider = NotifierProvider<WebSocketConnectionNotifier, WebSocketConnectionState>(() {
  return WebSocketConnectionNotifier();
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

/// Provider for messages in a specific conversation with real-time updates
final messagesProvider = FutureProvider.family<List<Message>, String>((ref, conversationId) async {
  final usecase = ref.watch(getMessagesUsecaseProvider);
  final result = await usecase(conversationId: conversationId);

  // Listen to WebSocket for real-time updates
  final wsService = ref.watch(chatWebSocketServiceProvider);
  wsService.messageStream.listen((messageModel) {
    if (messageModel.conversationId == conversationId) {
      // Invalidate provider to trigger refresh
      ref.invalidateSelf();
    }
  });

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
