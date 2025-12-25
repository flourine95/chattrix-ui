import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class InviteLinksRepository {
  Future<Either<Failure, InviteLinkEntity>> createInviteLink({
    required int conversationId,
    int? expiresIn,
    int? maxUses,
  });

  Future<Either<Failure, ({List<InviteLinkEntity> items, String? nextCursor, bool hasNextPage})>> getInviteLinks({
    required int conversationId,
    String? cursor,
    int limit = 20,
    bool includeRevoked = false,
  });

  Future<Either<Failure, InviteLinkEntity>> revokeInviteLink({required int conversationId, required int linkId});

  Future<Either<Failure, List<int>>> getQRCode({
    required int conversationId,
    required int linkId,
    int size = 300,
    String? apiUrl,
  });

  Future<Either<Failure, InviteLinkInfoEntity>> getInviteLinkInfo({required String token});

  Future<Either<Failure, JoinGroupResultEntity>> joinGroupViaLink({required String token});
}
