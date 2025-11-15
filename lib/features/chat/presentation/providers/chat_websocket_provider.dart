import 'package:chattrix_ui/core/constants/app_constants.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/data/services/chat_websocket_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatWebSocketServiceProvider = Provider<ChatWebSocketService>((ref) {
  final service = ChatWebSocketService();

  ref.keepAlive();

  ref.onDispose(() {
    service.dispose();
  });

  return service;
});

class WebSocketConnectionState {
  final bool isConnected;
  final String? error;

  WebSocketConnectionState({this.isConnected = false, this.error});

  WebSocketConnectionState copyWith({bool? isConnected, String? error, bool clearError = false}) {
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
      final secureStorage = ref.read(secureStorageProvider);
      final accessToken = await secureStorage.read(key: AppConstants.accessTokenKey);

      if (accessToken == null) {
        return;
      }

      final wsService = ref.read(chatWebSocketServiceProvider);

      wsService.connectionStream.listen((isConnected) async {
        state = state.copyWith(isConnected: isConnected, clearError: true);

        if (!isConnected) {
          await Future.delayed(const Duration(seconds: 3));

          final freshToken = await secureStorage.read(key: AppConstants.accessTokenKey);
          if (freshToken != null && freshToken != accessToken) {
            await wsService.disconnect();
            await Future.delayed(const Duration(milliseconds: 500));
            await wsService.connect(freshToken);
          }
        }
      });

      if (wsService.isConnected) {
        await wsService.disconnect();
        await Future.delayed(const Duration(milliseconds: 500));
      }

      await wsService.connect(accessToken);

      state = state.copyWith(isConnected: true, clearError: true);
    } catch (e) {
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

final webSocketConnectionProvider = NotifierProvider<WebSocketConnectionNotifier, WebSocketConnectionState>(() {
  return WebSocketConnectionNotifier();
});
