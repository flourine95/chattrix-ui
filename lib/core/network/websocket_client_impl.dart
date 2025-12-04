import 'dart:async';

import 'package:chattrix_ui/core/network/websocket_client.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Implementation of WebSocketClient using web_socket_channel package
class WebSocketClientImpl implements WebSocketClient {
  WebSocketChannel? _channel;

  final _messageController = StreamController<String>.broadcast();
  final _connectionController = StreamController<bool>.broadcast();

  @override
  Stream<String> get messageStream => _messageController.stream;

  @override
  Stream<bool> get connectionStream => _connectionController.stream;

  @override
  bool get isConnected => _channel != null;

  @override
  Future<void> connect(String url) async {
    if (_channel != null) {
      print('🔌 [WebSocketClient] Already connected');
      return;
    }

    try {
      print('🔌 [WebSocketClient] Connecting to: $url');
      _channel = WebSocketChannel.connect(Uri.parse(url));

      _connectionController.add(true);
      print('✅ [WebSocketClient] Connected successfully');

      // Listen to messages
      _channel!.stream.listen(
        (message) {
          if (message is String) {
            _messageController.add(message);
          }
        },
        onError: (error, stackTrace) {
          print('❌ [WebSocketClient] Connection error: $error');
          print('❌ [WebSocketClient] Stack trace: $stackTrace');
          _handleDisconnect();
        },
        onDone: () {
          print('🔌 [WebSocketClient] Connection closed gracefully');
          _handleDisconnect();
        },
        cancelOnError: false,
      );
    } catch (e, stackTrace) {
      print('❌ [WebSocketClient] Connection failed: $e');
      print('❌ [WebSocketClient] Stack trace: $stackTrace');
      _connectionController.add(false);
      _channel = null;
      rethrow;
    }
  }

  @override
  Future<void> disconnect() async {
    if (_channel != null) {
      await _channel!.sink.close();
      _channel = null;
      _connectionController.add(false);
    }
  }

  @override
  void send(String message) {
    if (_channel == null) return;
    _channel!.sink.add(message);
  }

  void _handleDisconnect() {
    _connectionController.add(false);
    _channel = null;
  }

  @override
  void dispose() {
    disconnect();
    _messageController.close();
    _connectionController.close();
  }
}

