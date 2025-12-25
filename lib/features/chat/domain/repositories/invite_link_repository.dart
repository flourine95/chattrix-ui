import 'package:fpdart/fpdart.dart';

import 'package:chattrix_ui/core/errors/failures.dart';

import '../entities/invite_link.dart';

/// Repository interface for invite links
/// Implementation: Data Layer
abstract class InviteLinkRepository {
  /// Create an invite link
  /// Returns [Right] with [InviteLink] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, InviteLink>> createInviteLink({required int conversationId, int? expiresInDays, int? maxUses});

  /// Get all invite links for a conversation
  Future<Either<Failure, List<InviteLink>>> getInviteLinks({required int conversationId});

  /// Revoke an invite link
  Future<Either<Failure, InviteLink>> revokeInviteLink({required int conversationId, required int linkId});

  /// Get invite link info (public)
  Future<Either<Failure, InviteLinkInfo>> getInviteLinkInfo({required String token});

  /// Join conversation via invite link
  Future<Either<Failure, JoinViaInviteLink>> joinViaInviteLink({required String token});

  /// Get QR code for invite link
  Future<Either<Failure, List<int>>> getQrCode({required String token});
}
