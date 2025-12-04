import 'package:chattrix_ui/core/network/websocket_manager_simple.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/data/services/chat_websocket_service_simple.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ✨ SIMPLE VERSION - Dùng Riverpod, không cần interface
///
/// Provider cho WebSocketManager - Riverpod tự động quản lý lifecycle
final webSocketManagerProvider = Provider<WebSocketManager>((ref) {
  final manager = WebSocketManager();

  // Riverpod tự động gọi dispose khi provider bị hủy
  ref.onDispose(() {
    manager.dispose();
  });

  return manager;
});

/// Provider cho ChatWebSocketService
final chatWebSocketServiceSimpleProvider = Provider<ChatWebSocketService>((ref) {
  final wsManager = ref.watch(webSocketManagerProvider);
  final service = ChatWebSocketService(wsManager: wsManager);

  ref.onDispose(() {
    service.dispose();
  });

  return service;
});

/// WebSocket connection state
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

/// Notifier để quản lý WebSocket connection
class WebSocketConnectionNotifierSimple extends Notifier<WebSocketConnectionState> {
  @override
  WebSocketConnectionState build() {
    _initializeConnection();
    return WebSocketConnectionState();
  }

  Future<void> _initializeConnection() async {
    try {
      // Lấy access token
      final tokenCache = ref.read(tokenCacheServiceProvider);
      final accessToken = await tokenCache.getAccessToken();

      if (accessToken == null) {
        print('🔌 [WebSocket] No access token');
        return;
      }

      // Lấy service từ Riverpod
      final service = ref.read(chatWebSocketServiceSimpleProvider);

      // Lắng nghe connection state
      service.connectionStream.listen((isConnected) async {
        state = state.copyWith(isConnected: isConnected, clearError: true);

        // Auto-reconnect với fresh token nếu bị disconnect
        if (!isConnected) {
          await Future.delayed(const Duration(seconds: 3));

          final freshToken = await tokenCache.getAccessToken();
          if (freshToken != null && freshToken != accessToken) {
            print('🔌 [WebSocket] Reconnecting with fresh token');
            await service.disconnect();
            await Future.delayed(const Duration(milliseconds: 500));
            await service.connect(freshToken);
          }
        }
      });

      // Disconnect nếu đã connect rồi
      if (service.isConnected) {
        await service.disconnect();
        await Future.delayed(const Duration(milliseconds: 500));
      }

      // Connect
      print('🔌 [WebSocket] Connecting...');
      await service.connect(accessToken);

      state = state.copyWith(isConnected: true, clearError: true);
    } catch (e) {
      print('🔌 [WebSocket] Error: $e');
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> reconnect() async {
    await _initializeConnection();
  }

  Future<void> disconnect() async {
    final service = ref.read(chatWebSocketServiceSimpleProvider);
    await service.disconnect();
    state = state.copyWith(isConnected: false, clearError: true);
  }
}

/// Provider cho WebSocket connection state
final webSocketConnectionSimpleProvider =
    NotifierProvider<WebSocketConnectionNotifierSimple, WebSocketConnectionState>(() {
  return WebSocketConnectionNotifierSimple();
});

