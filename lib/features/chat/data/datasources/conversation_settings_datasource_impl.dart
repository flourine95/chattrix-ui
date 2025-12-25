import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_settings_model.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/conversation_settings_datasource.dart';
import 'package:dio/dio.dart';

class ConversationSettingsDatasourceImpl implements ConversationSettingsDatasource {
  final Dio dio;

  ConversationSettingsDatasourceImpl({required this.dio});

  @override
  Future<ConversationSettingsModel> getSettings({required int conversationId}) async {
    try {
      final response = await dio.get('/v1/conversations/$conversationId/settings');

      if (response.statusCode == 200) {
        return ConversationSettingsModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to get settings');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to get settings');
    }
  }

  @override
  Future<ConversationSettingsModel> updateSettings({
    required int conversationId,
    required UpdateConversationSettingsRequest request,
  }) async {
    try {
      final response = await dio.put('/v1/conversations/$conversationId/settings', data: request.toJson());

      if (response.statusCode == 200) {
        return ConversationSettingsModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to update settings');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to update settings');
    }
  }

  @override
  Future<ConversationSettingsModel> muteConversation({required int conversationId}) async {
    try {
      final response = await dio.post('/v1/conversations/$conversationId/settings/mute');

      if (response.statusCode == 200) {
        return ConversationSettingsModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to mute conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to mute conversation');
    }
  }

  @override
  Future<ConversationSettingsModel> unmuteConversation({required int conversationId}) async {
    try {
      final response = await dio.post('/v1/conversations/$conversationId/settings/unmute');

      if (response.statusCode == 200) {
        return ConversationSettingsModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to unmute conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to unmute conversation');
    }
  }

  @override
  Future<ConversationSettingsModel> pinConversation({required int conversationId}) async {
    try {
      final response = await dio.post('/v1/conversations/$conversationId/settings/pin');

      if (response.statusCode == 200) {
        return ConversationSettingsModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to pin conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to pin conversation');
    }
  }

  @override
  Future<ConversationSettingsModel> unpinConversation({required int conversationId}) async {
    try {
      final response = await dio.post('/v1/conversations/$conversationId/settings/unpin');

      if (response.statusCode == 200) {
        return ConversationSettingsModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to unpin conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to unpin conversation');
    }
  }

  @override
  Future<ConversationSettingsModel> hideConversation({required int conversationId}) async {
    try {
      final response = await dio.post('/v1/conversations/$conversationId/settings/hide');

      if (response.statusCode == 200) {
        return ConversationSettingsModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to hide conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to hide conversation');
    }
  }

  @override
  Future<ConversationSettingsModel> unhideConversation({required int conversationId}) async {
    try {
      final response = await dio.post('/v1/conversations/$conversationId/settings/unhide');

      if (response.statusCode == 200) {
        return ConversationSettingsModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to unhide conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to unhide conversation');
    }
  }

  @override
  Future<ConversationSettingsModel> archiveConversation({required int conversationId}) async {
    try {
      final response = await dio.post('/v1/conversations/$conversationId/settings/archive');

      if (response.statusCode == 200) {
        return ConversationSettingsModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to archive conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to archive conversation');
    }
  }

  @override
  Future<ConversationSettingsModel> unarchiveConversation({required int conversationId}) async {
    try {
      final response = await dio.post('/v1/conversations/$conversationId/settings/unarchive');

      if (response.statusCode == 200) {
        return ConversationSettingsModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to unarchive conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to unarchive conversation');
    }
  }

  @override
  Future<ConversationSettingsModel> blockUser({required int conversationId}) async {
    try {
      final response = await dio.post('/v1/conversations/$conversationId/settings/block');

      if (response.statusCode == 200) {
        return ConversationSettingsModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to block user');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to block user');
    }
  }

  @override
  Future<ConversationSettingsModel> unblockUser({required int conversationId}) async {
    try {
      final response = await dio.post('/v1/conversations/$conversationId/settings/unblock');

      if (response.statusCode == 200) {
        return ConversationSettingsModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to unblock user');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to unblock user');
    }
  }

  @override
  Future<MutedMemberModel> muteMember({
    required int conversationId,
    required int userId,
    required MuteMemberRequest request,
  }) async {
    try {
      final response = await dio.post(
        '/v1/conversations/$conversationId/settings/members/$userId/mute',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return MutedMemberModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to mute member');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to mute member');
    }
  }

  @override
  Future<MutedMemberModel> unmuteMember({required int conversationId, required int userId}) async {
    try {
      final response = await dio.post('/v1/conversations/$conversationId/settings/members/$userId/unmute');

      if (response.statusCode == 200) {
        return MutedMemberModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to unmute member');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to unmute member');
    }
  }

  @override
  Future<ConversationPermissionsModel> getPermissions({required int conversationId}) async {
    try {
      final response = await dio.get('/v1/conversations/$conversationId/settings/permissions');

      if (response.statusCode == 200) {
        return ConversationPermissionsModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to get permissions');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to get permissions');
    }
  }

  @override
  Future<ConversationPermissionsModel> updatePermissions({
    required int conversationId,
    required UpdateConversationPermissionsRequest request,
  }) async {
    try {
      final response = await dio.put('/v1/conversations/$conversationId/settings/permissions', data: request.toJson());

      if (response.statusCode == 200) {
        return ConversationPermissionsModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to update permissions');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to update permissions');
    }
  }
}
