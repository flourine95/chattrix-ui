import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/repositories/base_repository.dart';
import 'package:chattrix_ui/features/invite_links/data/datasources/remote/invite_links_api_service.dart';
import 'package:chattrix_ui/features/invite_links/data/mappers/invite_link_mapper.dart';
import 'package:chattrix_ui/features/invite_links/data/models/invite_link_dto.dart';
import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:chattrix_ui/features/invite_links/domain/repositories/invite_links_repository.dart';
import 'package:fpdart/fpdart.dart';

class InviteLinksRepositoryImpl extends BaseRepository implements InviteLinksRepository {
  final InviteLinksApiService _apiService;

  InviteLinksRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, InviteLinkEntity>> createInviteLink({
    required int conversationId,
    int? expiresIn,
    int? maxUses,
  }) async {
    return executeApiCall(() async {
      final response = await _apiService.createInviteLink(
        conversationId: conversationId,
        expiresIn: expiresIn,
        maxUses: maxUses,
      );

      if (response.success && response.data != null) {
        return response.data!.toEntity();
      } else {
        throw ApiException(message: response.message, code: 'CREATE_LINK_ERROR', statusCode: 500);
      }
    });
  }

  @override
  Future<Either<Failure, ({List<InviteLinkEntity> items, String? nextCursor, bool hasNextPage})>> getInviteLinks({
    required int conversationId,
    String? cursor,
    int limit = 20,
    bool includeRevoked = false,
  }) async {
    return executeApiCall(() async {
      final response = await _apiService.getInviteLinks(
        conversationId: conversationId,
        cursor: cursor,
        limit: limit,
        includeRevoked: includeRevoked,
      );

      if (response.success && response.data != null) {
        final data = response.data!;
        final items = (data['items'] as List)
            .map((json) => InviteLinkDto.fromJson(json as Map<String, dynamic>).toEntity())
            .toList();

        final meta = data['meta'] as Map<String, dynamic>;
        final nextCursor = meta['nextCursor'] as String?;
        final hasNextPage = meta['hasNextPage'] as bool;

        return (items: items, nextCursor: nextCursor, hasNextPage: hasNextPage);
      } else {
        throw ApiException(message: response.message, code: 'GET_LINKS_ERROR', statusCode: 500);
      }
    });
  }

  @override
  Future<Either<Failure, InviteLinkEntity>> revokeInviteLink({required int conversationId, required int linkId}) async {
    return executeApiCall(() async {
      final response = await _apiService.revokeInviteLink(conversationId: conversationId, linkId: linkId);

      if (response.success && response.data != null) {
        return response.data!.toEntity();
      } else {
        throw ApiException(message: response.message, code: 'REVOKE_LINK_ERROR', statusCode: 500);
      }
    });
  }

  @override
  Future<Either<Failure, List<int>>> getQRCode({
    required int conversationId,
    required int linkId,
    int size = 300,
    String? apiUrl,
  }) async {
    return executeApiCall(() async {
      return await _apiService.getQRCode(conversationId: conversationId, linkId: linkId, size: size, apiUrl: apiUrl);
    });
  }

  @override
  Future<Either<Failure, InviteLinkInfoEntity>> getInviteLinkInfo({required String token}) async {
    return executeApiCall(() async {
      final response = await _apiService.getInviteLinkInfo(token: token);

      if (response.success && response.data != null) {
        return response.data!.toEntity();
      } else {
        throw ApiException(message: response.message, code: 'GET_LINK_INFO_ERROR', statusCode: 500);
      }
    });
  }

  @override
  Future<Either<Failure, JoinGroupResultEntity>> joinGroupViaLink({required String token}) async {
    return executeApiCall(() async {
      final response = await _apiService.joinGroupViaLink(token: token);

      if (response.success && response.data != null) {
        return response.data!.toEntity();
      } else {
        throw ApiException(message: response.message, code: 'JOIN_GROUP_ERROR', statusCode: 500);
      }
    });
  }
}
