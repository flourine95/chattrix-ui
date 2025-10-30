import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/features/auth/data/models/user_model.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_model.dart';
import 'package:chattrix_ui/features/chat/data/models/message_model.dart';
import 'package:chattrix_ui/features/chat/data/models/search_user_model.dart';
import 'package:chattrix_ui/features/chat/data/models/user_status_model.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/chat_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ChatRemoteDatasourceImpl implements ChatRemoteDatasource {
  final Dio dio;

  ChatRemoteDatasourceImpl({required this.dio});

  @override
  Future<ConversationModel> createConversation({
    String? name,
    required String type,
    required List<String> participantIds,
  }) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}/${ApiConstants.conversationsBase}',
        data: {
          if (name != null) 'name': name,
          'type': type,
          'participantIds': participantIds,
        },
      );

      if (response.statusCode == 201) {
        final data = response.data['data'] as Map<String, dynamic>;
        return ConversationModel.fromApi(data);
      }

      throw ServerException(message: 'Failed to create conversation');
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to create conversation',
      );
    }
  }

  @override
  Future<List<ConversationModel>> getConversations() async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}/${ApiConstants.conversationsBase}',
      );

      if (response.statusCode == 200) {
        debugPrint('📋 Conversations API Response:');
        debugPrint('   Status: ${response.statusCode}');
        debugPrint('   Data type: ${response.data.runtimeType}');

        final data = response.data['data'] as List;
        debugPrint('   Conversations count: ${data.length}');

        // Debug first conversation to see structure
        if (data.isNotEmpty) {
          final firstConv = data.first as Map<String, dynamic>;
          debugPrint('   First conversation keys: ${firstConv.keys.toList()}');
          if (firstConv.containsKey('participants')) {
            final participants = firstConv['participants'] as List;
            debugPrint(
              '   First conversation participants: ${participants.length}',
            );
            if (participants.isNotEmpty) {
              final firstParticipant =
                  participants.first as Map<String, dynamic>;
              debugPrint(
                '   First participant keys: ${firstParticipant.keys.toList()}',
              );
              debugPrint('   First participant data: $firstParticipant');
            }
          }
        }

        return data
            .whereType<Map<String, dynamic>>()
            .map((json) => ConversationModel.fromApi(json))
            .toList();
      }

      throw ServerException(message: 'Failed to fetch conversations');
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to fetch conversations',
      );
    }
  }

  @override
  Future<ConversationModel> getConversation(String conversationId) async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}/${ApiConstants.conversationById(conversationId)}',
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>;
        return ConversationModel.fromApi(data);
      }

      throw ServerException(message: 'Failed to fetch conversation');
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to fetch conversation',
      );
    }
  }

  @override
  Future<List<MessageModel>> getMessages({
    required String conversationId,
    int page = 0,
    int size = 50,
    String sort = 'DESC',
  }) async {
    try {
      final url =
          '${ApiConstants.baseUrl}/${ApiConstants.messagesInConversation(conversationId)}';
      debugPrint('💬 Get Messages Request:');
      debugPrint('   URL: $url');
      debugPrint('   Conversation ID: $conversationId');
      debugPrint('   Page: $page, Size: $size, Sort: $sort');

      final response = await dio.get(
        url,
        queryParameters: {'page': page, 'size': size, 'sort': sort},
      );

      debugPrint('💬 Get Messages Response:');
      debugPrint('   Status: ${response.statusCode}');
      debugPrint('   Data type: ${response.data.runtimeType}');

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        debugPrint('   Messages count: ${data.length}');

        if (data.isNotEmpty) {
          debugPrint('   First message keys: ${(data.first as Map).keys}');
          debugPrint('   First message: ${data.first}');
        }

        return data
            .whereType<Map<String, dynamic>>()
            .map((json) => MessageModel.fromApi(json))
            .toList();
      }

      throw ServerException(message: 'Failed to fetch messages');
    } on DioException catch (e) {
      debugPrint('❌ Get Messages Error:');
      debugPrint('   Type: ${e.type}');
      debugPrint('   Message: ${e.message}');
      debugPrint('   Status Code: ${e.response?.statusCode}');
      debugPrint('   Response Data: ${e.response?.data}');
      debugPrint('   Response Headers: ${e.response?.headers}');

      // If 500 error, return empty list instead of throwing
      // This allows the app to continue working while backend is being fixed
      if (e.response?.statusCode == 500) {
        debugPrint('⚠️ Backend error 500, returning empty messages list');
        debugPrint(
          '⚠️ Please check backend logs for the actual error details',
        );
        return []; // Return empty list instead of crashing
      }

      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to fetch messages',
      );
    } catch (e, stackTrace) {
      debugPrint('❌ Get Messages Unexpected Error: $e');
      debugPrint('   Stack trace: $stackTrace');
      throw ServerException(message: 'Failed to fetch messages: $e');
    }
  }

  @override
  Future<List<UserModel>> getOnlineUsers() async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}/${ApiConstants.onlineUsers}',
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((json) => UserModel.fromJson(json)).toList();
      }

      throw ServerException(message: 'Failed to fetch online users');
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to fetch online users',
      );
    }
  }

  @override
  Future<List<UserModel>> getOnlineUsersInConversation(
    String conversationId,
  ) async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}/${ApiConstants.onlineUsersInConversation(conversationId)}',
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((json) => UserModel.fromJson(json)).toList();
      }

      throw ServerException(
        message: 'Failed to fetch online users in conversation',
      );
    } on DioException catch (e) {
      throw ServerException(
        message:
            e.response?.data['message'] ??
            'Failed to fetch online users in conversation',
      );
    }
  }

  @override
  Future<UserStatusModel> getUserStatus(String userId) async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}/${ApiConstants.userStatus(userId)}',
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        return UserStatusModel.fromJson(data);
      }

      throw ServerException(message: 'Failed to fetch user status');
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to fetch user status',
      );
    }
  }

  @override
  Future<MessageModel> sendMessage({
    required String conversationId,
    required String content,
    String? type,
    String? mediaUrl,
    String? thumbnailUrl,
    String? fileName,
    int? fileSize,
    int? duration,
    double? latitude,
    double? longitude,
    String? locationName,
    int? replyToMessageId,
    String? mentions,
  }) async {
    try {
      // Build request data with all fields
      final data = <String, dynamic>{
        'content': content,
        if (type != null) 'type': type,
        if (mediaUrl != null) 'mediaUrl': mediaUrl,
        if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
        if (fileName != null) 'fileName': fileName,
        if (fileSize != null) 'fileSize': fileSize,
        if (duration != null) 'duration': duration,
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
        if (locationName != null) 'locationName': locationName,
        if (replyToMessageId != null) 'replyToMessageId': replyToMessageId,
        if (mentions != null) 'mentions': mentions,
      };

      final url = '${ApiConstants.baseUrl}/${ApiConstants.messagesInConversation(conversationId)}';
      debugPrint('📤 [API] POST $url');
      debugPrint('📤 [API] Request data: $data');

      final response = await dio.post(url, data: data);

      debugPrint('📥 [API] Response status: ${response.statusCode}');
      debugPrint('📥 [API] Response data: ${response.data}');

      if (response.statusCode == 201) {
        final responseData = response.data['data'] as Map<String, dynamic>;
        return MessageModel.fromApi(responseData);
      }

      throw ServerException(message: 'Failed to send message');
    } on DioException catch (e) {
      debugPrint('❌ [API] DioException: ${e.message}');
      debugPrint('❌ [API] Response: ${e.response?.data}');
      debugPrint('❌ [API] Status code: ${e.response?.statusCode}');
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to send message',
      );
    } catch (e) {
      debugPrint('❌ [API] Unexpected error: $e');
      rethrow;
    }
  }

  @override
  Future<List<SearchUserModel>> searchUsers({
    required String query,
    int limit = 20,
  }) async {
    try {
      final url = '${ApiConstants.baseUrl}/${ApiConstants.searchUsers}';
      debugPrint('🔍 Search Users Request:');
      debugPrint('   URL: $url');
      debugPrint('   Query: $query');
      debugPrint('   Limit: $limit');

      final response = await dio.get(
        url,
        queryParameters: {'query': query, 'limit': limit},
      );

      debugPrint('🔍 Search Users Response:');
      debugPrint('   Status: ${response.statusCode}');
      debugPrint('   Data type: ${response.data.runtimeType}');
      debugPrint('   Data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        debugPrint('   Users found: ${data.length}');

        if (data.isNotEmpty) {
          debugPrint('   First user: ${data.first}');
        }

        return data
            .whereType<Map<String, dynamic>>()
            .map((json) => SearchUserModel.fromJson(json))
            .toList();
      }

      throw ServerException(message: 'Failed to search users');
    } on DioException catch (e) {
      debugPrint('❌ Search Users Error:');
      debugPrint('   Type: ${e.type}');
      debugPrint('   Message: ${e.message}');
      debugPrint('   Response: ${e.response?.data}');
      debugPrint('   Status Code: ${e.response?.statusCode}');

      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to search users',
      );
    } catch (e) {
      debugPrint('❌ Search Users Unexpected Error: $e');
      throw ServerException(message: 'Failed to search users: $e');
    }
  }
}
