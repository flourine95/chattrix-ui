import 'dart:async';
import 'package:chattrix_ui/core/network/websocket_service.dart';
import 'package:flutter/foundation.dart';

/// WebSocket events for friend requests
class ContactWebSocketEvents {
  static const String friendRequestReceived = 'friend.request.received';
  static const String friendRequestAccepted = 'friend.request.accepted';
  static const String friendRequestRejected = 'friend.request.rejected';
  static const String friendRequestCancelled = 'friend.request.cancelled';
}

/// WebSocket datasource for contact real-time updates
class ContactWebSocketDataSource {
  final WebSocketService _webSocketService;
  StreamSubscription<Map<String, dynamic>>? _subscription;

  final _friendRequestReceivedController = StreamController<Map<String, dynamic>>.broadcast();
  final _friendRequestAcceptedController = StreamController<Map<String, dynamic>>.broadcast();
  final _friendRequestRejectedController = StreamController<Map<String, dynamic>>.broadcast();
  final _friendRequestCancelledController = StreamController<Map<String, dynamic>>.broadcast();

  ContactWebSocketDataSource({required WebSocketService webSocketService})
      : _webSocketService = webSocketService {
    _startListening();
  }

  void _startListening() {
    final eventTypes = [
      ContactWebSocketEvents.friendRequestReceived,
      ContactWebSocketEvents.friendRequestAccepted,
      ContactWebSocketEvents.friendRequestRejected,
      ContactWebSocketEvents.friendRequestCancelled,
    ];

    _subscription = _webSocketService.messageRouter
        .getStreamForTypes(eventTypes)
        .listen(_handleMessage);
  }

  void _handleMessage(Map<String, dynamic> message) {
    final type = message['type'] as String?;
    if (type == null) return;

    final payload = message['payload'] as Map<String, dynamic>?;
    if (payload == null) return;

    debugPrint('🔔 [Contact WS] Event: $type');
    debugPrint('🔔 [Contact WS] Payload: $payload');

    switch (type) {
      case ContactWebSocketEvents.friendRequestReceived:
        _friendRequestReceivedController.add(payload);
        break;
      case ContactWebSocketEvents.friendRequestAccepted:
        _friendRequestAcceptedController.add(payload);
        break;
      case ContactWebSocketEvents.friendRequestRejected:
        _friendRequestRejectedController.add(payload);
        break;
      case ContactWebSocketEvents.friendRequestCancelled:
        _friendRequestCancelledController.add(payload);
        break;
    }
  }

  // Streams
  Stream<Map<String, dynamic>> get friendRequestReceivedStream => _friendRequestReceivedController.stream;
  Stream<Map<String, dynamic>> get friendRequestAcceptedStream => _friendRequestAcceptedController.stream;
  Stream<Map<String, dynamic>> get friendRequestRejectedStream => _friendRequestRejectedController.stream;
  Stream<Map<String, dynamic>> get friendRequestCancelledStream => _friendRequestCancelledController.stream;

  void dispose() {
    _subscription?.cancel();
    _friendRequestReceivedController.close();
    _friendRequestAcceptedController.close();
    _friendRequestRejectedController.close();
    _friendRequestCancelledController.close();
  }
}
