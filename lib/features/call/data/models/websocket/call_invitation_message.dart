import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/data/models/websocket/call_invitation_data.dart';

part 'call_invitation_message.freezed.dart';
part 'call_invitation_message.g.dart';

/// WebSocket message for incoming call invitation (Server → Client)
/// Message structure: { type, data, timestamp }
@freezed
abstract class CallInvitationMessage with _$CallInvitationMessage {
  const factory CallInvitationMessage({
    required String type,
    required CallInvitationData data,
    required DateTime timestamp,
  }) = _CallInvitationMessage;

  factory CallInvitationMessage.fromJson(Map<String, dynamic> json) => _$CallInvitationMessageFromJson(json);
}
