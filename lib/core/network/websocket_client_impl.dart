import 'dart:async';

import 'package:chattrix_ui/core/network/websocket_client.dart';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
      AppLogger.websocket('Client already connected');
      return;
    }

    try {
      AppLogger.websocket('Connecting to: $url');
      _channel = WebSocketChannel.connect(Uri.parse(url));

      _connectionController.add(true);
      AppLogger.websocket('Connection established');

      _channel!.stream.listen(
        (message) {
          if (message is String) {
            _messageController.add(message);
          }
        },
        onError: (error, stackTrace) {
          AppLogger.websocket('Stream error: $error', isError: true);
          _handleDisconnect();
        },
        onDone: () {
          AppLogger.websocket('Stream closed by server');
          _handleDisconnect();
        },
        cancelOnError: false,
      );
    } catch (e, stackTrace) {
      AppLogger.error('Connection failed', error: e, stackTrace: stackTrace, tag: 'WebSocket');
      _connectionController.add(false);
      _channel = null;
      rethrow;
    }
  }

  @override
  Future<void> disconnect() async {
    if (_channel != null) {
      AppLogger.websocket('Closing connection...');
      await _channel!.sink.close();
      _channel = null;
      _connectionController.add(false);
    }
  }

  @override
  void send(String message) {
    if (_channel == null) {
      AppLogger.websocket('Cannot send message: Not connected', isError: true);
      return;
    }
    _channel!.sink.add(message);
  }

  void _handleDisconnect() {
    if (_channel != null) {
      _connectionController.add(false);
      _channel = null;
      AppLogger.websocket('Disconnected handled');
    }
  }

  @override
  void dispose() {
    disconnect();
    _messageController.close();
    _connectionController.close();
  }
}
