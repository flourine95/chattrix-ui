import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_history_entity.dart';

part 'call_history_model.freezed.dart';
part 'call_history_model.g.dart';

@freezed
abstract class CallHistoryModel with _$CallHistoryModel {
  const CallHistoryModel._();

  const factory CallHistoryModel({
    required String id,
    required String remoteUserId,
    required String remoteUserName,
    required String callType,
    required String status,
    required String timestamp,
    int? durationSeconds,
  }) = _CallHistoryModel;

  factory CallHistoryModel.fromJson(Map<String, dynamic> json) => _$CallHistoryModelFromJson(json);

  factory CallHistoryModel.fromEntity(CallHistoryEntity entity) {
    return CallHistoryModel(
      id: entity.id,
      remoteUserId: entity.remoteUserId,
      remoteUserName: entity.remoteUserName,
      callType: entity.callType.name,
      status: entity.status.name,
      timestamp: entity.timestamp.toIso8601String(),
      durationSeconds: entity.durationSeconds,
    );
  }

  CallHistoryEntity toEntity() {
    return CallHistoryEntity(
      id: id,
      remoteUserId: remoteUserId,
      remoteUserName: remoteUserName,
      callType: CallType.values.firstWhere((e) => e.name == callType, orElse: () => CallType.audio),
      status: CallStatus.values.firstWhere((e) => e.name == status, orElse: () => CallStatus.failed),
      timestamp: DateTime.parse(timestamp),
      durationSeconds: durationSeconds,
    );
  }
}
