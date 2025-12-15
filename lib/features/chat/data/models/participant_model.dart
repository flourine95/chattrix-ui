import 'package:chattrix_ui/features/chat/domain/entities/participant.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'participant_model.freezed.dart';
part 'participant_model.g.dart';

@freezed
abstract class ParticipantModel with _$ParticipantModel {
  const ParticipantModel._();

  const factory ParticipantModel({
    required int userId,
    required String username,
    required String fullName,
    required String role,
    String? email,
    String? nickname,
    String? avatarUrl,
    bool? isOnline,
    String? lastSeen,
  }) = _ParticipantModel;

  factory ParticipantModel.fromJson(Map<String, dynamic> json) => _$ParticipantModelFromJson(json);

  factory ParticipantModel.fromApi(Map<String, dynamic> json) {
    final isOnline = json['isOnline'] as bool?;

    final lastSeen = json['lastSeen']?.toString();

    return ParticipantModel(
      userId: (json['userId'] ?? json['user_id'] ?? 0) is int
          ? (json['userId'] ?? json['user_id'] ?? 0)
          : int.tryParse((json['userId'] ?? json['user_id'] ?? 0).toString()) ?? 0,
      username: (json['username'] ?? '').toString(),
      fullName: (json['fullName'] ?? json['full_name'] ?? '').toString(),
      role: (json['role'] ?? '').toString(),
      email: json['email']?.toString(),
      nickname: json['nickname']?.toString(),
      avatarUrl: json['avatarUrl']?.toString() ?? json['avatar_url']?.toString(),
      isOnline: isOnline,
      lastSeen: lastSeen,
    );
  }

  Participant toEntity() {
    return Participant(
      userId: userId,
      username: username,
      fullName: fullName,
      role: role,
      email: email,
      nickname: nickname,
      avatarUrl: avatarUrl,
      isOnline: isOnline,
      lastSeen: lastSeen != null ? DateTime.parse(lastSeen!) : null,
    );
  }
}
