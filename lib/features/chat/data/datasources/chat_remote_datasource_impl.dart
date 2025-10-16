import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/features/auth/data/models/user_model.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_model.dart';
import 'package:chattrix_ui/features/chat/data/models/message_model.dart';
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
      final response = await dio.get('${ApiConstants.baseUrl}/${ApiConstants.conversationsBase}');

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
  }) async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}/${ApiConstants.messagesInConversation(conversationId)}',
        queryParameters: {'page': page, 'size': size},
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
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to fetch messages',
      );
    }
  }

  @override
  Future<List<UserModel>> getOnlineUsers() async {
    try {
      final response = await dio.get('${ApiConstants.baseUrl}/${ApiConstants.onlineUsers}');

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
      final response = await dio.get('${ApiConstants.baseUrl}/${ApiConstants.userStatus(userId)}');

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
  }) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}/${ApiConstants.messagesInConversation(conversationId)}',
        data: {'content': content},
      );

      if (response.statusCode == 201) {
        final data = response.data['data'] as Map<String, dynamic>;
        return MessageModel.fromApi(data);
      }

      throw ServerException(message: 'Failed to send message');
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to send message',
      );
    }
  }
}
