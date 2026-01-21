import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class InviteLinksRepository {
  /// Create invite link for a conversation
  /// Returns the created invite link
  Future<Either<Failure, InviteLinkEntity>> createInviteLink({
    required int conversationId,
    int? expiresIn,
    int? maxUses,
  });

  /// Get invite links history with cursor-based pagination
  /// Returns paginated list of all links (active, expired, revoked)
  Future<Either<Failure, InviteLinksHistoryEntity>> getInviteLinksHistory({
    required int conversationId,
    String? cursor,
    int limit = 20,
  });

  /// Get current active invite link for a conversation
  /// Returns null if no active link exists
  Future<Either<Failure, InviteLinkEntity?>> getInviteLink({
    required int conversationId,
  });

  /// Revoke the current invite link
  /// Returns the revoked link
  Future<Either<Failure, InviteLinkEntity>> revokeInviteLink({
    required int conversationId,
  });

  /// Get invite link info (preview) - No auth required
  /// Returns group info for the invite link
  Future<Either<Failure, InviteLinkInfoEntity>> getInviteLinkInfo({
    required String token,
  });

  /// Join group via invite link
  /// Returns the conversation ID
  Future<Either<Failure, JoinGroupResultEntity>> joinGroupViaLink({
    required String token,
  });
}
