import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';

/// Simple WebSocket Manager - No interfaces, just concrete implementation
/// Managed by Riverpod for lifecycle and dependency injection
class WebSocketManager {
  WebSocketChannel? _channel;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  bool _isManualDisconnect = false;
  String? _lastUrl;

  final Duration reconnectDelay;
  final Duration heartbeatInterval;

  final _messageController = StreamController<String>.broadcast();
  final _connectionController = StreamController<bool>.broadcast();

  WebSocketManager({
    this.reconnectDelay = const Duration(seconds: 5),
    this.heartbeatInterval = const Duration(seconds: 30),
  });

  // Public streams
  Stream<String> get messageStream => _messageController.stream;
  Stream<bool> get connectionStream => _connectionController.stream;
  bool get isConnected => _channel != null;

  /// Connect to WebSocket server
  Future<void> connect(String url) async {
    if (_channel != null) {
      return;
    }

    _isManualDisconnect = false;
    _lastUrl = url;

    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));
      _connectionController.add(true);

      // Listen to messages
      _channel!.stream.listen(
        (message) {
          if (message is String) {
            _messageController.add(message);
          }
        },
        onError: (error, stackTrace) {
          print('🔌 [WebSocket] Connection error: $error');
          _handleDisconnect();
        },
        onDone: () {
          print('🔌 [WebSocket] Connection closed');
          _handleDisconnect();
        },
        cancelOnError: false,
      );

      _startHeartbeat();
      print('🔌 [WebSocket] Connected');
    } catch (e) {
      print('🔌 [WebSocket] Connection failed: $e');
      _connectionController.add(false);
      _channel = null;
      _scheduleReconnect();
    }
  }

  /// Disconnect from WebSocket
  Future<void> disconnect() async {
    _isManualDisconnect = true;
    _stopHeartbeat();
    _reconnectTimer?.cancel();
    _lastUrl = null;

    if (_channel != null) {
      await _channel!.sink.close();
      _channel = null;
      _connectionController.add(false);
    }
  }

  /// Send message
  void send(String message) {
    if (_channel == null) return;
    _channel!.sink.add(message);
  }

  /// Send heartbeat
  void sendHeartbeat() {
    send('{"type":"heartbeat","payload":{}}');
  }

  void _handleDisconnect() {
    _connectionController.add(false);
    _channel = null;
    _stopHeartbeat();

    // Auto-reconnect if not manual disconnect
    if (!_isManualDisconnect && _lastUrl != null) {
      _scheduleReconnect();
    }
  }

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

  void _startHeartbeat() {
    _stopHeartbeat();
    _heartbeatTimer = Timer.periodic(heartbeatInterval, (_) {
      if (isConnected) {
        sendHeartbeat();
      }
    });
  }

  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  /// Dispose (called by Riverpod automatically)
  void dispose() {
    _stopHeartbeat();
    _reconnectTimer?.cancel();
    disconnect();
    _messageController.close();
    _connectionController.close();
  }
}

