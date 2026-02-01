import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/network/api_response.dart';
import 'package:chattrix_ui/features/invite_links/data/models/invite_link_dto.dart';
import 'package:dio/dio.dart';

class InviteLinksApiService {
  final Dio _dio;

  InviteLinksApiService(this._dio);

  /// Create invite link
  /// 
  /// **Endpoint**: `POST /v1/conversations/{conversationId}/invite-link`
  /// 
  /// **Errors:**
  /// - 400: Invalid parameters
  /// - 401: Unauthorized
  /// - 403: Not admin/owner
  /// - 404: Conversation not found
  Future<ApiResponse<InviteLinkDto>> createInviteLink({
    required int conversationId,
    int? expiresIn,
    int? maxUses,
  }) async {
    final response = await _dio.post(
      ApiConstants.createInviteLink(conversationId),
      data: {
        if (expiresIn != null) 'expiresIn': expiresIn,
        if (maxUses != null) 'maxUses': maxUses,
      },
    );

    return ApiResponse<InviteLinkDto>.fromJson(
      response.data,
      (json) => InviteLinkDto.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Get invite link history with cursor-based pagination
  /// 
  /// **Endpoint**: `GET /v1/conversations/{conversationId}/invite-links`
  /// 
  /// **Query Parameters:**
  /// - cursor: Pagination cursor
  /// - limit: Items per page (default: 20)
  /// - status: Filter by status (active, inactive, revoked, expired, max_uses_reached)
  /// 
  /// **Errors:**
  /// - 401: Unauthorized
  /// - 403: Not a member
  /// - 404: Conversation not found
  Future<ApiResponse<InviteLinksHistoryDto>> getInviteLinksHistory({
    required int conversationId,
    String? cursor,
    int limit = 20,
    String? status,
  }) async {
    final response = await _dio.get(
      ApiConstants.getInviteLinksHistory(conversationId),
      queryParameters: {
        if (cursor != null) 'cursor': cursor,
        'limit': limit,
        if (status != null) 'status': status,
      },
    );

    return ApiResponse<InviteLinksHistoryDto>.fromJson(
      response.data,
      (json) => InviteLinksHistoryDto.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Get current invite link
  /// 
  /// **Endpoint**: `GET /v1/conversations/{conversationId}/invite-link`
  /// 
  /// **Errors:**
  /// - 401: Unauthorized
  /// - 403: Not a member
  /// - 404: Conversation not found or no active link
  Future<ApiResponse<InviteLinkDto>> getInviteLink({
    required int conversationId,
  }) async {
    final response = await _dio.get(
      ApiConstants.getInviteLink(conversationId),
    );

    return ApiResponse<InviteLinkDto>.fromJson(
      response.data,
      (json) => InviteLinkDto.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Revoke invite link
  /// 
  /// **Endpoint**: `DELETE /v1/conversations/{conversationId}/invite-link`
  /// 
  /// **Errors:**
  /// - 401: Unauthorized
  /// - 403: Not admin/owner
  /// - 404: Conversation not found or no active link
  Future<ApiResponse<InviteLinkDto>> revokeInviteLink({
    required int conversationId,
  }) async {
    final response = await _dio.delete(
      ApiConstants.revokeInviteLink(conversationId),
    );

    return ApiResponse<InviteLinkDto>.fromJson(
      response.data,
      (json) => InviteLinkDto.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Get invite link info (preview) - No auth required
  /// 
  /// **Endpoint**: `GET /v1/invite/{token}`
  /// 
  /// **Errors:**
  /// - 404: Invalid token
  /// - 410: Link expired or revoked
  Future<ApiResponse<InviteLinkInfoDto>> getInviteLinkInfo({
    required String token,
  }) async {
    final response = await _dio.get(
      ApiConstants.inviteLinkPreview(token),
    );

    return ApiResponse<InviteLinkInfoDto>.fromJson(
      response.data,
      (json) => InviteLinkInfoDto.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Join group via invite link
  /// 
  /// **Endpoint**: `POST /v1/invite/{token}/join`
  /// 
  /// **Errors:**
  /// - 400: Already a member
  /// - 401: Unauthorized
  /// - 404: Invalid token
  /// - 410: Link expired or revoked
  /// - 429: Max uses reached
  Future<ApiResponse<JoinGroupResponseDto>> joinGroupViaLink({
    required String token,
  }) async {
    final response = await _dio.post(
      ApiConstants.joinViaInviteLink(token),
    );

    return ApiResponse<JoinGroupResponseDto>.fromJson(
      response.data,
      (json) => JoinGroupResponseDto.fromJson(json as Map<String, dynamic>),
    );
  }
}
