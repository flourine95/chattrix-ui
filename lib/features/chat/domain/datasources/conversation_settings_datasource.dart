import 'package:chattrix_ui/features/chat/data/models/conversation_settings_model.dart';

abstract class ConversationSettingsDatasource {
  Future<ConversationSettingsModel> getSettings({required int conversationId});

  Future<ConversationSettingsModel> updateSettings({
    required int conversationId,
    required UpdateConversationSettingsRequest request,
  });

  Future<ConversationSettingsModel> muteConversation({required int conversationId});

  Future<ConversationSettingsModel> unmuteConversation({required int conversationId});

  Future<ConversationSettingsModel> pinConversation({required int conversationId});

  Future<ConversationSettingsModel> unpinConversation({required int conversationId});

  Future<ConversationSettingsModel> hideConversation({required int conversationId});

  Future<ConversationSettingsModel> unhideConversation({required int conversationId});

  Future<ConversationSettingsModel> archiveConversation({required int conversationId});

  Future<ConversationSettingsModel> unarchiveConversation({required int conversationId});

  Future<ConversationSettingsModel> blockUser({required int conversationId});

  Future<ConversationSettingsModel> unblockUser({required int conversationId});

  Future<MutedMemberModel> muteMember({
    required int conversationId,
    required int userId,
    required MuteMemberRequest request,
  });

  Future<MutedMemberModel> unmuteMember({required int conversationId, required int userId});

  Future<ConversationPermissionsModel> getPermissions({required int conversationId});

  Future<ConversationPermissionsModel> updatePermissions({
    required int conversationId,
    required UpdateConversationPermissionsRequest request,
  });
}
