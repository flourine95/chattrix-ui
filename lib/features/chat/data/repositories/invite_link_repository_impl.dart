import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/invite_link_datasource.dart';
import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/repositories/base_repository.dart';
import '../../domain/entities/invite_link.dart';
import '../../domain/repositories/invite_link_repository.dart';
import '../models/invite_link_model.dart';
import '../mappers/invite_link_mapper.dart';

class InviteLinkRepositoryImpl extends BaseRepository implements InviteLinkRepository {
  final InviteLinkDatasource _datasource;

  InviteLinkRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, InviteLink>> createInviteLink({
    required int conversationId,
    int? expiresInDays,
    int? maxUses,
  }) async {
    return executeApiCall(() async {
      final request = CreateInviteLinkRequest(expiresInDays: expiresInDays, maxUses: maxUses);
      final model = await _datasource.createInviteLink(conversationId: conversationId, request: request);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, List<InviteLink>>> getInviteLinks({required int conversationId}) async {
    return executeApiCall(() async {
      final models = await _datasource.getInviteLinks(conversationId: conversationId);
      return models.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, InviteLink>> revokeInviteLink({required int conversationId, required int linkId}) async {
    return executeApiCall(() async {
      final model = await _datasource.revokeInviteLink(conversationId: conversationId, linkId: linkId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, InviteLinkInfo>> getInviteLinkInfo({required String token}) async {
    return executeApiCall(() async {
      final model = await _datasource.getInviteLinkInfo(token: token);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, JoinViaInviteLink>> joinViaInviteLink({required String token}) async {
    return executeApiCall(() async {
      final model = await _datasource.joinViaInviteLink(token: token);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, List<int>>> getQrCode({
    required int conversationId,
    required int linkId,
    String? apiUrl,
  }) async {
    return executeApiCall(() async {
      return await _datasource.getQrCode(conversationId: conversationId, linkId: linkId, apiUrl: apiUrl);
    });
  }
}
