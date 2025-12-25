import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/features/chat/data/models/invite_link_model.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/invite_link_datasource.dart';
import 'package:dio/dio.dart';

class InviteLinkDatasourceImpl implements InviteLinkDatasource {
  final Dio dio;

  InviteLinkDatasourceImpl({required this.dio});

  @override
  Future<InviteLinkModel> createInviteLink({
    required int conversationId,
    required CreateInviteLinkRequest request,
  }) async {
    try {
      final response = await dio.post('/v1/conversations/$conversationId/invite-links', data: request.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return InviteLinkModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to create invite link');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to create invite link');
    }
  }

  @override
  Future<List<InviteLinkModel>> getInviteLinks({required int conversationId}) async {
    try {
      final response = await dio.get('/v1/conversations/$conversationId/invite-links');

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final List<dynamic> items = data['items'] as List<dynamic>;
        return items.map((json) => InviteLinkModel.fromJson(json as Map<String, dynamic>)).toList();
      }

      throw ServerException(message: 'Failed to get invite links');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to get invite links');
    }
  }

  @override
  Future<InviteLinkModel> revokeInviteLink({required int conversationId, required int linkId}) async {
    try {
      final response = await dio.delete('/v1/conversations/$conversationId/invite-links/$linkId');

      if (response.statusCode == 200) {
        return InviteLinkModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to revoke invite link');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to revoke invite link');
    }
  }

  @override
  Future<InviteLinkInfoModel> getInviteLinkInfo({required String token}) async {
    try {
      final response = await dio.get('/v1/invite-links/$token');

      if (response.statusCode == 200) {
        return InviteLinkInfoModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to get invite link info');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to get invite link info');
    }
  }

  @override
  Future<JoinViaInviteLinkResponse> joinViaInviteLink({required String token}) async {
    try {
      final response = await dio.post('/v1/invite-links/$token/join');

      if (response.statusCode == 200) {
        return JoinViaInviteLinkResponse.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to join via invite link');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to join via invite link');
    }
  }

  @override
  Future<List<int>> getQrCode({required String token}) async {
    try {
      final response = await dio.get('/v1/invite-links/$token/qr', options: Options(responseType: ResponseType.bytes));

      if (response.statusCode == 200) {
        return response.data as List<int>;
      }

      throw ServerException(message: 'Failed to get QR code');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to get QR code');
    }
  }
}
