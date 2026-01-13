import '../models/participant_model.dart';
import '../../domain/entities/participant.dart';

extension ParticipantModelMapper on ParticipantModel {
  Participant toEntity() {
    return Participant(
      userId: userId,
      username: username,
      fullName: fullName,
      role: role,
      email: email,
      nickname: nickname,
      avatarUrl: avatarUrl,
      lastSeen: lastSeen != null ? DateTime.parse(lastSeen!) : null,
    );
  }
}
