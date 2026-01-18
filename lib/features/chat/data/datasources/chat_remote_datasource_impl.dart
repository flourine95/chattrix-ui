import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/domain/enums/conversation_filter.dart';
import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/features/auth/data/models/user_dto.dart';
import 'package:chattrix_ui/features/chat/data/models/chat_message_request.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_member_dto.dart';
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
    required List<int> participantIds,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.conversations,
        data: {if (name != null) 'name': name, 'type': type, 'participantIds': participantIds},
      );

      if (response.statusCode == 201) {
        final data = response.data['data'] as Map<String, dynamic>;
        return ConversationModel.fromApi(data);
      }

      throw ServerException(message: 'Failed to create conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to create conversation');
    }
  }

  @override
  Future<List<ConversationModel>> getConversations({ConversationFilter filter = ConversationFilter.all}) async {
    try {
      String? filterParam;
      switch (filter) {
        case ConversationFilter.all:
          filterParam = 'all';
          break;
        case ConversationFilter.unread:
          filterParam = 'unread';
          break;
        case ConversationFilter.groups:
          filterParam = 'group';
          break;
        case ConversationFilter.hidden:
          filterParam = 'all';
          break;
      }

      final response = await dio.get(ApiConstants.conversations, queryParameters: {'filter': filterParam});

      if (response.statusCode == 200) {
        final paginatedData = response.data['data'] as Map<String, dynamic>;
        final conversationsData = paginatedData['items'] as List;

        return conversationsData
            .whereType<Map<String, dynamic>>()
            .map((json) => ConversationModel.fromApi(json))
            .toList();
      }

      throw ServerException(message: 'Failed to fetch conversations');
    } on ApiException {
      rethrow;
    } on DioException catch (e) {
      if (e.error is ApiException) {
        rethrow;
      }
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to fetch conversations');
    } catch (e) {
      throw ServerException(message: 'Failed to fetch conversations: $e');
    }
  }

  @override
  Future<ConversationModel> getConversation(int conversationId) async {
    try {
      final response = await dio.get(ApiConstants.conversationById(conversationId));

      if (response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>;
        return ConversationModel.fromApi(data);
      }

      throw ServerException(message: 'Failed to fetch conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to fetch conversation');
    }
  }

  @override
  Future<List<ConversationMemberDto>> getConversationMembers({
    required int conversationId,
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.conversationMembers(conversationId),
        queryParameters: {if (cursor != null) 'cursor': cursor, 'limit': limit},
      );

      if (response.statusCode == 200) {
        final paginatedData = response.data['data'] as Map<String, dynamic>;
        final membersData = paginatedData['items'] as List;

        return membersData
            .whereType<Map<String, dynamic>>()
            .map((json) => ConversationMemberDto.fromJson(json))
            .toList();
      }

      throw ServerException(message: 'Failed to fetch conversation members');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to fetch conversation members');
    }
  }

  @override
  Future<List<MessageModel>> getMessages({
    required int conversationId,
    int page = 0,
    int size = 50,
    String sort = 'DESC',
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.messagesInConversation(conversationId),
        queryParameters: {'page': page, 'size': size, 'sort': sort},
      );

      if (response.statusCode == 200) {
        final paginatedData = response.data['data'] as Map<String, dynamic>;
        final data = paginatedData['items'] as List;

        final messages = <MessageModel>[];
        for (var json in data.whereType<Map<String, dynamic>>()) {
          try {
            if (json['type'] == 'POLL' && json['pollId'] != null && !json.containsKey('poll')) {
              try {
                final pollResponse = await dio.get(ApiConstants.pollById(conversationId, json['pollId']));
                if (pollResponse.statusCode == 200) {
                  final pollData = pollResponse.data['data'] as Map<String, dynamic>;
                  json['poll'] = pollData;
                }
              } catch (_) {
                // Ignore poll fetch error
              }
            }

            messages.add(MessageModel.fromApi(json));
          } catch (_) {
            continue;
          }
        }

        return messages;
      }

      throw ServerException(message: 'Failed to fetch messages');
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        return [];
      }
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to fetch messages');
    } catch (e) {
      throw ServerException(message: 'Failed to fetch messages: $e');
    }
  }

  @override
  Future<List<UserDto>> getOnlineUsers() async {
    try {
      final response = await dio.get(ApiConstants.onlineUsers);

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((json) => UserDto.fromJson(json)).toList();
      }

      throw ServerException(message: 'Failed to fetch online users');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to fetch online users');
    }
  }

  @override
  Future<List<UserDto>> getOnlineUsersInConversation(int conversationId) async {
    try {
      final response = await dio.get(ApiConstants.onlineUsersInConversation(conversationId));

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((json) => UserDto.fromJson(json)).toList();
      }

      throw ServerException(message: 'Failed to fetch online users in conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to fetch online users in conversation');
    }
  }

  @override
  Future<UserStatusModel> getUserStatus(int userId) async {
    try {
      final response = await dio.get(ApiConstants.userStatus(userId));

      if (response.statusCode == 200) {
        final data = response.data['data'];
        return UserStatusModel.fromJson(data);
      }

      throw ServerException(message: 'Failed to fetch user status');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to fetch user status');
    }
  }

  @override
  Future<MessageModel> sendMessage(int conversationId, ChatMessageRequest request) async {
    try {
      final response = await dio.post(ApiConstants.messagesInConversation(conversationId), data: request.toJson());

      if (response.statusCode == 201) {
        final responseData = response.data['data'] as Map<String, dynamic>;
        return MessageModel.fromApi(responseData);
      }

      throw ServerException(message: 'Failed to send message');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to send message');
    }
  }

  @override
  Future<List<SearchUserModel>> searchUsers({required String query, int limit = 20}) async {
    try {
      final response = await dio.get(ApiConstants.searchUsers, queryParameters: {'query': query, 'limit': limit});

      if (response.statusCode == 200) {
        final paginatedData = response.data['data'] as Map<String, dynamic>;
        final data = paginatedData['items'] as List;

        return data.whereType<Map<String, dynamic>>().map((json) => SearchUserModel.fromJson(json)).toList();
      }

      throw ServerException(message: 'Failed to search users');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to search users');
    } catch (e) {
      throw ServerException(message: 'Failed to search users: $e');
    }
  }

  @override
  Future<List<ConversationModel>> searchConversations({required String query}) async {
    try {
      final response = await dio.get(ApiConstants.conversations, queryParameters: {'search': query});

      if (response.statusCode == 200) {
        final paginatedData = response.data['data'] as Map<String, dynamic>;
        final conversationsData = paginatedData['items'] as List;

        return conversationsData
            .whereType<Map<String, dynamic>>()
            .map((json) => ConversationModel.fromApi(json))
            .toList();
      }

      throw ServerException(message: 'Failed to search conversations');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to search conversations');
    } catch (e) {
      throw ServerException(message: 'Failed to search conversations: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> toggleReaction({required int messageId, required String emoji}) async {
    try {
      final response = await dio.post(ApiConstants.messageReactions(messageId), data: {'emoji': emoji});

      if (response.statusCode == 200) {
        return response.data['data'] as Map<String, dynamic>;
      }

      throw ServerException(message: 'Failed to toggle reaction');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to toggle reaction');
    } catch (e) {
      throw ServerException(message: 'Failed to toggle reaction: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getReactions(int messageId) async {
    try {
      final response = await dio.get(ApiConstants.messageReactions(messageId));

      if (response.statusCode == 200) {
        return response.data['data'] as Map<String, dynamic>;
      }

      throw ServerException(message: 'Failed to get reactions');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to get reactions');
    } catch (e) {
      throw ServerException(message: 'Failed to get reactions: $e');
    }
  }

  @override
  Future<MessageModel> editMessage({
    required int conversationId,
    required int messageId,
    required String content,
  }) async {
    try {
      final response = await dio.put(ApiConstants.messageEdit(conversationId, messageId), data: {'content': content});

      if (response.statusCode == 200) {
        if (response.data is! Map<String, dynamic>) {
          throw ServerException(message: 'Invalid response format from server');
        }

        final responseData = response.data as Map<String, dynamic>;

        if (responseData['data'] == null || responseData['data'] is! Map<String, dynamic>) {
          throw ServerException(message: 'Invalid data format in response');
        }

        final data = responseData['data'] as Map<String, dynamic>;
        return MessageModel.fromApi(data);
      }

      throw ServerException(message: 'Failed to edit message');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to edit message');
    } catch (e) {
      throw ServerException(message: 'Failed to edit message: $e');
    }
  }

  @override
  Future<void> deleteMessage({required int conversationId, required int messageId}) async {
    try {
      final response = await dio.delete(ApiConstants.messageDelete(conversationId, messageId));

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }

      throw ServerException(message: 'Failed to delete message');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to delete message');
    } catch (e) {
      throw ServerException(message: 'Failed to delete message: $e');
    }
  }

  @override
  Future<void> markConversationAsRead({required int conversationId, int? lastMessageId}) async {
    try {
      final queryParams = lastMessageId != null ? {'lastMessageId': lastMessageId.toString()} : null;

      final response = await dio.post(
        ApiConstants.markConversationAsRead(conversationId),
        queryParameters: queryParams,
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        return;
      }

      throw ServerException(message: 'Failed to mark conversation as read', statusCode: response.statusCode);
    } on DioException catch (e) {
      String errorMessage = 'Failed to mark conversation as read';
      if (e.response?.data != null && e.response!.data is Map) {
        errorMessage = e.response!.data['message'] ?? errorMessage;
      } else if (e.message != null) {
        errorMessage = e.message!;
      }

      throw ServerException(message: errorMessage, statusCode: e.response?.statusCode);
    } catch (e) {
      throw ServerException(message: 'Failed to mark conversation as read: $e');
    }
  }

  @override
  Future<void> markConversationAsUnread({required int conversationId}) async {
    try {
      final response = await dio.post(ApiConstants.markConversationAsUnread(conversationId));

      if (response.statusCode == 204 || response.statusCode == 200) {
        return;
      }

      throw ServerException(message: 'Failed to mark conversation as unread', statusCode: response.statusCode);
    } on DioException catch (e) {
      String errorMessage = 'Failed to mark conversation as unread';
      if (e.response?.data != null && e.response!.data is Map) {
        errorMessage = e.response!.data['message'] ?? errorMessage;
      } else if (e.message != null) {
        errorMessage = e.message!;
      }

      throw ServerException(message: errorMessage, statusCode: e.response?.statusCode);
    } catch (e) {
      throw ServerException(message: 'Failed to mark conversation as unread: $e');
    }
  }

  @override
  Future<ConversationModel> updateConversation({required int conversationId, String? name, String? description}) async {
    try {
      final response = await dio.put(
        ApiConstants.conversationById(conversationId),
        data: {if (name != null) 'name': name, if (description != null) 'description': description},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>;
        return ConversationModel.fromApi(data);
      }

      throw ServerException(message: 'Failed to update conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to update conversation');
    }
  }

  @override
  Future<void> deleteConversation(int conversationId) async {
    try {
      final response = await dio.delete(ApiConstants.conversationById(conversationId));

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }

      throw ServerException(message: 'Failed to delete conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to delete conversation');
    }
  }

  @override
  Future<Map<String, dynamic>> addMembers({required int conversationId, required List<int> userIds}) async {
    try {
      final response = await dio.post(ApiConstants.conversationMembers(conversationId), data: {'userIds': userIds});

      if (response.statusCode == 200) {
        return response.data['data'] as Map<String, dynamic>;
      }

      throw ServerException(message: 'Failed to add members');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to add members');
    }
  }

  @override
  Future<void> removeMember({required int conversationId, required int userId}) async {
    try {
      final response = await dio.delete(ApiConstants.removeMember(conversationId, userId));

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }

      throw ServerException(message: 'Failed to remove member');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to remove member');
    }
  }

  @override
  Future<Map<String, dynamic>> updateMemberRole({
    required int conversationId,
    required int userId,
    required String role,
  }) async {
    try {
      final response = await dio.put(
        ApiConstants.updateMemberRole(conversationId, userId),
        data: {'role': role},
      );

      if (response.statusCode == 200) {
        return response.data['data'] as Map<String, dynamic>;
      }

      throw ServerException(message: 'Failed to update member role');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to update member role');
    }
  }

  @override
  Future<void> leaveConversation(int conversationId) async {
    try {
      final response = await dio.post(ApiConstants.leaveConversation(conversationId));

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }

      throw ServerException(message: 'Failed to leave conversation');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to leave conversation');
    }
  }

  @override
  Future<ConversationModel> updateGroupAvatar({required int conversationId, required String imagePath}) async {
    try {
      final formData = FormData.fromMap({'avatar': await MultipartFile.fromFile(imagePath)});

      final response = await dio.put(ApiConstants.conversationAvatar(conversationId), data: formData);

      if (response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>;
        return ConversationModel.fromApi(data);
      }

      throw ServerException(message: 'Failed to update group avatar');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to update group avatar');
    }
  }

  @override
  Future<void> deleteGroupAvatar(int conversationId) async {
    try {
      final response = await dio.delete(ApiConstants.conversationAvatar(conversationId));

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }

      throw ServerException(message: 'Failed to delete group avatar');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to delete group avatar');
    }
  }

  @override
  Future<MessageModel> pinMessage({required int conversationId, required int messageId}) async {
    try {
      final response = await dio.post(ApiConstants.pinMessage(conversationId, messageId));

      if (response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>;
        return MessageModel.fromApi(data);
      }

      throw ServerException(message: 'Failed to pin message');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to pin message');
    }
  }

  @override
  Future<void> unpinMessage({required int conversationId, required int messageId}) async {
    try {
      final response = await dio.delete(ApiConstants.unpinMessage(conversationId, messageId));

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }

      throw ServerException(message: 'Failed to unpin message');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to unpin message');
    }
  }

  @override
  Future<List<MessageModel>> getPinnedMessages(int conversationId) async {
    try {
      final response = await dio.get(ApiConstants.pinnedMessages(conversationId));

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.whereType<Map<String, dynamic>>().map((json) => MessageModel.fromApi(json)).toList();
      }

      throw ServerException(message: 'Failed to get pinned messages');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to get pinned messages');
    }
  }

  @override
  Future<MessageModel> createScheduledMessage({
    required int conversationId,
    required String content,
    required String type,
    required String scheduledTime,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.scheduleMessage(conversationId),
        data: {'content': content, 'type': type, 'scheduledTime': scheduledTime},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'] as Map<String, dynamic>;
        return MessageModel.fromApi(data);
      }

      throw ServerException(message: 'Failed to create scheduled message');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to create scheduled message');
    }
  }

  @override
  Future<Map<String, dynamic>> getScheduledMessages({
    required int conversationId,
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.scheduledMessages(conversationId),
        queryParameters: {if (cursor != null) 'cursor': cursor, 'limit': limit},
      );

      if (response.statusCode == 200) {
        return response.data['data'] as Map<String, dynamic>;
      }

      throw ServerException(message: 'Failed to get scheduled messages');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to get scheduled messages');
    }
  }

  @override
  Future<MessageModel> getScheduledMessage({required int conversationId, required int scheduledMessageId}) async {
    try {
      final response = await dio.get(ApiConstants.scheduledMessageById(conversationId, scheduledMessageId));

      if (response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>;
        return MessageModel.fromApi(data);
      }

      throw ServerException(message: 'Failed to get scheduled message');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to get scheduled message');
    }
  }

  @override
  Future<MessageModel> updateScheduledMessage({
    required int conversationId,
    required int scheduledMessageId,
    String? content,
    String? scheduledTime,
  }) async {
    try {
      final response = await dio.put(
        ApiConstants.scheduledMessageById(conversationId, scheduledMessageId),
        data: {if (content != null) 'content': content, if (scheduledTime != null) 'scheduledTime': scheduledTime},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>;
        return MessageModel.fromApi(data);
      }

      throw ServerException(message: 'Failed to update scheduled message');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to update scheduled message');
    }
  }

  @override
  Future<void> cancelScheduledMessage({required int conversationId, required int scheduledMessageId}) async {
    try {
      final response = await dio.delete(ApiConstants.scheduledMessageById(conversationId, scheduledMessageId));

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }

      throw ServerException(message: 'Failed to cancel scheduled message');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to cancel scheduled message');
    }
  }

  @override
  Future<Map<String, dynamic>> cancelScheduledMessagesBulk({
    required int conversationId,
    required List<int> scheduledMessageIds,
  }) async {
    try {
      final response = await dio.delete(
        ApiConstants.cancelScheduledMessagesBulk(conversationId),
        data: {'scheduledMessageIds': scheduledMessageIds},
      );

      if (response.statusCode == 200) {
        return response.data['data'] as Map<String, dynamic>;
      }

      throw ServerException(message: 'Failed to cancel scheduled messages');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to cancel scheduled messages');
    }
  }

  @override
  Future<Map<String, dynamic>> searchMessages({
    required int conversationId,
    required String query,
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.searchMessages(conversationId),
        queryParameters: {'query': query, if (cursor != null) 'cursor': cursor, 'limit': limit},
      );

      if (response.statusCode == 200) {
        return response.data['data'] as Map<String, dynamic>;
      }

      throw ServerException(message: 'Failed to search messages');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to search messages');
    }
  }

  @override
  Future<Map<String, dynamic>> searchMedia({
    required int conversationId,
    String? type,
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.searchMedia(conversationId),
        queryParameters: {if (type != null) 'type': type, if (cursor != null) 'cursor': cursor, 'limit': limit},
      );

      if (response.statusCode == 200) {
        return response.data['data'] as Map<String, dynamic>;
      }

      throw ServerException(message: 'Failed to search media');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to search media');
    }
  }

  @override
  Future<Map<String, dynamic>> listEvents({
    required int conversationId,
    String status = 'all',
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.events(conversationId),
        queryParameters: {'status': status, if (cursor != null) 'cursor': cursor, 'limit': limit},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>;
        return data;
      }

      throw ServerException(message: 'Failed to list events');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to list events');
    }
  }

  @override
  Future<dynamic> getEventDetail({required int conversationId, required int messageId}) async {
    try {
      final response = await dio.get(ApiConstants.event(conversationId, messageId));

      if (response.statusCode == 200) {
        return response.data['data'];
      }

      throw ServerException(message: 'Failed to get event detail');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to get event detail');
    }
  }

  @override
  Future<Map<String, dynamic>> getEventRsvps({
    required int conversationId,
    required int messageId,
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.eventRsvps(conversationId, messageId),
        queryParameters: {if (cursor != null) 'cursor': cursor, 'limit': limit},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>;
        return data;
      }

      throw ServerException(message: 'Failed to get event RSVPs');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to get event RSVPs');
    }
  }

  @override
  Future<List<dynamic>> getEvents({required int conversationId}) async {
    try {
      final response = await dio.get(ApiConstants.events(conversationId));

      if (response.statusCode == 200) {
        final responseData = response.data['data'];

        final List<dynamic> events;
        if (responseData is Map<String, dynamic> && responseData.containsKey('items')) {
          events = responseData['items'] as List<dynamic>;
        } else if (responseData is List) {
          events = responseData;
        } else {
          throw ServerException(message: 'Unexpected response format for events');
        }

        return events;
      }

      throw ServerException(message: 'Failed to get events');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to get events');
    }
  }

  @override
  Future<dynamic> createEvent({
    required int conversationId,
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
  }) async {
    try {
      final startTimeUtc = startTime.toUtc().toIso8601String();
      final endTimeUtc = endTime.toUtc().toIso8601String();

      final requestData = {
        'title': title,
        if (description != null) 'description': description,
        'startTime': startTimeUtc,
        'endTime': endTimeUtc,
        if (location != null) 'location': location,
      };

      final response = await dio.post(ApiConstants.createEvent(conversationId), data: requestData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final messageData = response.data['data'] as Map<String, dynamic>;
        final metadata = messageData['metadata'] as Map<String, dynamic>?;

        if (metadata != null && metadata['event'] != null) {
          final eventJson = metadata['event'] as Map<String, dynamic>;

          final going = (eventJson['going'] as List?)?.cast<int>() ?? [];
          final maybe = (eventJson['maybe'] as List?)?.cast<int>() ?? [];
          final notGoing = (eventJson['notGoing'] as List?)?.cast<int>() ?? [];

          final sender = messageData['sender'] as Map<String, dynamic>?;
          final createdBy = sender?['id'] ?? 0;

          return {
            'id': messageData['id'],
            'conversationId': messageData['conversationId'],
            'title': eventJson['title'],
            'description': eventJson['description'],
            'startTime': eventJson['startTime'],
            'endTime': eventJson['endTime'],
            'location': eventJson['location'],
            'going': going,
            'maybe': maybe,
            'notGoing': notGoing,
            'createdBy': createdBy,
            'createdAt': messageData['createdAt'],
          };
        }

        throw ServerException(message: 'Event data not found in response metadata');
      }

      throw ServerException(message: 'Failed to create event - Status: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.response?.data is Map && e.response?.data['message'] != null) {
        throw ServerException(message: e.response!.data['message']);
      } else {
        throw ServerException(message: 'Failed to create event: ${e.message ?? "Unknown error"}');
      }
    } catch (e) {
      throw ServerException(message: 'Failed to create event: $e');
    }
  }

  @override
  Future<dynamic> updateEvent({
    required int conversationId,
    required int eventId,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
  }) async {
    try {
      final response = await dio.put(
        ApiConstants.event(conversationId, eventId),
        data: {
          if (title != null) 'title': title,
          if (description != null) 'description': description,
          if (startTime != null) 'startTime': startTime.toIso8601String(),
          if (endTime != null) 'endTime': endTime.toIso8601String(),
          if (location != null) 'location': location,
        },
      );

      if (response.statusCode == 200) {
        return response.data['data'];
      }

      throw ServerException(message: 'Failed to update event');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to update event');
    }
  }

  @override
  Future<dynamic> rsvpEvent({required int conversationId, required int eventId, required String status}) async {
    try {
      final response = await dio.post(ApiConstants.rsvpEvent(conversationId, eventId), data: {'status': status});

      if (response.statusCode == 200) {
        final messageData = response.data['data'] as Map<String, dynamic>;
        final metadata = messageData['metadata'] as Map<String, dynamic>?;

        if (metadata != null && metadata['event'] != null) {
          final eventJson = metadata['event'] as Map<String, dynamic>;

          final going = (eventJson['going'] as List?)?.cast<int>() ?? [];
          final maybe = (eventJson['maybe'] as List?)?.cast<int>() ?? [];
          final notGoing = (eventJson['notGoing'] as List?)?.cast<int>() ?? [];

          final sender = messageData['sender'] as Map<String, dynamic>?;
          final createdBy = sender?['id'] ?? 0;

          return {
            'id': messageData['id'],
            'conversationId': messageData['conversationId'],
            'title': eventJson['title'],
            'description': eventJson['description'],
            'startTime': eventJson['startTime'],
            'endTime': eventJson['endTime'],
            'location': eventJson['location'],
            'going': going,
            'maybe': maybe,
            'notGoing': notGoing,
            'createdBy': createdBy,
            'createdAt': messageData['createdAt'],
          };
        }

        throw ServerException(message: 'Event data not found in RSVP response metadata');
      }

      throw ServerException(message: 'Failed to RSVP to event');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to RSVP to event');
    }
  }

  @override
  Future<void> deleteEvent({required int conversationId, required int eventId}) async {
    try {
      final response = await dio.delete(ApiConstants.event(conversationId, eventId));

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }

      throw ServerException(message: 'Failed to delete event');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to delete event');
    }
  }

  @override
  Future<List<MessageModel>> forwardMessage({
    required int conversationId,
    required int messageId,
    required List<int> targetConversationIds,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.forwardMessage(conversationId, messageId),
        data: {'conversationIds': targetConversationIds},
      );

      if (response.statusCode == 201 && response.data['success'] == true) {
        final List<dynamic> messagesJson = response.data['data'] as List<dynamic>;
        return messagesJson.map((json) => MessageModel.fromJson(json as Map<String, dynamic>)).toList();
      }

      throw ServerException(message: response.data['message'] ?? 'Failed to forward message');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to forward message');
    }
  }
}