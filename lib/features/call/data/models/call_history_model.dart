import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_history_item.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';

part 'call_history_model.freezed.dart';
part 'call_history_model.g.dart';

@freezed
abstract class CallHistoryModel with _$CallHistoryModel {
  const CallHistoryModel._();

  const factory CallHistoryModel({
    String? id, // Changed from callId
    int? conversationId,
    int? callerId, // NEW - to determine incoming/outgoing
    String? callerName, // Changed from participantName
    String? callerAvatar, // Changed from participantAvatar
    String? callType,
    String? status, // NEW - to determine if missed
    String? createdAt, // Changed from timestamp (String in API)
    int? durationSeconds,
  }) = _CallHistoryModel;

  factory CallHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$CallHistoryModelFromJson(json);

  CallHistoryItem toEntity(int currentUserId) {
    // Determine if incoming or outgoing based on callerId
    final isIncoming = callerId != currentUserId;
    
    // Determine if missed based on status
    final isMissed = status == 'MISSED' || status == 'REJECTED' || status == 'CANCELLED';
    
    // Parse timestamp
    DateTime? parsedTimestamp;
    if (createdAt != null) {
      try {
        parsedTimestamp = DateTime.parse(createdAt!);
      } catch (e) {
        parsedTimestamp = DateTime.now();
      }
    }
    
    return CallHistoryItem(
      callId: id ?? 'unknown',
      conversationId: conversationId ?? 0,
      participantName: callerName ?? 'Unknown',
      participantAvatar: callerAvatar,
      type: isIncoming ? CallHistoryType.incoming : CallHistoryType.outgoing,
      callType: (callType?.toUpperCase() ?? 'AUDIO') == 'VIDEO' ? CallType.video : CallType.audio,
      timestamp: parsedTimestamp ?? DateTime.now(),
      duration: durationSeconds != null ? Duration(seconds: durationSeconds!) : null,
      isMissed: isMissed,
    );
  }
}
