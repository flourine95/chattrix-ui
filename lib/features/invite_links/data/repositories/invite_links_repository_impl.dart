import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/repositories/base_repository.dart';
import 'package:chattrix_ui/features/invite_links/data/datasources/remote/invite_links_api_service.dart';
import 'package:chattrix_ui/features/invite_links/data/mappers/invite_link_mapper.dart';
import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:chattrix_ui/features/invite_links/domain/repositories/invite_links_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
  Future<Either<Failure, InviteLinksHistoryEntity>> getInviteLinksHistory({
    required int conversationId,
    String? cursor,
    int limit = 20,
    String? status,
  }) async {
    debugPrint('🔵 [InviteLinksRepo] Getting history for conversation $conversationId, cursor: $cursor, limit: $limit, status: $status');
    return executeApiCall(() async {
      final response = await _apiService.getInviteLinksHistory(
        conversationId: conversationId,
        cursor: cursor,
        limit: limit,
        status: status,
      );

      debugPrint('🟢 [InviteLinksRepo] API response success: ${response.success}, data: ${response.data != null}');

      if (response.success && response.data != null) {
        return response.data!.toEntity();
      } else {
        throw ApiException(
          message: response.message,
          code: 'GET_HISTORY_ERROR',
          statusCode: 500,
        );
      }
    });
  }

  @override
  Future<Either<Failure, InviteLinkEntity?>> getInviteLink({
    required int conversationId,
  }) async {
    try {
      final response = await _apiService.getInviteLink(
        conversationId: conversationId,
      );

      if (response.success && response.data != null) {
        return right(response.data!.toEntity());
      } else if (response.success && response.data == null) {
        // No active link
        return right(null);
      } else {
        throw ApiException(
          message: response.message,
          code: 'GET_LINK_ERROR',
          statusCode: 500,
        );
      }
    } on ApiException catch (e) {
      // Handle NO_ACTIVE_INVITE_LINK as success with null data
      if (e.code == 'NO_ACTIVE_INVITE_LINK') {
        return right(null);
      }
      return left(_handleApiException(e));
    } on DioException catch (e) {
      return left(_handleDioException(e));
    } catch (e) {
      return left(ServerFailure(
        message: 'Unexpected error: $e',
        code: 'UNEXPECTED_ERROR',
      ));
    }
  }

  // Helper methods from BaseRepository
  Failure _handleApiException(ApiException e) {
    switch (e.code) {
      case 'VALIDATION_ERROR':
        return ValidationFailure(
          message: e.message,
          code: e.code,
          details: e.details,
        );
      case 'UNAUTHORIZED':
        return AuthFailure(
          message: e.message,
          code: e.code,
        );
      case 'FORBIDDEN':
        return AuthFailure(
          message: e.message,
          code: e.code,
        );
      case 'RESOURCE_NOT_FOUND':
        return NotFoundFailure(
          message: e.message,
          code: e.code,
        );
      case 'CONFLICT':
        return ConflictFailure(
          message: e.message,
          code: e.code,
        );
      case 'RATE_LIMIT_EXCEEDED':
        return RateLimitFailure(
          message: e.message,
          code: e.code,
        );
      default:
        return ServerFailure(
          message: e.message,
          code: e.code,
        );
    }
  }

  Failure _handleDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return NetworkFailure(
        message: 'Connection timeout',
        code: 'TIMEOUT',
      );
    } else if (e.type == DioExceptionType.connectionError) {
      return NetworkFailure(
        message: 'No internet connection',
        code: 'NO_CONNECTION',
      );
    } else {
      return ServerFailure(
        message: e.message ?? 'Server error',
        code: 'SERVER_ERROR',
      );
    }
  }

  @override
  Future<Either<Failure, InviteLinkEntity>> revokeInviteLink({
    required int conversationId,
  }) async {
    return executeApiCall(() async {
      final response = await _apiService.revokeInviteLink(
        conversationId: conversationId,
      );

      if (response.success && response.data != null) {
        return response.data!.toEntity();
      } else {
        throw ApiException(message: response.message, code: 'REVOKE_LINK_ERROR', statusCode: 500);
      }
    });
  }

  @override
  Future<Either<Failure, InviteLinkInfoEntity>> getInviteLinkInfo({
    required String token,
  }) async {
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
  Future<Either<Failure, JoinGroupResultEntity>> joinGroupViaLink({
    required String token,
  }) async {
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
