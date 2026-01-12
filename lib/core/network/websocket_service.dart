import 'dart:async';
import 'dart:convert';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:chattrix_ui/core/network/websocket_connection_manager.dart';
import 'package:chattrix_ui/core/network/websocket_message_router.dart';

class WebSocketService {
  final WebSocketConnectionManager _connectionManager;
  final WebSocketMessageRouter _messageRouter;
  StreamSubscription<String>? _messageSubscription;

  WebSocketService({
    required WebSocketConnectionManager connectionManager,
    required WebSocketMessageRouter messageRouter,
  })  : _connectionManager = connectionManager,
        _messageRouter = messageRouter;

  Future<void> connect(String url) async {
    AppLogger.websocket('Service initiating connection...');
    await _connectionManager.connect(url);
    _subscribeToMessages();
  }

  Future<void> disconnect() async {
    AppLogger.websocket('Service disconnecting...');
    await _messageSubscription?.cancel();
    await _connectionManager.disconnect();
  }

  void send(Map<String, dynamic> payload) {
    if (!_connectionManager.client.isConnected) {
      AppLogger.websocket('Attempted to send message while disconnected', isError: true);
      return;
    }
    final jsonString = jsonEncode(payload);
    _connectionManager.client.send(jsonString);
  }

  void _subscribeToMessages() {
    _messageSubscription?.cancel();
    _messageSubscription = _connectionManager.client.messageStream.listen(
          (messageString) {
        try {
          final data = jsonDecode(messageString) as Map<String, dynamic>;
          _messageRouter.routeMessage(data);
        } catch (e, st) {
          AppLogger.error('Failed to parse WebSocket message', error: e, stackTrace: st, tag: 'WebSocketService');
        }
      },
      onError: (error) {
        AppLogger.websocket('Service message stream error: $error', isError: true);
      },
    );
  }

  WebSocketMessageRouter get messageRouter => _messageRouter;

  Stream<bool> get connectionStream => _connectionManager.client.connectionStream;

  bool get isConnected => _connectionManager.client.isConnected;

  void dispose() {
    _messageSubscription?.cancel();
    _messageRouter.dispose();
    _connectionManager.dispose();
  }
}