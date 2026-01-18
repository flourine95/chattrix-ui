import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_participant_update.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_participant_status.dart';

part 'call_participant_update_model.freezed.dart';
part 'call_participant_update_model.g.dart';

@freezed
abstract class CallParticipantUpdateModel with _$CallParticipantUpdateModel {
  const CallParticipantUpdateModel._();

  const factory CallParticipantUpdateModel({
    required String callId,
    required int userId,
    required String fullName,
    String? avatarUrl,
    required CallParticipantStatus status,
  }) = _CallParticipantUpdateModel;

  factory CallParticipantUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$CallParticipantUpdateModelFromJson(json);

  CallParticipantUpdate toEntity() {
    return CallParticipantUpdate(
      callId: callId,
      userId: userId,
      fullName: fullName,
      avatarUrl: avatarUrl,
      status: status,
    );
  }
}
