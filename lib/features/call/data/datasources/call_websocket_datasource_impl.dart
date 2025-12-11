import 'dart:async';

import 'package:chattrix_ui/core/network/websocket_service.dart';
import 'package:chattrix_ui/features/call/data/models/call_accept_model.dart';
import 'package:chattrix_ui/features/call/data/models/call_end_model.dart';
import 'package:chattrix_ui/features/call/data/models/call_invitation_model.dart';
import 'package:chattrix_ui/features/call/data/models/call_reject_model.dart';
import 'package:chattrix_ui/features/call/data/models/call_timeout_model.dart';
import 'package:chattrix_ui/features/call/domain/datasources/call_websocket_datasource.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_accept.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_end.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_invitation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_reject.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_timeout.dart';

class _CallWebSocketEvent {
  static const String invite = 'call.invite';
  static const String accept = 'call.accept';
  static const String reject = 'call.reject';
  static const String end = 'call.end';
}

class _CallWebSocketResponse {
  static const String incoming = 'call.incoming';
  static const String accepted = 'call.accepted';
  static const String rejected = 'call.rejected';
  static const String ended = 'call.ended';
  static const String timeout = 'call.timeout';
}

class CallWebSocketDataSourceImpl implements CallWebSocketDataSource {
  final WebSocketService _webSocketService;
  StreamSubscription<Map<String, dynamic>>? _subscription;

  final _incomingCallController = StreamController<CallInvitation>.broadcast();
  final _callAcceptedController = StreamController<CallAccept>.broadcast();
  final _callRejectedController = StreamController<CallReject>.broadcast();
  final _callEndedController = StreamController<CallEnd>.broadcast();
  final _callTimeoutController = StreamController<CallTimeout>.broadcast();

  CallWebSocketDataSourceImpl({required WebSocketService webSocketService}) : _webSocketService = webSocketService {
    _startListening();
  }

  void _startListening() {
    final callMessageTypes = [
      _CallWebSocketResponse.incoming,
      _CallWebSocketResponse.accepted,
      _CallWebSocketResponse.rejected,
      _CallWebSocketResponse.ended,
      _CallWebSocketResponse.timeout,
    ];

    _subscription = _webSocketService.messageRouter.getStreamForTypes(callMessageTypes).listen(_handleMessage);
  }

  void _handleMessage(Map<String, dynamic> message) {
    final type = message['type'] as String?;
    if (type == null) {
      return;
    }

    final data = message['data'] as Map<String, dynamic>? ?? message['payload'] as Map<String, dynamic>?;

    if (data == null) {
      return;
    }

    switch (type) {
      case _CallWebSocketResponse.incoming:
        _handleIncomingCall(data);
        break;
      case _CallWebSocketResponse.accepted:
        _handleCallAccepted(data);
        break;
      case _CallWebSocketResponse.rejected:
        _handleCallRejected(data);
        break;
      case _CallWebSocketResponse.ended:
        _handleCallEnded(data);
        break;
      case _CallWebSocketResponse.timeout:
        _handleCallTimeout(data);
        break;
    }
  }

  void _handleIncomingCall(Map<String, dynamic> data) {
    final invitation = CallInvitationModel.fromJson(data).toEntity();
    _incomingCallController.add(invitation);
  }

  void _handleCallAccepted(Map<String, dynamic> data) {
    final accept = CallAcceptModel.fromJson(data).toEntity();
    _callAcceptedController.add(accept);
  }

  void _handleCallRejected(Map<String, dynamic> data) {
    final reject = CallRejectModel.fromJson(data).toEntity();
    _callRejectedController.add(reject);
  }

  void _handleCallEnded(Map<String, dynamic> data) {
    final end = CallEndModel.fromJson(data).toEntity();
    _callEndedController.add(end);
  }

  void _handleCallTimeout(Map<String, dynamic> data) {
    final timeout = CallTimeoutModel.fromJson(data).toEntity();
    _callTimeoutController.add(timeout);
  }

  @override
  void sendCallInvitation({required String receiverId, required String callType}) {
    final payload = {
      'type': _CallWebSocketEvent.invite,
      'payload': {'receiverId': receiverId, 'callType': callType},
    };

    _webSocketService.send(payload);
  }

  @override
  void sendCallAccept({required String callId, required String sdpAnswer}) {
    final payload = {
      'type': _CallWebSocketEvent.accept,
      'payload': {'callId': callId, 'sdpAnswer': sdpAnswer},
    };

    _webSocketService.send(payload);
  }

  @override
  void sendCallReject({required String callId, required String reason}) {
    final payload = {
      'type': _CallWebSocketEvent.reject,
      'payload': {'callId': callId, 'reason': reason},
    };

    _webSocketService.send(payload);
  }

  @override
  void sendCallEnd(String callId) {
    final payload = {
      'type': _CallWebSocketEvent.end,
      'payload': {'callId': callId},
    };

    _webSocketService.send(payload);
  }

  @override
  Stream<CallInvitation> get incomingCallStream => _incomingCallController.stream;

  @override
  Stream<CallAccept> get callAcceptedStream => _callAcceptedController.stream;

  @override
  Stream<CallReject> get callRejectedStream => _callRejectedController.stream;

  @override
  Stream<CallEnd> get callEndedStream => _callEndedController.stream;

  @override
  Stream<CallTimeout> get callTimeoutStream => _callTimeoutController.stream;

  @override
  void dispose() {
    _subscription?.cancel();
    _incomingCallController.close();
    _callAcceptedController.close();
    _callRejectedController.close();
    _callEndedController.close();
    _callTimeoutController.close();
  }
}
