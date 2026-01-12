import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/network/api_response.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_settings_model.dart';

abstract class ConversationSettingsDataSource {
  Future<ApiResponse<ConversationSettingsModel>> getSettings(int conversationId);

  Future<ApiResponse<ConversationSettingsModel>> updateSettings(
    int conversationId,
    UpdateConversationSettingsRequest request,
  );

  Future<ApiResponse<ConversationSettingsModel>> muteConversation(int conversationId);
  Future<ApiResponse<ConversationSettingsModel>> unmuteConversation(int conversationId);

  Future<ApiResponse<ConversationSettingsModel>> pinConversation(int conversationId);
  Future<ApiResponse<ConversationSettingsModel>> unpinConversation(int conversationId);

  Future<ApiResponse<ConversationSettingsModel>> hideConversation(int conversationId);
  Future<ApiResponse<ConversationSettingsModel>> unhideConversation(int conversationId);

  Future<ApiResponse<ConversationSettingsModel>> archiveConversation(int conversationId);
  Future<ApiResponse<ConversationSettingsModel>> unarchiveConversation(int conversationId);

  Future<ApiResponse<ConversationSettingsModel>> blockUser(int conversationId);
  Future<ApiResponse<ConversationSettingsModel>> unblockUser(int conversationId);

  Future<ApiResponse<MutedMemberModel>> muteMember(int conversationId, int userId, MuteMemberRequest request);

  Future<ApiResponse<MutedMemberModel>> unmuteMember(int conversationId, int userId);

  Future<ApiResponse<ConversationPermissionsModel>> getPermissions(int conversationId);

  Future<ApiResponse<ConversationPermissionsModel>> updatePermissions(
    int conversationId,
    UpdateConversationPermissionsRequest request,
  );
}

class ConversationSettingsDataSourceImpl implements ConversationSettingsDataSource {
  final Dio _dio;

  ConversationSettingsDataSourceImpl(this._dio);

  @override
  Future<ApiResponse<ConversationSettingsModel>> getSettings(int conversationId) async {
    try {
      final response = await _dio.get(ApiConstants.conversationSettings(conversationId));

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
    int conversationId,
    UpdateConversationSettingsRequest request,
  ) async {
    try {
      final response = await _dio.put(ApiConstants.conversationSettings(conversationId), data: request.toJson());

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> muteConversation(int conversationId) async {
    try {
      final response = await _dio.post(ApiConstants.muteConversation(conversationId));

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> unmuteConversation(int conversationId) async {
    try {
      final response = await _dio.post(ApiConstants.unmuteConversation(conversationId));

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> pinConversation(int conversationId) async {
    try {
      final response = await _dio.post(ApiConstants.pinConversation(conversationId));

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> unpinConversation(int conversationId) async {
    try {
      final response = await _dio.post(ApiConstants.unpinConversation(conversationId));

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> hideConversation(int conversationId) async {
    try {
      final response = await _dio.post(ApiConstants.hideConversation(conversationId));

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> unhideConversation(int conversationId) async {
    try {
      debugPrint('🔍 [Datasource] Unhiding conversation $conversationId');
      debugPrint('🔍 [Datasource] URL: ${ApiConstants.unhideConversation(conversationId)}');

      final response = await _dio.post(ApiConstants.unhideConversation(conversationId));

      debugPrint('🔍 [Datasource] Unhide response status: ${response.statusCode}');
      debugPrint('🔍 [Datasource] Unhide response data: ${response.data}');

      final apiResponse = ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );

      debugPrint('🔍 [Datasource] Parsed settings - hidden: ${apiResponse.data?.hidden}');

      return apiResponse;
    } catch (e) {
      debugPrint('🔍 [Datasource] Unhide error: $e');
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> archiveConversation(int conversationId) async {
    try {
      final response = await _dio.post(ApiConstants.archiveConversation(conversationId));

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> unarchiveConversation(int conversationId) async {
    try {
      final response = await _dio.post(ApiConstants.unarchiveConversation(conversationId));

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> blockUser(int conversationId) async {
    try {
      final response = await _dio.post(ApiConstants.blockUser(conversationId));

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationSettingsModel>> unblockUser(int conversationId) async {
    try {
      final response = await _dio.post(ApiConstants.unblockUser(conversationId));

      return ApiResponse<ConversationSettingsModel>.fromJson(
        response.data,
        (json) => ConversationSettingsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<MutedMemberModel>> muteMember(int conversationId, int userId, MuteMemberRequest request) async {
    try {
      final response = await _dio.post(ApiConstants.muteMember(conversationId, userId), data: request.toJson());

      return ApiResponse<MutedMemberModel>.fromJson(
        response.data,
        (json) => MutedMemberModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<MutedMemberModel>> unmuteMember(int conversationId, int userId) async {
    try {
      final response = await _dio.post(ApiConstants.unmuteMember(conversationId, userId));

      return ApiResponse<MutedMemberModel>.fromJson(
        response.data,
        (json) => MutedMemberModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ConversationPermissionsModel>> getPermissions(int conversationId) async {
    try {
      final response = await _dio.get(ApiConstants.conversationPermissions(conversationId));

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
    int conversationId,
    UpdateConversationPermissionsRequest request,
  ) async {
    try {
      final response = await _dio.put(ApiConstants.conversationPermissions(conversationId), data: request.toJson());

      return ApiResponse<ConversationPermissionsModel>.fromJson(
        response.data,
        (json) => ConversationPermissionsModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }
}
