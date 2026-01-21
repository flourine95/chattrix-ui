import 'dart:async';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:flutter/material.dart';

class WebSocketMessageRouter {
  final Map<String, StreamController<Map<String, dynamic>>> _controllers = {};
  final _rawMessageController = StreamController<Map<String, dynamic>>.broadcast();

  void registerMessageType(String messageType) {
    if (!_controllers.containsKey(messageType)) {
      AppLogger.websocket('Registering handler for type: $messageType');
      _controllers[messageType] = StreamController<Map<String, dynamic>>.broadcast();
    }
  }

  void unregisterMessageType(String messageType) {
    _controllers[messageType]?.close();
    _controllers.remove(messageType);
  }

  void routeMessage(Map<String, dynamic> message) {
    final type = message['type'] as String?;

    _rawMessageController.add(message);

    if (type == null) {
      AppLogger.websocket('Received message without type', isError: true);
      debugPrint('❌ [WS-Router] Message without type: $message');
      return;
    }

    debugPrint('🔀 [WS-Router] Routing message type: $type');

    final controller = _controllers[type];
    if (controller != null && !controller.isClosed) {
      debugPrint('✅ [WS-Router] Handler found for type: $type');
      controller.add(message);
    } else {
      debugPrint('⚠️ [WS-Router] No handler registered for type: $type');
      debugPrint('⚠️ [WS-Router] Available handlers: ${_controllers.keys.toList()}');
    }
  }

  Stream<Map<String, dynamic>> getStreamForType(String messageType) {
    registerMessageType(messageType);
    return _controllers[messageType]!.stream;
  }

  Stream<Map<String, dynamic>> getStreamForTypes(List<String> messageTypes) {
    final controller = StreamController<Map<String, dynamic>>.broadcast();

    for (final type in messageTypes) {
      registerMessageType(type);
      _controllers[type]!.stream.listen(
            (message) => controller.add(message),
        onError: (error) => controller.addError(error),
      );
    }

    return controller.stream;
  }

  Stream<Map<String, dynamic>> get rawMessageStream => _rawMessageController.stream;

  void dispose() {
    for (final controller in _controllers.values) {
      controller.close();
    }
    _controllers.clear();
    _rawMessageController.close();
  }
}