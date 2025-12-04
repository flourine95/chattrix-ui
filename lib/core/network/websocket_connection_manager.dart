import 'dart:async';

import 'package:chattrix_ui/core/network/websocket_client.dart';

/// WebSocket connection manager with automatic reconnection
/// Follows Clean Architecture by depending on abstraction (WebSocketClient)
class WebSocketConnectionManager {
  final WebSocketClient _client;
  final Duration reconnectDelay;
  final Duration heartbeatInterval;

  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  bool _isManualDisconnect = false;
  String? _lastUrl;

  WebSocketConnectionManager({
    required WebSocketClient client,
    this.reconnectDelay = const Duration(seconds: 5),
    this.heartbeatInterval = const Duration(seconds: 30),
  }) : _client = client;

  /// Connect to WebSocket server
  Future<void> connect(String url) async {
    _isManualDisconnect = false;
    _lastUrl = url;

    try {
      print('🔌 [WebSocketManager] Attempting to connect to: $url');
      await _client.connect(url);
      print('✅ [WebSocketManager] Connected successfully');
      _startHeartbeat();

      // Listen to client connection state for auto-reconnect
      _client.connectionStream.listen((isConnected) {
        if (!isConnected && !_isManualDisconnect && _lastUrl != null) {
          _stopHeartbeat();
          _scheduleReconnect();
        }
      });
    } catch (e) {
      print('🔌 [WebSocket] Connection failed: $e');
      _scheduleReconnect();
    }
  }

  /// Disconnect from WebSocket server
  Future<void> disconnect() async {
    _isManualDisconnect = true;
    _stopHeartbeat();
    _reconnectTimer?.cancel();
    _lastUrl = null;
    await _client.disconnect();
  }

  /// Schedule automatic reconnection
  void _scheduleReconnect() {
    _reconnectTimer?.cancel();

    if (_isManualDisconnect || _lastUrl == null) return;

    print('🔌 [WebSocket] Reconnecting in ${reconnectDelay.inSeconds}s...');
    _reconnectTimer = Timer(reconnectDelay, () {
      if (!_isManualDisconnect && _lastUrl != null) {
        connect(_lastUrl!);
      }
    });
  }

  /// Start heartbeat timer
  void _startHeartbeat() {
    _stopHeartbeat();

    _heartbeatTimer = Timer.periodic(heartbeatInterval, (timer) {
      if (_client.isConnected) {
        _client.send('{"type":"heartbeat","payload":{}}');
      }
    });
  }

  /// Stop heartbeat timer
  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  /// Get the underlying client
  WebSocketClient get client => _client;

  /// Dispose resources
  void dispose() {
    _stopHeartbeat();
    _reconnectTimer?.cancel();
    disconnect();
  }
}

