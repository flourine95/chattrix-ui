import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/data/services/chat_websocket_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ========== WebSocket Service ==========

/// Provider for WebSocket service
/// Manages real-time chat communication
/// This provider is kept alive to maintain WebSocket connection
final chatWebSocketServiceProvider = Provider<ChatWebSocketService>((ref) {
  final service = ChatWebSocketService();

  // Keep provider alive to maintain WebSocket connection
  ref.keepAlive();

  // Dispose when provider is explicitly invalidated
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
        return;
      }

      // Connect to WebSocket
      final wsService = ref.read(chatWebSocketServiceProvider);

      // Setup connection status listener BEFORE connecting
      // This ensures we catch all connection state changes
      wsService.connectionStream.listen((isConnected) async {
        state = state.copyWith(isConnected: isConnected, clearError: true);

        // If disconnected, try to reconnect with fresh token after a delay
        if (!isConnected) {
          await Future.delayed(const Duration(seconds: 3));

          // Get fresh token from storage (might have been refreshed)
          final freshToken = await secureStorage.read(
            key: ApiConstants.accessTokenKey,
          );
          if (freshToken != null && freshToken != accessToken) {
            await wsService.disconnect(); // Stop auto-reconnect with old token
            await Future.delayed(const Duration(milliseconds: 500));
            await wsService.connect(freshToken);
          }
        }
      });

      // Disconnect existing connection if any
      if (wsService.isConnected) {
        await wsService.disconnect();
        // Wait a bit before reconnecting
        await Future.delayed(const Duration(milliseconds: 500));
      }

      await wsService.connect(accessToken);

      state = state.copyWith(isConnected: true, clearError: true);
    } catch (e) {
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
