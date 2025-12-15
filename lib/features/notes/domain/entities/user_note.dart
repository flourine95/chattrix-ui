import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_note.freezed.dart';

/// Domain entity for User Note (24h status)
@freezed
abstract class UserNote with _$UserNote {
  const factory UserNote({
    required int id,
    required int userId,
    required String username,
    required String fullName,
    String? avatarUrl,
    required String noteText,
    String? musicUrl,
    String? musicTitle,
    String? emoji,
    required DateTime createdAt,
    required DateTime expiresAt,
    @Default(0) int replyCount,
  }) = _UserNote;
}

