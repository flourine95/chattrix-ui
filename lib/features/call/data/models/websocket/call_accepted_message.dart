import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/data/models/websocket/call_accepted_data.dart';

part 'call_accepted_message.freezed.dart';
part 'call_accepted_message.g.dart';

/// WebSocket message for call accepted notification (Server → Client)
/// Sent to caller when callee accepts the call
@freezed
abstract class CallAcceptedMessage with _$CallAcceptedMessage {
  const factory CallAcceptedMessage({
    required String type,
    required CallAcceptedData data,
    required DateTime timestamp,
  }) = _CallAcceptedMessage;

  factory CallAcceptedMessage.fromJson(Map<String, dynamic> json) => _$CallAcceptedMessageFromJson(json);
}
