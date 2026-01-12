import 'package:freezed_annotation/freezed_annotation.dart';
import 'call_participant_status.dart';

part 'call_participant.freezed.dart';

/// Represents a participant in a group call
@freezed
abstract class CallParticipant with _$CallParticipant {
  const factory CallParticipant({
    required int userId,
    required String fullName,
    String? avatar,
    required CallParticipantStatus status,
    DateTime? joinedAt,
  }) = _CallParticipant;
}
