import 'package:chattrix_ui/features/call/domain/entities/call_accept.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_end.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_invitation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_reject.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_timeout.dart';

abstract class CallWebSocketDataSource {
  void sendCallInvitation({required String receiverId, required String callType});

  void sendCallAccept({required String callId, required String sdpAnswer});

  void sendCallReject({required String callId, required String reason});

  void sendCallEnd(String callId);

  Stream<CallInvitation> get incomingCallStream;

  Stream<CallAccept> get callAcceptedStream;

  Stream<CallReject> get callRejectedStream;

  Stream<CallEnd> get callEndedStream;

  Stream<CallTimeout> get callTimeoutStream;

  void dispose();
}
