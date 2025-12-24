import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/invite_link_entity.dart';

/// Repository interface for invite links
abstract class InviteLinksRepository {
  /// Create invite link
  ///
  /// Returns [Right] with [InviteLinkEntity] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, InviteLinkEntity>> createInviteLink({
    required int conversationId,
    int? expiresIn,
    int? maxUses,
  });

  /// Get all invite links for a conversation
  ///
  /// Returns [Right] with list of [InviteLinkEntity] and pagination meta on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, ({List<InviteLinkEntity> items, String? nextCursor, bool hasNextPage})>> getInviteLinks({
    required int conversationId,
    String? cursor,
    int limit = 20,
    bool includeRevoked = false,
  });

  /// Revoke invite link
  ///
  /// Returns [Right] with updated [InviteLinkEntity] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, InviteLinkEntity>> revokeInviteLink({required int conversationId, required int linkId});

  /// Get QR code for invite link
  ///
  /// Returns [Right] with image bytes on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<int>>> getQRCode({
    required int conversationId,
    required int linkId,
    int size = 300,
    String? apiUrl,
  });

  /// Get invite link info (public, no auth required)
  ///
  /// Returns [Right] with [InviteLinkInfoEntity] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, InviteLinkInfoEntity>> getInviteLinkInfo({required String token});

  /// Join group via invite link
  ///
  /// Returns [Right] with [JoinGroupResultEntity] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, JoinGroupResultEntity>> joinGroupViaLink({required String token});
}
