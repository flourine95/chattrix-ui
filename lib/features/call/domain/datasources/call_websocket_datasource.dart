import 'package:chattrix_ui/features/call/domain/entities/call_accept.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_end.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_invitation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_reject.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_timeout.dart';

/// WebSocket datasource interface for call feature
/// This follows Clean Architecture - domain defines the contract
abstract class CallWebSocketDataSource {
  /// Send call invitation
  void sendCallInvitation({
    required String receiverId,
    required String callType,
  });

  /// Send call acceptance
  void sendCallAccept({
    required String callId,
    required String sdpAnswer,
  });

  /// Send call rejection
  void sendCallReject({
    required String callId,
    required String reason,
  });

  /// Send call end
  void sendCallEnd(String callId);

  /// Stream of incoming call invitations
  Stream<CallInvitation> get incomingCallStream;

  /// Stream of call accepted events
  Stream<CallAccept> get callAcceptedStream;

  /// Stream of call rejected events
  Stream<CallReject> get callRejectedStream;

  /// Stream of call ended events
  Stream<CallEnd> get callEndedStream;

  /// Stream of call timeout events
  Stream<CallTimeout> get callTimeoutStream;

  /// Dispose resources
  void dispose();
}

