import 'package:freezed_annotation/freezed_annotation.dart';
import 'call_participant_status.dart';

part 'call_participant_update.freezed.dart';

/// Entity cho WebSocket event "call.participant_update"
@freezed
abstract class CallParticipantUpdate with _$CallParticipantUpdate {
  const factory CallParticipantUpdate({
    required String callId,
    required int userId,
    required String fullName,
    String? avatarUrl,
    required CallParticipantStatus status,
  }) = _CallParticipantUpdate;
}
