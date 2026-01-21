import 'dart:async';
import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/network/websocket_providers.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_notifier.dart';
import 'package:chattrix_ui/features/chat/data/datasources/chat_websocket_datasource_impl.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/chat_websocket_datasource.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatWebSocketDataSourceProvider = Provider<ChatWebSocketDataSource>((ref) {
  final webSocketService = ref.watch(webSocketServiceProvider);

  final dataSource = ChatWebSocketDataSourceImpl(webSocketService: webSocketService);

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

  WebSocketConnectionState copyWith({bool? isConnected, String? error, bool clearError = false}) {
    return WebSocketConnectionState(
      isConnected: isConnected ?? this.isConnected,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class WebSocketConnectionNotifier extends Notifier<WebSocketConnectionState> {
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 5;
  Timer? _reconnectTimer;
  bool _shouldStopReconnecting = false;

  @override
  WebSocketConnectionState build() {
    // Reset reconnection flag when provider is rebuilt (e.g., after login)
    _shouldStopReconnecting = false;
    _reconnectAttempts = 0;
    
    _initializeConnection();

    ref.onDispose(() {
      _reconnectTimer?.cancel();
    });

    return WebSocketConnectionState();
  }

  Future<void> _initializeConnection() async {
    try {
      // Check if we should stop reconnecting (e.g., after auth error)
      if (_shouldStopReconnecting) {
        debugPrint('🛑 WebSocket reconnection stopped due to auth error');
        return;
      }

      final tokenCache = ref.read(tokenCacheServiceProvider);
      final accessToken = await tokenCache.getAccessToken();

      if (accessToken == null || accessToken.isEmpty) {
        debugPrint('⚠️ WebSocket: No access token available');
        state = state.copyWith(error: 'Not authenticated', clearError: false);
        // Don't reconnect if no token
        _shouldStopReconnecting = true;
        return;
      }

      final webSocketService = ref.read(webSocketServiceProvider);

      // Listen to connection state
      webSocketService.connectionStream.listen((isConnected) async {
        state = state.copyWith(isConnected: isConnected, clearError: true);

        if (!isConnected) {
          // Connection lost - attempt reconnection with exponential backoff
          _scheduleReconnect();
        } else {
          // Connection restored - reset reconnect attempts
          _reconnectAttempts = 0;
          _reconnectTimer?.cancel();
        }
      });

      final wsUrl = ApiConstants.chatWebSocketWithToken(accessToken);
      await webSocketService.connect(wsUrl);

      state = state.copyWith(isConnected: true, clearError: true);
      _reconnectAttempts = 0;
    } catch (e) {
      final errorMessage = e.toString();
      debugPrint('❌ WebSocket connection error: $errorMessage');
      
      // Check if error is auth-related
      if (_isAuthError(errorMessage)) {
        debugPrint('🛑 Auth error detected - stopping WebSocket reconnection');
        _shouldStopReconnecting = true;
        _reconnectTimer?.cancel();
        
        // Clear tokens on auth error
        try {
          final tokenCache = ref.read(tokenCacheServiceProvider);
          await tokenCache.clearTokens();
          debugPrint('🧹 Tokens cleared due to WebSocket auth error');
        } catch (e) {
          debugPrint('⚠️ Failed to clear tokens: $e');
        }
        
        state = state.copyWith(error: 'Authentication failed', clearError: false);
        return;
      }
      
      state = state.copyWith(error: errorMessage);
      // Schedule reconnect on connection failure (if not auth error)
      _scheduleReconnect();
    }
  }

  /// Check if error message indicates authentication failure
  bool _isAuthError(String errorMessage) {
    final lowerError = errorMessage.toLowerCase();
    return lowerError.contains('unauthorized') ||
        lowerError.contains('401') ||
        lowerError.contains('user not found') ||
        lowerError.contains('invalid token') ||
        lowerError.contains('token expired') ||
        lowerError.contains('authentication failed');
  }

  /// Schedule reconnection with exponential backoff
  ///
  /// Implements exponential backoff: 2s, 4s, 8s, 16s, 32s
  /// Enables polling fallback when WebSocket is disconnected
  void _scheduleReconnect() {
    _reconnectTimer?.cancel();

    // Don't reconnect if we should stop (e.g., auth error)
    if (_shouldStopReconnecting) {
      debugPrint('🛑 Reconnection cancelled - should stop reconnecting');
      return;
    }

    if (_reconnectAttempts >= _maxReconnectAttempts) {
      state = state.copyWith(error: 'Max reconnection attempts reached. Using polling fallback.', clearError: false);
      return;
    }

    _reconnectAttempts++;

    // Exponential backoff: 2^attempt seconds (2s, 4s, 8s, 16s, 32s)
    final delay = Duration(seconds: 1 << _reconnectAttempts);

    debugPrint(
      '🔄 Scheduling WebSocket reconnect attempt $_reconnectAttempts/$_maxReconnectAttempts in ${delay.inSeconds}s',
    );

    _reconnectTimer = Timer(delay, () {
      if (!state.isConnected && !_shouldStopReconnecting) {
        debugPrint('🔄 Attempting WebSocket reconnection...');
        _initializeConnection();
      }
    });
  }

  Future<void> reconnect() async {
    _reconnectAttempts = 0;
    _shouldStopReconnecting = false; // Reset flag when manually reconnecting
    _reconnectTimer?.cancel();
    await _initializeConnection();
  }

  Future<void> disconnect() async {
    _reconnectTimer?.cancel();
    _reconnectAttempts = 0;
    _shouldStopReconnecting = false;
    final webSocketService = ref.read(webSocketServiceProvider);
    await webSocketService.disconnect();
    state = state.copyWith(isConnected: false, clearError: true);
  }
}

final webSocketConnectionProvider = NotifierProvider<WebSocketConnectionNotifier, WebSocketConnectionState>(() {
  return WebSocketConnectionNotifier();
});
