import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';

part 'call_history_entity.freezed.dart';

@freezed
abstract class CallHistoryEntity with _$CallHistoryEntity {
  const factory CallHistoryEntity({
    required String id,
    required String remoteUserId,
    required String remoteUserName,
    required CallType callType,
    required CallStatus status,
    required DateTime timestamp,
    int? durationSeconds,
  }) = _CallHistoryEntity;
}
