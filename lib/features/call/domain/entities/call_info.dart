import 'package:freezed_annotation/freezed_annotation.dart';
import 'call_participant.dart';
import 'call_status.dart';
import 'call_type.dart';

part 'call_info.freezed.dart';

@freezed
abstract class CallInfo with _$CallInfo {
  const factory CallInfo({
    required String id,
    required String channelId,
    required int conversationId,
    required CallStatus status,
    required CallType callType,
    required int callerId,
    required String callerName,
    String? callerAvatar,
    required DateTime createdAt,
    int? durationSeconds,
    required List<CallParticipant> participants,
  }) = _CallInfo;
}
