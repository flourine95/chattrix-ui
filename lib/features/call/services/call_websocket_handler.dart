import 'dart:async';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:chattrix_ui/features/call/data/models/call_accept_model.dart';
import 'package:chattrix_ui/features/call/data/models/call_end_model.dart';
import 'package:chattrix_ui/features/call/data/models/call_invitation_model.dart';
import 'package:chattrix_ui/features/call/data/models/call_reject_model.dart';
import 'package:chattrix_ui/features/call/data/models/call_timeout_model.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_accept.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_end.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_invitation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_reject.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_timeout.dart';
import 'package:chattrix_ui/features/chat/data/services/chat_websocket_service.dart';

/// WebSocket event types for call signaling
class CallWebSocketEvent {
  static const String incoming = 'call.incoming';
  static const String accepted = 'call.accepted';
  static const String rejected = 'call.rejected';
  static const String ended = 'call.ended';
  static const String timeout = 'call.timeout';
}

/// Handler for call-related WebSocket messages
class CallWebSocketHandler {
  final ChatWebSocketService webSocketService;
  StreamSubscription<Map<String, dynamic>>? _subscription;

  // Stream controllers for call events
  final _incomingCallController = StreamController<CallInvitation>.broadcast();
  final _callAcceptedController = StreamController<CallAccept>.broadcast();
  final _callRejectedController = StreamController<CallReject>.broadcast();
  final _callEndedController = StreamController<CallEnd>.broadcast();
  final _callTimeoutController = StreamController<CallTimeout>.broadcast();

  Stream<CallInvitation> get incomingCallStream => _incomingCallController.stream;
  Stream<CallAccept> get callAcceptedStream => _callAcceptedController.stream;
  Stream<CallReject> get callRejectedStream => _callRejectedController.stream;
  Stream<CallEnd> get callEndedStream => _callEndedController.stream;
  Stream<CallTimeout> get callTimeoutStream => _callTimeoutController.stream;

  CallWebSocketHandler({required this.webSocketService});

  void startListening() {
    _subscription?.cancel();
    _subscription = webSocketService.rawMessageStream.listen(
      _handleMessage,
      onError: (error) {
        appLogger.e('📞 [CallWebSocket] Error in handler: $error');
      },
    );
    appLogger.i('📞 [CallWebSocket] Handler started listening for call events');
  }

  void _handleMessage(Map<String, dynamic> message) {
    try {
      final type = message['type'] as String?;

      if (type == null) {
        appLogger.w('📞 [CallWebSocket] Message has no type: $message');
        return;
      }

      appLogger.i('📞 [CallWebSocket] Received message type: $type');

      // Backend may send data in 'data' or 'payload' field
      final data = message['data'] as Map<String, dynamic>? ??
                   message['payload'] as Map<String, dynamic>?;

      if (data == null) {
        appLogger.w('📞 [CallWebSocket] Message has no data/payload for type: $type');
        appLogger.i('📞 [CallWebSocket] Full message: $message');
        return;
      }

      appLogger.i('📞 [CallWebSocket] Processing $type with data: ${data.keys}');

      switch (type) {
        case CallWebSocketEvent.incoming:
          appLogger.i('📞 [CallWebSocket] Handling incoming call...');
          _handleIncomingCall(data);
          break;
        case CallWebSocketEvent.accepted:
          _handleCallAccepted(data);
          break;
        case CallWebSocketEvent.rejected:
          _handleCallRejected(data);
          break;
        case CallWebSocketEvent.ended:
          _handleCallEnded(data);
          break;
        case CallWebSocketEvent.timeout:
          _handleCallTimeout(data);
          break;
        default:
          // Not a call event, ignore
          appLogger.i('📞 [CallWebSocket] Ignoring non-call event: $type');
          break;
      }
    } catch (e, stackTrace) {
      appLogger.e('📞 [CallWebSocket] Error handling message: $e', stackTrace: stackTrace);
    }
  }

  void _handleIncomingCall(Map<String, dynamic> data) {
    try {
      final invitation = CallInvitationModel.fromJson(data).toEntity();
      appLogger.i('📞 [CallWebSocket] Incoming call from ${invitation.callerName} (${invitation.callType.name}) - Call ID: ${invitation.callId}');
      _incomingCallController.add(invitation);
    } catch (e) {
      appLogger.e('📞 [CallWebSocket] Error parsing incoming call: $e');
    }
  }

  void _handleCallAccepted(Map<String, dynamic> data) {
    try {
      final accept = CallAcceptModel.fromJson(data).toEntity();
      appLogger.i('Call accepted: ${accept.callId} by ${accept.acceptedBy}');
      _callAcceptedController.add(accept);
    } catch (e) {
      appLogger.e('Error parsing call accepted: $e');
    }
  }

  void _handleCallRejected(Map<String, dynamic> data) {
    try {
      final reject = CallRejectModel.fromJson(data).toEntity();
      appLogger.i('Call rejected: ${reject.callId} by ${reject.rejectedBy}, reason: ${reject.reason}');
      _callRejectedController.add(reject);
    } catch (e) {
      appLogger.e('Error parsing call rejected: $e');
    }
  }

  void _handleCallEnded(Map<String, dynamic> data) {
    try {
      final end = CallEndModel.fromJson(data).toEntity();
      appLogger.i('Call ended: ${end.callId} by ${end.endedBy}');
      _callEndedController.add(end);
    } catch (e) {
      appLogger.e('Error parsing call ended: $e');
    }
  }

  void _handleCallTimeout(Map<String, dynamic> data) {
    try {
      final timeout = CallTimeoutModel.fromJson(data).toEntity();
      appLogger.i('Call timeout: ${timeout.callId}, reason: ${timeout.reason}');
      _callTimeoutController.add(timeout);
    } catch (e) {
      appLogger.e('Error parsing call timeout: $e');
    }
  }

  void dispose() {
    _subscription?.cancel();
    _incomingCallController.close();
    _callAcceptedController.close();
    _callRejectedController.close();
    _callEndedController.close();
    _callTimeoutController.close();
    appLogger.i('📞 [CallWebSocket] Handler disposed');
  }
}

