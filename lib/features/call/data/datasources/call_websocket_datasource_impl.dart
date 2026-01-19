import 'dart:async';

import 'package:chattrix_ui/core/network/websocket_service.dart';
import 'package:chattrix_ui/features/call/data/models/call_invitation_model.dart';
import 'package:chattrix_ui/features/call/data/models/call_participant_update_model.dart';
import 'package:chattrix_ui/features/call/data/models/call_timeout_model.dart';
import 'package:chattrix_ui/features/call/domain/datasources/call_websocket_datasource.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_invitation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_participant_update.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_timeout.dart';
import 'package:flutter/foundation.dart';

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

    // 🔍 DEBUG: Log raw payload để xem backend gửi gì
    debugPrint('🔍 [Call WS] Event type: $type');
    debugPrint('🔍 [Call WS] Raw payload: $payload');
    if (payload.containsKey('callId')) {
      debugPrint('🔍 [Call WS] callId type: ${payload['callId'].runtimeType}');
      debugPrint('🔍 [Call WS] callId value: ${payload['callId']}');
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
      debugPrint('🔍 [Call WS] Parsing incoming call...');
      final invitation = CallInvitationModel.fromJson(payload).toEntity();
      debugPrint('✅ [Call WS] Incoming call parsed successfully: ${invitation.callId}');
      _incomingCallController.add(invitation);
    } catch (e, stack) {
      // Log error nhưng không crash app
      debugPrint('❌ [Call WS] Error parsing incoming call: $e');
      debugPrint('❌ [Call WS] Stack trace: $stack');
      debugPrint('❌ [Call WS] Payload was: $payload');
    }
  }

  void _handleParticipantUpdate(Map<String, dynamic> payload) {
    try {
      debugPrint('🔍 [Call WS] Parsing participant update...');
      final update = CallParticipantUpdateModel.fromJson(payload).toEntity();
      debugPrint('✅ [Call WS] Participant update parsed: userId=${update.userId}, status=${update.status}');
      _participantUpdateController.add(update);
    } catch (e, stack) {
      debugPrint('❌ [Call WS] Error parsing participant update: $e');
      debugPrint('❌ [Call WS] Stack trace: $stack');
      debugPrint('❌ [Call WS] Payload was: $payload');
    }
  }

  void _handleCallTimeout(Map<String, dynamic> payload) {
    try {
      debugPrint('🔍 [Call WS] Parsing call timeout...');
      final timeout = CallTimeoutModel.fromJson(payload).toEntity();
      debugPrint('✅ [Call WS] Call timeout parsed: ${timeout.callId}');
      _callTimeoutController.add(timeout);
    } catch (e, stack) {
      debugPrint('❌ [Call WS] Error parsing call timeout: $e');
      debugPrint('❌ [Call WS] Stack trace: $stack');
      debugPrint('❌ [Call WS] Payload was: $payload');
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
