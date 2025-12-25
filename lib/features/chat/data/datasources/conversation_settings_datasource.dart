import 'package:dio/dio.dart';
import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/network/api_response.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_settings_model.dart';

abstract class ConversationSettingsDataSource {
  Future<ApiResponse<ConversationSettingsModel>> getSettings(String conversationId);
  
  Future<ApiResponse<ConversationSettingsModel>> updateSettings(
    String conversationId,
    UpdateConversationSettingsRequest request,
  );
  
  Future<ApiResponse<ConversationSettingsModel>> muteConversation(String conversationId);
  Future<ApiResponse<ConversationSettingsModel>> unmuteConversation(String conversationId);
  
  Future<ApiResponse<ConversationSettingsModel>> pinConversation(String conversationId);
  Future<ApiResponse<ConversationSettingsModel>> unpinConversation(String conversationId);
  
  Future<ApiResponse<ConversationSettingsModel>> hideConversation(String conversationId);
  Future<ApiResponse<ConversationSettingsModel>> unhideConversation(String conversationId);
  
  Future<ApiResponse<ConversationSettingsModel>> archiveConversation(String conversationId);
  Future<ApiResponse<ConversationSettingsModel>> unarchiveConversation(String conversationId);
  
  Future<ApiResponse<ConversationSettingsModel>> blockUser(String conversationId);
  Future<ApiResponse<ConversationSettingsModel>> unblockUser(String conversationId);
  
  Future<ApiResponse<MutedMemberModel>> muteMember(
    String conversationId,
    String userId,
    MuteMemberRequest request,
  );
  
  Future<ApiResponse<MutedMemberModel>> unmuteMember(
    String conversationId,
    String userId,
  );
  
  Future<ApiResponse<ConversationPermissionsModel>> getPermissions(String conversationId);
  
  Future<ApiResponse<ConversationPermissionsModel>> updatePermissions(
    String conversationId,
    UpdateConversationPermissionsRequest request,
  );
}

class ConversationSettingsDataSourceImpl implements ConversationSettingsDataSource {
  final Dio _dio;

  ConversationSettingsDataSourceImpl(this._dio);

  @override
  Future<ApiResponse<ConversationSettingsModel>> getSettings(String conversationId) async {
    try {
      final response = await _dio.get(
        ApiConstants.conversationSettings(conversationId),
      );

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> updateSettings(
    String conversationId,
    UpdateConversationSettingsRequest request,
  ) async {
    try {
      final response = await _dio.put(
        ApiConstants.conversationSettings(conversationId),
        data: request.toJson(),
      );

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> muteConversation(String conversationId) async {
    try {
      final response = await _dio.post(
        ApiConstants.muteConversation(conversationId),
      );

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> unmuteConversation(String conversationId) async {
    try {
      final response = await _dio.post(
        ApiConstants.unmuteConversation(conversationId),
      );

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> pinConversation(String conversationId) async {
    try {
      final response = await _dio.post(
        ApiConstants.pinConversation(conversationId),
      );

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> unpinConversation(String conversationId) async {
    try {
      final response = await _dio.post(
        ApiConstants.unpinConversation(conversationId),
      );

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> hideConversation(String conversationId) async {
    try {
      final response = await _dio.post(
        ApiConstants.hideConversation(conversationId),
      );

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> unhideConversation(String conversationId) async {
    try {
      final response = await _dio.post(
        ApiConstants.unhideConversation(conversationId),
      );

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> archiveConversation(String conversationId) async {
    try {
      final response = await _dio.post(
        ApiConstants.archiveConversation(conversationId),
      );

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> unarchiveConversation(String conversationId) async {
    try {
      final response = await _dio.post(
        ApiConstants.unarchiveConversation(conversationId),
      );

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> blockUser(String conversationId) async {
    try {
      final response = await _dio.post(
        ApiConstants.blockUser(conversationId),
      );

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> unblockUser(String conversationId) async {
    try {
      final response = await _dio.post(
        ApiConstants.unblockUser(conversationId),
      );

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<MutedMemberModel>> muteMember(
    String conversationId,
    String userId,
    MuteMemberRequest request,
  ) async {
    try {
      final response = await _dio.post(
        ApiConstants.muteMember(conversationId, userId),
        data: request.toJson(),
      );

      return ApiResponse<MutedMemberModel>.fromJson(
        response.data,
        (json) => MutedMemberModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<MutedMemberModel>> unmuteMember(
    String conversationId,
    String userId,
  ) async {
    try {
      final response = await _dio.post(
        ApiConstants.unmuteMember(conversationId, userId),
      );

      return ApiResponse<MutedMemberModel>.fromJson(
        response.data,
        (json) => MutedMemberModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationPermissionsModel>> getPermissions(String conversationId) async {
    try {
      final response = await _dio.get(
        ApiConstants.conversationPermissions(conversationId),
      );

      return ApiResponse<ConversationPermissionsModel>.fromJson(
        response.data,
        (json) => ConversationPermissionsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationPermissionsModel>> updatePermissions(
    String conversationId,
    UpdateConversationPermissionsRequest request,
  ) async {
    try {
      final response = await _dio.put(
        ApiConstants.conversationPermissions(conversationId),
        data: request.toJson(),
      );

      return ApiResponse<ConversationPermissionsModel>.fromJson(
        response.data,
        (json) => ConversationPermissionsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }
}

