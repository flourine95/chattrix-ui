import 'package:chattrix_ui/core/network/api_response.dart';
import 'package:chattrix_ui/features/invite_links/data/models/invite_link_dto.dart';
import 'package:dio/dio.dart';

class InviteLinksApiService {
  final Dio _dio;

  InviteLinksApiService(this._dio);

  Future<ApiResponse<InviteLinkDto>> createInviteLink({
    required int conversationId,
    int? expiresIn,
    int? maxUses,
  }) async {
    final response = await _dio.post(
      '/v1/invite-links/conversations/$conversationId',
      data: {if (expiresIn != null) 'expiresIn': expiresIn, if (maxUses != null) 'maxUses': maxUses},
    );

    return ApiResponse<InviteLinkDto>.fromJson(
      response.data,
      (json) => InviteLinkDto.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> getInviteLinks({
    required int conversationId,
    String? cursor,
    int limit = 20,
    bool includeRevoked = false,
  }) async {
    final response = await _dio.get(
      '/v1/invite-links/conversations/$conversationId',
      queryParameters: {if (cursor != null) 'cursor': cursor, 'limit': limit, 'includeRevoked': includeRevoked},
    );

    return ApiResponse<Map<String, dynamic>>.fromJson(response.data, (json) => json as Map<String, dynamic>);
  }

  Future<ApiResponse<InviteLinkDto>> revokeInviteLink({required int conversationId, required int linkId}) async {
    final response = await _dio.delete('/v1/invite-links/conversations/$conversationId/links/$linkId');

    return ApiResponse<InviteLinkDto>.fromJson(
      response.data,
      (json) => InviteLinkDto.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<List<int>> getQRCode({
    required int conversationId,
    required int linkId,
    int size = 300,
    String? apiUrl,
  }) async {
    final response = await _dio.get(
      '/v1/invite-links/conversations/$conversationId/links/$linkId/qr',
      queryParameters: {'size': size, if (apiUrl != null) 'apiUrl': apiUrl},
      options: Options(responseType: ResponseType.bytes),
    );

    return response.data as List<int>;
  }

  Future<ApiResponse<InviteLinkInfoDto>> getInviteLinkInfo({required String token}) async {
    final response = await _dio.get('/v1/invite-links/$token');

    return ApiResponse<InviteLinkInfoDto>.fromJson(
      response.data,
      (json) => InviteLinkInfoDto.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<JoinGroupResponseDto>> joinGroupViaLink({required String token}) async {
    final response = await _dio.post('/v1/invite-links/$token');

    return ApiResponse<JoinGroupResponseDto>.fromJson(
      response.data,
      (json) => JoinGroupResponseDto.fromJson(json as Map<String, dynamic>),
    );
  }
}
