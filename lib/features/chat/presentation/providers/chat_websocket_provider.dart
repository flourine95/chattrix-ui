import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/data/services/chat_websocket_service.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ========== WebSocket Service ==========

/// Provider for WebSocket service
/// Manages real-time chat communication
final chatWebSocketServiceProvider = Provider<ChatWebSocketService>((ref) {
  final service = ChatWebSocketService();

  // Auto-dispose when provider is disposed
  ref.onDispose(() {
    service.dispose();
  });

  return service;
});

// ========== WebSocket Connection State ==========

/// State class for WebSocket connection
class WebSocketConnectionState {
  final bool isConnected;
  final String? error;

  WebSocketConnectionState({this.isConnected = false, this.error});

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

/// Notifier for managing WebSocket connection state
class WebSocketConnectionNotifier extends Notifier<WebSocketConnectionState> {
  @override
  WebSocketConnectionState build() {
    _initializeConnection();
    return WebSocketConnectionState();
  }

  /// Initialize WebSocket connection with access token
  Future<void> _initializeConnection() async {
    try {
      // Get access token from secure storage
      final secureStorage = ref.read(secureStorageProvider);
      final accessToken = await secureStorage.read(
        key: ApiConstants.accessTokenKey,
      );

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

  /// Manually reconnect to WebSocket
  Future<void> reconnect() async {
    await _initializeConnection();
  }

  /// Disconnect from WebSocket
  Future<void> disconnect() async {
    final wsService = ref.read(chatWebSocketServiceProvider);
    await wsService.disconnect();
    state = state.copyWith(isConnected: false, clearError: true);
  }
}

/// Provider to manage WebSocket connection state
final webSocketConnectionProvider =
    NotifierProvider<WebSocketConnectionNotifier, WebSocketConnectionState>(() {
      return WebSocketConnectionNotifier();
    });
