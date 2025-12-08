import 'dart:async';
import 'package:chattrix_ui/core/utils/app_logger.dart';

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
      return;
    }

    final controller = _controllers[type];
    if (controller != null && !controller.isClosed) {
      controller.add(message);
    } else {
      AppLogger.debug('No handler registered for type: $type', tag: 'WebSocketRouter');
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