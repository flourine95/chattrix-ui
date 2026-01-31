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
  const ConversationPermissions._();

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

  /// Check if user can send messages
  bool canSendMessages(bool isAdmin) {
    return isAdmin || sendMessages == 'ALL';
  }

  /// Check if user can add members
  bool canAddMembers(bool isAdmin) {
    return isAdmin || addMembers == 'ALL';
  }

  /// Check if user can edit group info
  bool canEditGroupInfo(bool isAdmin) {
    return isAdmin || editGroupInfo == 'ALL';
  }

  /// Check if user can pin messages
  bool canPinMessages(bool isAdmin) {
    return isAdmin || pinMessages == 'ALL';
  }

  /// Check if user can create polls
  bool canCreatePolls(bool isAdmin) {
    return isAdmin || createPolls == 'ALL';
  }

  /// Check if user can delete a message
  /// @param isAdmin - Whether the user is an admin
  /// @param isOwner - Whether the user is the message owner
  bool canDeleteMessage(bool isAdmin, bool isOwner) {
    if (deleteMessages == 'ALL') return true;
    if (deleteMessages == 'ADMIN_ONLY') return isAdmin;
    if (deleteMessages == 'OWNER') return isOwner;
    return false;
  }

  /// Remove members is always admin only
  bool canRemoveMembers(bool isAdmin) {
    return isAdmin;
  }
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
