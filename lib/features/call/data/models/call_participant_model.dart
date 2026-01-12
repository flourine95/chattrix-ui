import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_participant.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_participant_status.dart';

part 'call_participant_model.freezed.dart';
part 'call_participant_model.g.dart';

@freezed
abstract class CallParticipantModel with _$CallParticipantModel {
  const CallParticipantModel._();

  const factory CallParticipantModel({
    required int userId,
    required String fullName,
    String? avatar,
    required CallParticipantStatus status,
    String? joinedAt,
  }) = _CallParticipantModel;

  factory CallParticipantModel.fromJson(Map<String, dynamic> json) => _$CallParticipantModelFromJson(json);

  CallParticipant toEntity() {
    return CallParticipant(
      userId: userId,
      fullName: fullName,
      avatar: avatar,
      status: status,
      joinedAt: joinedAt != null ? DateTime.parse(joinedAt!) : null,
    );
  }
}
