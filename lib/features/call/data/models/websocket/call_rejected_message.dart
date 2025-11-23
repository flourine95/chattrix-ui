import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/data/models/websocket/call_rejected_data.dart';

part 'call_rejected_message.freezed.dart';
part 'call_rejected_message.g.dart';

/// WebSocket message for call rejected notification (Server → Client)
/// Sent to caller when callee rejects the call
@freezed
abstract class CallRejectedMessage with _$CallRejectedMessage {
  const factory CallRejectedMessage({
    required String type,
    required CallRejectedData data,
    required DateTime timestamp,
  }) = _CallRejectedMessage;

  factory CallRejectedMessage.fromJson(Map<String, dynamic> json) => _$CallRejectedMessageFromJson(json);
}
