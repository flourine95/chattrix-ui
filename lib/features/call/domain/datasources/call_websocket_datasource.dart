import 'package:chattrix_ui/features/call/domain/entities/call_invitation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_participant_update.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_timeout.dart';

/// WebSocket DataSource cho Call feature
/// 
/// Theo API spec mới, WebSocket chỉ nhận events (không gửi):
/// - call.incoming: Cuộc gọi đến
/// - call.participant_update: Cập nhật trạng thái participant
/// - call.timeout: Cuộc gọi timeout
abstract class CallWebSocketDataSource {
  /// Stream nhận cuộc gọi đến
  Stream<CallInvitation> get incomingCallStream;

  /// Stream nhận cập nhật participant (joined, left, rejected)
  Stream<CallParticipantUpdate> get participantUpdateStream;

  /// Stream nhận timeout event
  Stream<CallTimeout> get callTimeoutStream;

  void dispose();
}
