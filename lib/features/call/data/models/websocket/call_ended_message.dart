import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/data/models/websocket/call_ended_data.dart';

part 'call_ended_message.freezed.dart';
part 'call_ended_message.g.dart';

/// WebSocket message for call ended notification (Server → Client)
/// Sent when either participant ends the call
@freezed
abstract class CallEndedMessage with _$CallEndedMessage {
  const factory CallEndedMessage({required String type, required CallEndedData data, required DateTime timestamp}) =
      _CallEndedMessage;

  factory CallEndedMessage.fromJson(Map<String, dynamic> json) => _$CallEndedMessageFromJson(json);
}
