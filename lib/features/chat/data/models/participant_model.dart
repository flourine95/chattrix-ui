import 'package:chattrix_ui/features/chat/domain/entities/participant.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'participant_model.freezed.dart';
part 'participant_model.g.dart';

@freezed
abstract class ParticipantModel with _$ParticipantModel {
  const ParticipantModel._();

  const factory ParticipantModel({
    required String userId,
    required String username,
    required String fullName,
    required String role,
  }) = _ParticipantModel;

  factory ParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$ParticipantModelFromJson(json);

  factory ParticipantModel.fromApi(Map<String, dynamic> json) {
    return ParticipantModel(
      userId: (json['userId'] ?? json['user_id'] ?? '').toString(),
      username: (json['username'] ?? '').toString(),
      fullName: (json['fullName'] ?? json['full_name'] ?? '').toString(),
      role: (json['role'] ?? '').toString(),
    );
  }

  Participant toEntity() {
    return Participant(
      userId: userId,
      username: username,
      fullName: fullName,
      role: role,
    );
  }
}
