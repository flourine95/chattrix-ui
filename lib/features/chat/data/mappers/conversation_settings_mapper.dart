import '../models/conversation_settings_model.dart';
import '../../domain/entities/conversation_settings.dart';

extension ConversationSettingsModelMapper on ConversationSettingsModel {
  ConversationSettings toEntity() {
    return ConversationSettings(
      conversationId: conversationId,
      muted: muted,
      blocked: blocked,
      notificationsEnabled: notificationsEnabled,
      pinned: pinned,
      pinOrder: pinOrder,
      archived: archived,
      hidden: hidden,
      customNickname: customNickname,
      theme: theme,
    );
  }
}

extension ConversationPermissionsModelMapper on ConversationPermissionsModel {
  ConversationPermissions toEntity() {
    return ConversationPermissions(
      conversationId: conversationId,
      sendMessages: sendMessages,
      addMembers: addMembers,
      removeMembers: removeMembers,
      editGroupInfo: editGroupInfo,
      pinMessages: pinMessages,
      deleteMessages: deleteMessages,
      createPolls: createPolls,
    );
  }
}

extension MutedMemberModelMapper on MutedMemberModel {
  MutedMember toEntity() {
    return MutedMember(
      userId: userId,
      username: username,
      fullName: fullName,
      muted: muted,
      mutedUntil: mutedUntil,
      mutedAt: mutedAt,
      mutedBy: mutedBy,
    );
  }
}
