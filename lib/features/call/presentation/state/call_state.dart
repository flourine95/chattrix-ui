import 'package:chattrix_ui/features/call/domain/entities/call_connection.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_invitation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_state.freezed.dart';

@freezed
class CallState with _$CallState {
  const CallState._();

  const factory CallState.idle() = _Idle;

  const factory CallState.initiating({
    required int calleeId,
    required CallType callType,
  }) = _Initiating;

  const factory CallState.ringing({
    required CallInvitation invitation,
  }) = _Ringing;

  const factory CallState.connecting({
    required CallConnection connection,
    required CallType callType,
    required bool isOutgoing,
  }) = _Connecting;

  const factory CallState.connected({
    required CallConnection connection,
    required CallType callType,
    required bool isOutgoing,
    required bool isMuted,
    required bool isVideoEnabled,
    required bool isSpeakerEnabled,
    required bool isFrontCamera,
    int? remoteUid,
    @Default(false) bool remoteIsMuted,
    @Default(true) bool remoteIsVideoEnabled,
  }) = _Connected;

  const factory CallState.ended({
    String? reason,
  }) = _Ended;

  const factory CallState.error({
    required String message,
  }) = _Error;
}

