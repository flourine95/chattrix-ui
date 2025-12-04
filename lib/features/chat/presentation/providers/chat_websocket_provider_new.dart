import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/network/websocket_client_impl.dart';
import 'package:chattrix_ui/core/network/websocket_connection_manager.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/data/datasources/chat_websocket_datasource_impl.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/chat_websocket_datasource.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provider for WebSocket datasource
/// This uses Clean Architecture principles - the provider depends on abstractions
final chatWebSocketDataSourceProvider = Provider<ChatWebSocketDataSource>((ref) {
  // Create WebSocket client
  final client = WebSocketClientImpl();

  // Create connection manager
  final connectionManager = WebSocketConnectionManager(
    client: client,
  );

  // Create datasource
  final dataSource = ChatWebSocketDataSourceImpl(
    connectionManager: connectionManager,
  );

  // Dispose when provider is disposed
  ref.onDispose(() {
    dataSource.dispose();
  });

  return dataSource;
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

/// Notifier for managing WebSocket connection state
class WebSocketConnectionNotifier extends Notifier<WebSocketConnectionState> {
  @override
  WebSocketConnectionState build() {
    _initializeConnection();
    return WebSocketConnectionState();
  }

  Future<void> _initializeConnection() async {
    try {
      print('🔌 [WebSocketConnection] Initializing connection...');
      final tokenCache = ref.read(tokenCacheServiceProvider);
      final accessToken = await tokenCache.getAccessToken();

      if (accessToken == null || accessToken.isEmpty) {
        print('⚠️ [WebSocketConnection] No access token available - User not logged in');
        print('⚠️ [WebSocketConnection] Please login to connect to backend');
        state = state.copyWith(error: 'Not authenticated', clearError: false);
        return;
      }

      print('✅ [WebSocketConnection] Access token found, proceeding with connection');

      final dataSource = ref.read(chatWebSocketDataSourceProvider);

      // Listen to connection state
      dataSource.connectionStream.listen((isConnected) async {
        state = state.copyWith(isConnected: isConnected, clearError: true);

        // Handle reconnection with fresh token if needed
        if (!isConnected) {
          await Future.delayed(const Duration(seconds: 3));

          final freshToken = await tokenCache.getAccessToken();
          if (freshToken != null && freshToken != accessToken) {
            print('🔌 [WebSocketConnection] Reconnecting with fresh token');
            await dataSource.disconnect();
            await Future.delayed(const Duration(milliseconds: 500));
            await dataSource.connect(freshToken);
          }
        }
      });

      // Disconnect if already connected before connecting again
      if (dataSource.isConnected) {
        await dataSource.disconnect();
        await Future.delayed(const Duration(milliseconds: 500));
      }

      // Connect with token
      final wsUrl = ApiConstants.chatWebSocketWithToken(accessToken);
      print('🔌 [WebSocketConnection] Connecting to: $wsUrl');
      await dataSource.connect(accessToken);

      state = state.copyWith(isConnected: true, clearError: true);
    } catch (e) {
      print('🔌 [WebSocketConnection] Error: $e');
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> reconnect() async {
    await _initializeConnection();
  }

  Future<void> disconnect() async {
    final dataSource = ref.read(chatWebSocketDataSourceProvider);
    await dataSource.disconnect();
    state = state.copyWith(isConnected: false, clearError: true);
  }
}

/// Provider for WebSocket connection state
final webSocketConnectionProvider = NotifierProvider<WebSocketConnectionNotifier, WebSocketConnectionState>(() {
  return WebSocketConnectionNotifier();
});

