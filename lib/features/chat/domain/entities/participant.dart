import 'package:freezed_annotation/freezed_annotation.dart';

part 'participant.freezed.dart';

@freezed
abstract class Participant with _$Participant {
  const factory Participant({
    required int userId,
    required String username,
    required String fullName,
    required String role, // 'ADMIN' or 'MEMBER'
    String? email,
    String? nickname,
    String? avatarUrl,
    bool? online,
    DateTime? lastSeen,
  }) = _Participant;
}
