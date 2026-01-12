import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_info.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_status.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'call_participant_model.dart';

part 'call_info_model.freezed.dart';
part 'call_info_model.g.dart';

@freezed
abstract class CallInfoModel with _$CallInfoModel {
  const CallInfoModel._();

  const factory CallInfoModel({
    required String id,
    required String channelId,
    required int conversationId,
    required CallStatus status,
    required CallType callType,
    required int callerId,
    required String callerName,
    String? callerAvatar,
    required String createdAt,
    int? durationSeconds,
    required List<CallParticipantModel> participants,
  }) = _CallInfoModel;

  factory CallInfoModel.fromJson(Map<String, dynamic> json) => _$CallInfoModelFromJson(json);

  CallInfo toEntity() {
    return CallInfo(
      id: id,
      channelId: channelId,
      conversationId: conversationId,
      status: status,
      callType: callType,
      callerId: callerId,
      callerName: callerName,
      callerAvatar: callerAvatar,
      createdAt: DateTime.parse(createdAt),
      durationSeconds: durationSeconds,
      participants: participants.map((p) => p.toEntity()).toList(),
    );
  }
}
