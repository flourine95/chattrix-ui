import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/features/auth/data/models/user_model.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_model.dart';
import 'package:chattrix_ui/features/chat/data/models/message_model.dart';
import 'package:chattrix_ui/features/chat/data/models/search_user_model.dart';
import 'package:chattrix_ui/features/chat/data/models/user_status_model.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/chat_remote_datasource.dart';
import 'package:dio/dio.dart';

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
        ApiConstants.conversations,
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
        ApiConstants.conversations,
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;

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
        ApiConstants.conversationById(conversationId),
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
          ApiConstants.messagesInConversation(conversationId);

      final response = await dio.get(
        url,
        queryParameters: {'page': page, 'size': size, 'sort': sort},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;

        return data
            .whereType<Map<String, dynamic>>()
            .map((json) => MessageModel.fromApi(json))
            .toList();
      }

      throw ServerException(message: 'Failed to fetch messages');
    } on DioException catch (e) {
      // If 500 error, return empty list instead of throwing
      // This allows the app to continue working while backend is being fixed
      if (e.response?.statusCode == 500) {
        return []; // Return empty list instead of crashing
      }

      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to fetch messages',
      );
    } catch (e) {
      throw ServerException(message: 'Failed to fetch messages: $e');
    }
  }

  @override
  Future<List<UserModel>> getOnlineUsers() async {
    try {
      final response = await dio.get(
        ApiConstants.onlineUsers,
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
        ApiConstants.onlineUsersInConversation(conversationId),
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
        ApiConstants.userStatus(userId),
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

      final url = ApiConstants.messagesInConversation(conversationId);

      final response = await dio.post(url, data: data);

      if (response.statusCode == 201) {
        final responseData = response.data['data'] as Map<String, dynamic>;
        return MessageModel.fromApi(responseData);
      }

      throw ServerException(message: 'Failed to send message');
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to send message',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SearchUserModel>> searchUsers({
    required String query,
    int limit = 20,
  }) async {
    try {
      final url = ApiConstants.searchUsers;

      final response = await dio.get(
        url,
        queryParameters: {'query': query, 'limit': limit},
      );


      if (response.statusCode == 200) {
        final data = response.data['data'] as List;

        return data
            .whereType<Map<String, dynamic>>()
            .map((json) => SearchUserModel.fromJson(json))
            .toList();
      }

      throw ServerException(message: 'Failed to search users');
    } on DioException catch (e) {

      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to search users',
      );
    } catch (e) {
      throw ServerException(message: 'Failed to search users: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> toggleReaction({
    required String messageId,
    required String emoji,
  }) async {
    try {
      final url = ApiConstants.messageReactions(messageId);

      final response = await dio.post(
        url,
        data: {'emoji': emoji},
      );

      if (response.statusCode == 200) {
        return response.data['data'] as Map<String, dynamic>;
      }

      throw ServerException(message: 'Failed to toggle reaction');
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to toggle reaction',
      );
    } catch (e) {
      throw ServerException(message: 'Failed to toggle reaction: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getReactions(String messageId) async {
    try {
      final url = ApiConstants.messageReactions(messageId);

      final response = await dio.get(url);

      if (response.statusCode == 200) {
        return response.data['data'] as Map<String, dynamic>;
      }

      throw ServerException(message: 'Failed to get reactions');
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to get reactions',
      );
    } catch (e) {
      throw ServerException(message: 'Failed to get reactions: $e');
    }
  }

  @override
  Future<MessageModel> editMessage({
    required String messageId,
    required String content,
  }) async {
    try {
      final url = ApiConstants.messageEdit(messageId);

      final response = await dio.put(
        url,
        data: {'content': content},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>;
        return MessageModel.fromApi(data);
      }

      throw ServerException(message: 'Failed to edit message');
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to edit message',
      );
    } catch (e) {
      throw ServerException(message: 'Failed to edit message: $e');
    }
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    try {
      final url = ApiConstants.messageDelete(messageId);

      final response = await dio.delete(url);

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }

      throw ServerException(message: 'Failed to delete message');
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to delete message',
      );
    } catch (e) {
      throw ServerException(message: 'Failed to delete message: $e');
    }
  }
}
