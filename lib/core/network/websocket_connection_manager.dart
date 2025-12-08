import 'dart:async';

import 'package:chattrix_ui/core/network/websocket_client.dart';
import 'package:chattrix_ui/core/utils/app_logger.dart';

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

  Future<void> connect(String url) async {
    _isManualDisconnect = false;
    _lastUrl = url;

    try {
      await _client.connect(url);
      _startHeartbeat();

      _client.connectionStream.listen((isConnected) {
        if (!isConnected && !_isManualDisconnect && _lastUrl != null) {
          AppLogger.websocket('Connection lost. Stopping heartbeat and scheduling reconnect.');
          _stopHeartbeat();
          _scheduleReconnect();
        }
      });
    } catch (e) {
      AppLogger.websocket('Connect exception caught in manager. Scheduling reconnect.', isError: true);
      _scheduleReconnect();
    }
  }

  Future<void> disconnect() async {
    AppLogger.websocket('Manual disconnect requested');
    _isManualDisconnect = true;
    _stopHeartbeat();
    _reconnectTimer?.cancel();
    _lastUrl = null;
    await _client.disconnect();
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();

    if (_isManualDisconnect || _lastUrl == null) return;

    AppLogger.websocket('Scheduling reconnect in ${reconnectDelay.inSeconds}s');
    _reconnectTimer = Timer(reconnectDelay, () {
      if (!_isManualDisconnect && _lastUrl != null) {
        AppLogger.websocket('Attempting to reconnect...');
        connect(_lastUrl!);
      }
    });
  }

  void _startHeartbeat() {
    _stopHeartbeat();
    AppLogger.websocket('Starting heartbeat');

    _heartbeatTimer = Timer.periodic(heartbeatInterval, (timer) {
      if (_client.isConnected) {
        AppLogger.debug('Sending heartbeat', tag: 'WebSocket');
        _client.send('{"type":"heartbeat","payload":{}}');
      }
    });
  }

  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  WebSocketClient get client => _client;

  void dispose() {
    _stopHeartbeat();
    _reconnectTimer?.cancel();
    disconnect();
  }
}
