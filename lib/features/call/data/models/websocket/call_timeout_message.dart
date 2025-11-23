import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/data/models/websocket/call_timeout_data.dart';

part 'call_timeout_message.freezed.dart';
part 'call_timeout_message.g.dart';

/// WebSocket message for call timeout notification (Server → Client)
/// Sent when call is not answered within timeout period (60 seconds)
@freezed
abstract class CallTimeoutMessage with _$CallTimeoutMessage {
  const factory CallTimeoutMessage({required String type, required CallTimeoutData data, required DateTime timestamp}) =
      _CallTimeoutMessage;

  factory CallTimeoutMessage.fromJson(Map<String, dynamic> json) => _$CallTimeoutMessageFromJson(json);
}
