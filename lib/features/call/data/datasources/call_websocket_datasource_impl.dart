import 'dart:async';

import 'package:chattrix_ui/core/network/websocket_service.dart';
import 'package:chattrix_ui/features/call/data/models/call_invitation_model.dart';
import 'package:chattrix_ui/features/call/data/models/call_participant_update_model.dart';
import 'package:chattrix_ui/features/call/data/models/call_timeout_model.dart';
import 'package:chattrix_ui/features/call/domain/datasources/call_websocket_datasource.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_invitation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_participant_update.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_timeout.dart';

/// WebSocket event types theo API spec mới
class _CallWebSocketResponse {
  static const String incoming = 'call.incoming';
  static const String participantUpdate = 'call.participant_update';
  static const String timeout = 'call.timeout';
}

/// Implementation của CallWebSocketDataSource
/// 
/// Lắng nghe 3 WebSocket events:
/// 1. call.incoming - Cuộc gọi đến
/// 2. call.participant_update - Participant joined/left/rejected
/// 3. call.timeout - Cuộc gọi timeout
class CallWebSocketDataSourceImpl implements CallWebSocketDataSource {
  final WebSocketService _webSocketService;
  StreamSubscription<Map<String, dynamic>>? _subscription;

  final _incomingCallController = StreamController<CallInvitation>.broadcast();
  final _participantUpdateController = StreamController<CallParticipantUpdate>.broadcast();
  final _callTimeoutController = StreamController<CallTimeout>.broadcast();

  CallWebSocketDataSourceImpl({required WebSocketService webSocketService}) 
      : _webSocketService = webSocketService {
    _startListening();
  }

  void _startListening() {
    final callMessageTypes = [
      _CallWebSocketResponse.incoming,
      _CallWebSocketResponse.participantUpdate,
      _CallWebSocketResponse.timeout,
    ];

    _subscription = _webSocketService.messageRouter
        .getStreamForTypes(callMessageTypes)
        .listen(_handleMessage);
  }

  void _handleMessage(Map<String, dynamic> message) {
    final type = message['type'] as String?;
    if (type == null) {
      return;
    }

    // Payload nằm trong key 'payload' theo API spec
    final payload = message['payload'] as Map<String, dynamic>?;
    if (payload == null) {
      return;
    }

    switch (type) {
      case _CallWebSocketResponse.incoming:
        _handleIncomingCall(payload);
        break;
      case _CallWebSocketResponse.participantUpdate:
        _handleParticipantUpdate(payload);
        break;
      case _CallWebSocketResponse.timeout:
        _handleCallTimeout(payload);
        break;
    }
  }

  void _handleIncomingCall(Map<String, dynamic> payload) {
    try {
      final invitation = CallInvitationModel.fromJson(payload).toEntity();
      _incomingCallController.add(invitation);
    } catch (e) {
      // Log error nhưng không crash app
      print('Error parsing incoming call: $e');
    }
  }

  void _handleParticipantUpdate(Map<String, dynamic> payload) {
    try {
      final update = CallParticipantUpdateModel.fromJson(payload).toEntity();
      _participantUpdateController.add(update);
    } catch (e) {
      print('Error parsing participant update: $e');
    }
  }

  void _handleCallTimeout(Map<String, dynamic> payload) {
    try {
      final timeout = CallTimeoutModel.fromJson(payload).toEntity();
      _callTimeoutController.add(timeout);
    } catch (e) {
      print('Error parsing call timeout: $e');
    }
  }

  @override
  Stream<CallInvitation> get incomingCallStream => _incomingCallController.stream;

  @override
  Stream<CallParticipantUpdate> get participantUpdateStream => 
      _participantUpdateController.stream;

  @override
  Stream<CallTimeout> get callTimeoutStream => _callTimeoutController.stream;

  @override
  void dispose() {
    _subscription?.cancel();
    _incomingCallController.close();
    _participantUpdateController.close();
    _callTimeoutController.close();
  }
}
