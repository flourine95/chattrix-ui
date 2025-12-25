import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_settings.freezed.dart';

/// Domain entity for conversation settings
/// Framework-agnostic - NO Flutter/Dio/json_annotation imports
@freezed
abstract class ConversationSettings with _$ConversationSettings {
  const factory ConversationSettings({
    required int conversationId,
    required bool muted,
    required bool blocked,
    required bool notificationsEnabled,
    required bool pinned,
    int? pinOrder,
    required bool archived,
    required bool hidden,
    String? customNickname,
    String? theme,
  }) = _ConversationSettings;
}

/// Domain entity for conversation permissions
@freezed
abstract class ConversationPermissions with _$ConversationPermissions {
  const factory ConversationPermissions({
    required int conversationId,
    required String sendMessages,
    required String addMembers,
    required String removeMembers,
    required String editGroupInfo,
    required String pinMessages,
    required String deleteMessages,
    required String createPolls,
  }) = _ConversationPermissions;
}

/// Domain entity for muted member
@freezed
abstract class MutedMember with _$MutedMember {
  const factory MutedMember({
    required int userId,
    required String username,
    required String fullName,
    required bool muted,
    DateTime? mutedUntil,
    DateTime? mutedAt,
    int? mutedBy,
  }) = _MutedMember;
}
