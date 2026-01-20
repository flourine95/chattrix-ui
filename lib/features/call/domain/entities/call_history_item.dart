import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';

part 'call_history_item.freezed.dart';

enum CallHistoryType { incoming, outgoing }

@freezed
abstract class CallHistoryItem with _$CallHistoryItem {
  const factory CallHistoryItem({
    required String callId,
    required int conversationId,
    required String participantName,
    String? participantAvatar,
    required CallHistoryType type,
    required CallType callType,
    required DateTime timestamp,
    Duration? duration,
    required bool isMissed,
  }) = _CallHistoryItem;
}
