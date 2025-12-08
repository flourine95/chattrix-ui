import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/network/websocket_providers.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/data/datasources/chat_websocket_datasource_impl.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/chat_websocket_datasource.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatWebSocketDataSourceProvider = Provider<ChatWebSocketDataSource>((ref) {
  final webSocketService = ref.watch(webSocketServiceProvider);

  final dataSource = ChatWebSocketDataSourceImpl(
    webSocketService: webSocketService,
  );

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

class WebSocketConnectionNotifier extends Notifier<WebSocketConnectionState> {
  @override
  WebSocketConnectionState build() {
    _initializeConnection();
    return WebSocketConnectionState();
  }

  Future<void> _initializeConnection() async {
    try {
      final tokenCache = ref.read(tokenCacheServiceProvider);
      final accessToken = await tokenCache.getAccessToken();

      if (accessToken == null || accessToken.isEmpty) {
        state = state.copyWith(error: 'Not authenticated', clearError: false);
        return;
      }


      final webSocketService = ref.read(webSocketServiceProvider);

      // Listen to connection state
      webSocketService.connectionStream.listen((isConnected) async {
        state = state.copyWith(isConnected: isConnected, clearError: true);

        if (!isConnected) {
          await Future.delayed(const Duration(seconds: 3));
          final freshToken = await tokenCache.getAccessToken();
          if (freshToken != null && freshToken != accessToken) {
            await webSocketService.disconnect();
            await Future.delayed(const Duration(milliseconds: 500));
            final wsUrl = ApiConstants.chatWebSocketWithToken(freshToken);
            await webSocketService.connect(wsUrl);
          }
        }
      });

      final wsUrl = ApiConstants.chatWebSocketWithToken(accessToken);
      await webSocketService.connect(wsUrl);

      state = state.copyWith(isConnected: true, clearError: true);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> reconnect() async {
    await _initializeConnection();
  }

  Future<void> disconnect() async {
    final webSocketService = ref.read(webSocketServiceProvider);
    await webSocketService.disconnect();
    state = state.copyWith(isConnected: false, clearError: true);
  }
}

final webSocketConnectionProvider = NotifierProvider<WebSocketConnectionNotifier, WebSocketConnectionState>(() {
  return WebSocketConnectionNotifier();
});
