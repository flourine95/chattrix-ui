import 'package:chattrix_ui/features/chat/domain/entities/participant.dart';
import 'package:flutter/cupertino.dart';
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
    bool? isOnline,
    String? lastSeen,
  }) = _ParticipantModel;

  factory ParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$ParticipantModelFromJson(json);

  factory ParticipantModel.fromApi(Map<String, dynamic> json) {
    // Debug: Print raw JSON to see what backend sends
    debugPrint('🔍 ParticipantModel.fromApi JSON: $json');

    // Backend now uses 'isOnline' (camelCase with 'is' prefix)
    final isOnline = json['isOnline'] as bool?;

    final lastSeen = json['lastSeen']?.toString();

    debugPrint('🔍   → isOnline: $isOnline, lastSeen: $lastSeen');

    return ParticipantModel(
      userId: (json['userId'] ?? json['user_id'] ?? ''),
      username: (json['username'] ?? '').toString(),
      fullName: (json['fullName'] ?? json['full_name'] ?? '').toString(),
      role: (json['role'] ?? '').toString(),
      email: json['email']?.toString(),
      nickname: json['nickname']?.toString(),
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
      isOnline: isOnline,
      lastSeen: lastSeen != null ? DateTime.parse(lastSeen!) : null,
    );
  }
}
