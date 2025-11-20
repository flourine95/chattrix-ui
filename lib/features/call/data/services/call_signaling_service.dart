import 'dart:async';
import 'package:chattrix_ui/features/chat/data/services/chat_websocket_service.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';

/// WebSocket events for call signaling (client to server)
class CallSignalingEvent {
  static const String callInvitation = 'call.invitation';
  static const String callResponse = 'call.response';
  static const String callEnded = 'call.ended';
}

/// WebSocket events for call signaling (server to client)
class CallSignalingResponse {
  static const String callInvitation = 'call.invitation';
  static const String callResponse = 'call.response';
  static const String callEnded = 'call.ended';
}

/// Call invitation data
class CallInvitation {
  final String callId;
  final String channelId;
  final String callerId;
  final String callerName;
  final CallType callType;
  final DateTime timestamp;

  CallInvitation({
    required this.callId,
    required this.channelId,
    required this.callerId,
    required this.callerName,
    required this.callType,
    required this.timestamp,
  });

  factory CallInvitation.fromJson(Map<String, dynamic> json) {
    return CallInvitation(
      callId: json['callId'] as String,
      channelId: json['channelId'] as String,
      callerId: json['callerId'] as String,
      callerName: json['callerName'] as String,
      callType: json['callType'] == 'video' ? CallType.video : CallType.audio,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'callId': callId,
      'channelId': channelId,
      'callerId': callerId,
      'callerName': callerName,
      'callType': callType == CallType.video ? 'video' : 'audio',
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

/// Call response data
class CallResponse {
  final String callId;
  final CallResponseType response;
  final DateTime timestamp;

  CallResponse({required this.callId, required this.response, required this.timestamp});

  factory CallResponse.fromJson(Map<String, dynamic> json) {
    return CallResponse(
      callId: json['callId'] as String,
      response: json['response'] == 'accepted' ? CallResponseType.accepted : CallResponseType.rejected,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'callId': callId,
      'response': response == CallResponseType.accepted ? 'accepted' : 'rejected',
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

enum CallResponseType { accepted, rejected }

/// Call ended notification data
class CallEndedNotification {
  final String callId;
  final String endedBy;
  final DateTime timestamp;

  CallEndedNotification({required this.callId, required this.endedBy, required this.timestamp});

  factory CallEndedNotification.fromJson(Map<String, dynamic> json) {
    return CallEndedNotification(
      callId: json['callId'] as String,
      endedBy: json['endedBy'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {'callId': callId, 'endedBy': endedBy, 'timestamp': timestamp.toIso8601String()};
  }
}

/// Service for handling call signaling over WebSocket
class CallSignalingService {
  final ChatWebSocketService _webSocketService;

  // Stream controllers for call signaling events
  final _callInvitationController = StreamController<CallInvitation>.broadcast();
  final _callResponseController = StreamController<CallResponse>.broadcast();
  final _callEndedController = StreamController<CallEndedNotification>.broadcast();

  StreamSubscription<dynamic>? _messageSubscription;

  CallSignalingService({required ChatWebSocketService webSocketService}) : _webSocketService = webSocketService {
    _listenToWebSocketMessages();
  }

  /// Stream of incoming call invitations
  Stream<CallInvitation> get callInvitationStream => _callInvitationController.stream;

  /// Stream of call responses
  Stream<CallResponse> get callResponseStream => _callResponseController.stream;

  /// Stream of call ended notifications
  Stream<CallEndedNotification> get callEndedStream => _callEndedController.stream;

  /// Listen to WebSocket messages and filter call-related events
  void _listenToWebSocketMessages() {
    // Subscribe to raw message stream from WebSocket service
    _messageSubscription = _webSocketService.rawMessageStream.listen((data) {
      handleIncomingMessage(data);
    });
  }

  /// Send call invitation to a user
  void sendCallInvitation({
    required String callId,
    required String channelId,
    required String callerId,
    required String callerName,
    required String recipientId,
    required CallType callType,
  }) {
    if (!_webSocketService.isConnected) {
      return;
    }

    final invitation = CallInvitation(
      callId: callId,
      channelId: channelId,
      callerId: callerId,
      callerName: callerName,
      callType: callType,
      timestamp: DateTime.now(),
    );

    final payload = {
      'type': CallSignalingEvent.callInvitation,
      'payload': {...invitation.toJson(), 'recipientId': recipientId},
    };

    // Access the underlying WebSocket channel
    // Note: This requires the ChatWebSocketService to expose the channel
    // For now, we'll use a workaround by sending through a custom method
    _sendMessage(payload);
  }

  /// Send call response (accept/reject)
  void sendCallResponse({required String callId, required CallResponseType response}) {
    if (!_webSocketService.isConnected) {
      return;
    }

    final callResponse = CallResponse(callId: callId, response: response, timestamp: DateTime.now());

    final payload = {'type': CallSignalingEvent.callResponse, 'payload': callResponse.toJson()};

    _sendMessage(payload);
  }

  /// Send call ended notification
  void sendCallEnded({required String callId, required String endedBy}) {
    if (!_webSocketService.isConnected) {
      return;
    }

    final notification = CallEndedNotification(callId: callId, endedBy: endedBy, timestamp: DateTime.now());

    final payload = {'type': CallSignalingEvent.callEnded, 'payload': notification.toJson()};

    _sendMessage(payload);
  }

  /// Handle incoming call signaling message
  void handleIncomingMessage(Map<String, dynamic> data) {
    try {
      final type = data['type'] as String?;
      if (type == null) return;

      final payload = data['payload'] as Map<String, dynamic>?;
      if (payload == null) return;

      switch (type) {
        case CallSignalingResponse.callInvitation:
          final invitation = CallInvitation.fromJson(payload);
          _callInvitationController.add(invitation);
          break;

        case CallSignalingResponse.callResponse:
          final response = CallResponse.fromJson(payload);
          _callResponseController.add(response);
          break;

        case CallSignalingResponse.callEnded:
          final notification = CallEndedNotification.fromJson(payload);
          _callEndedController.add(notification);
          break;

        default:
          break;
      }
    } catch (e) {
      // Silently handle parsing errors
    }
  }

  /// Send a message through the WebSocket
  void _sendMessage(Map<String, dynamic> payload) {
    // Use the generic send method from ChatWebSocketService
    _webSocketService.sendGenericMessage(payload);
  }

  /// Dispose resources
  void dispose() {
    _messageSubscription?.cancel();
    _callInvitationController.close();
    _callResponseController.close();
    _callEndedController.close();
  }
}
