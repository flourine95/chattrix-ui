import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_settings_model.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/conversation_settings_datasource.dart';
import 'package:dio/dio.dart';

class ConversationSettingsDatasourceImpl implements ConversationSettingsDatasource {
  final Dio dio;

  ConversationSettingsDatasourceImpl({required this.dio});

  @override
  Future<ConversationSettingsModel> getSettings({required int conversationId}) async {
    // Settings endpoint removed in new API
    // Return default settings - actual state comes from conversation object
    return ConversationSettingsModel(conversationId: conversationId);
  }

  @override
  Future<ConversationSettingsModel> updateSettings({
    required int conversationId,
    required UpdateConversationSettingsRequest request,
  }) async {
    // Settings endpoint removed in new API
    // Use specific action endpoints instead (mute, pin, archive, etc.)
    throw UnimplementedError('Use specific action endpoints: mute, pin, archive, etc.');
  }

  @override
  Future<ConversationSettingsModel> muteConversation({required int conversationId}) async {
    try {
      final response = await dio.post(ApiConstants.muteConversation(conversationId));

      if (response.statusCode == 200) {
        // New API returns conversation object, extract settings
        return ConversationSettingsModel(
          conversationId: conversationId,
          muted: true,
        );
      }

      throw ServerException(message: 'Failed to mute conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to mute conversation');
    }
  }

  @override
  Future<ConversationSettingsModel> unmuteConversation({required int conversationId}) async {
    try {
      final response = await dio.post(ApiConstants.unmuteConversation(conversationId));

      if (response.statusCode == 200) {
        return ConversationSettingsModel(
          conversationId: conversationId,
          muted: false,
        );
      }

      throw ServerException(message: 'Failed to unmute conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to unmute conversation');
    }
  }

  @override
  Future<ConversationSettingsModel> pinConversation({required int conversationId}) async {
    try {
      final response = await dio.post(ApiConstants.pinConversation(conversationId));

      if (response.statusCode == 200) {
        return ConversationSettingsModel(
          conversationId: conversationId,
          pinned: true,
        );
      }

      throw ServerException(message: 'Failed to pin conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to pin conversation');
    }
  }

  @override
  Future<ConversationSettingsModel> unpinConversation({required int conversationId}) async {
    try {
      final response = await dio.post(ApiConstants.unpinConversation(conversationId));

      if (response.statusCode == 200) {
        return ConversationSettingsModel(
          conversationId: conversationId,
          pinned: false,
        );
      }

      throw ServerException(message: 'Failed to unpin conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to unpin conversation');
    }
  }

  @override
  Future<ConversationSettingsModel> hideConversation({required int conversationId}) async {
    // Hide endpoint not in new API spec
    // May need to be handled differently or removed
    throw UnimplementedError('Hide conversation not available in new API');
  }

  @override
  Future<ConversationSettingsModel> unhideConversation({required int conversationId}) async {
    // Unhide endpoint not in new API spec
    throw UnimplementedError('Unhide conversation not available in new API');
  }

  @override
  Future<ConversationSettingsModel> archiveConversation({required int conversationId}) async {
    try {
      final response = await dio.post(ApiConstants.archiveConversation(conversationId));

      if (response.statusCode == 200) {
        return ConversationSettingsModel(
          conversationId: conversationId,
          archived: true,
        );
      }

      throw ServerException(message: 'Failed to archive conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to archive conversation');
    }
  }

  @override
  Future<ConversationSettingsModel> unarchiveConversation({required int conversationId}) async {
    try {
      final response = await dio.post(ApiConstants.unarchiveConversation(conversationId));

      if (response.statusCode == 200) {
        return ConversationSettingsModel(
          conversationId: conversationId,
          archived: false,
        );
      }

      throw ServerException(message: 'Failed to unarchive conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to unarchive conversation');
    }
  }

  @override
  Future<ConversationSettingsModel> blockUser({required int conversationId}) async {
    // Block endpoint not in new API spec
    throw UnimplementedError('Block user not available in new API');
  }

  @override
  Future<ConversationSettingsModel> unblockUser({required int conversationId}) async {
    // Unblock endpoint not in new API spec
    throw UnimplementedError('Unblock user not available in new API');
  }

  @override
  Future<MutedMemberModel> muteMember({
    required int conversationId,
    required int userId,
    required MuteMemberRequest request,
  }) async {
    // Member mute endpoint not in new API spec
    throw UnimplementedError('Mute member not available in new API');
  }

  @override
  Future<MutedMemberModel> unmuteMember({required int conversationId, required int userId}) async {
    // Member unmute endpoint not in new API spec
    throw UnimplementedError('Unmute member not available in new API');
  }

  @override
  Future<ConversationPermissionsModel> getPermissions({required int conversationId}) async {
    try {
      final response = await dio.get(ApiConstants.conversationPermissions(conversationId));

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
      final response = await dio.put(ApiConstants.conversationPermissions(conversationId), data: request.toJson());

      if (response.statusCode == 200) {
        return ConversationPermissionsModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to update permissions');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to update permissions');
    }
  }
}
