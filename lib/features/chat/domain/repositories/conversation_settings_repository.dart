import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/conversation_settings.dart';

/// Repository interface for conversation settings
/// Implementation: Data Layer
abstract class ConversationSettingsRepository {
  /// Get conversation settings
  /// Returns [Right] with [ConversationSettings] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, ConversationSettings>> getSettings({required int conversationId});

  /// Update conversation settings
  Future<Either<Failure, ConversationSettings>> updateSettings({
    required int conversationId,
    bool? notificationsEnabled,
    String? customNickname,
    String? theme,
  });

  /// Mute conversation
  Future<Either<Failure, ConversationSettings>> muteConversation({required int conversationId});

  /// Unmute conversation
  Future<Either<Failure, ConversationSettings>> unmuteConversation({required int conversationId});

  /// Pin conversation
  Future<Either<Failure, ConversationSettings>> pinConversation({required int conversationId});

  /// Unpin conversation
  Future<Either<Failure, ConversationSettings>> unpinConversation({required int conversationId});

  /// Hide conversation
  Future<Either<Failure, ConversationSettings>> hideConversation({required int conversationId});

  /// Unhide conversation
  Future<Either<Failure, ConversationSettings>> unhideConversation({required int conversationId});

  /// Archive conversation
  Future<Either<Failure, ConversationSettings>> archiveConversation({required int conversationId});

  /// Unarchive conversation
  Future<Either<Failure, ConversationSettings>> unarchiveConversation({required int conversationId});

  /// Block user (DIRECT conversations only)
  Future<Either<Failure, ConversationSettings>> blockUser({required int conversationId});

  /// Unblock user (DIRECT conversations only)
  Future<Either<Failure, ConversationSettings>> unblockUser({required int conversationId});

  /// Mute member (admin only)
  Future<Either<Failure, MutedMember>> muteMember({
    required int conversationId,
    required int userId,
    required int duration,
  });

  /// Unmute member (admin only)
  Future<Either<Failure, MutedMember>> unmuteMember({required int conversationId, required int userId});

  /// Get group permissions
  Future<Either<Failure, ConversationPermissions>> getPermissions({required int conversationId});

  /// Update group permissions (admin only)
  Future<Either<Failure, ConversationPermissions>> updatePermissions({
    required int conversationId,
    String? sendMessages,
    String? addMembers,
    String? removeMembers,
    String? editGroupInfo,
    String? pinMessages,
    String? deleteMessages,
    String? createPolls,
  });
}
