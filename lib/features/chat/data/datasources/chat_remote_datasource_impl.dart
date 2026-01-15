import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/domain/enums/conversation_filter.dart';
import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:chattrix_ui/features/auth/data/models/user_dto.dart';
import 'package:chattrix_ui/features/chat/data/models/chat_message_request.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_member_dto.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_model.dart';
import 'package:chattrix_ui/features/chat/data/models/message_model.dart';
import 'package:chattrix_ui/features/chat/data/models/search_user_model.dart';
import 'package:chattrix_ui/features/chat/data/models/user_status_model.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/chat_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
      AppLogger.debug('📡 Fetching conversations from API with filter: $filter', tag: 'ChatRemoteDataSource');

      // Map filter enum to API query parameter
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
          // For hidden filter, we still fetch all conversations
          // Frontend will filter them in ConversationsNotifier
          filterParam = 'all';
          break;
      }

      final response = await dio.get(ApiConstants.conversations, queryParameters: {'filter': filterParam});

      AppLogger.debug('📥 Conversations API Response - Status: ${response.statusCode}', tag: 'ChatRemoteDataSource');

      if (response.statusCode == 200) {
        // API returns cursor-based paginated response: { success, message, data: { items: [...], meta: { nextCursor, hasNextPage, itemsPerPage } } }
        final paginatedData = response.data['data'] as Map<String, dynamic>;
        final conversationsData = paginatedData['items'] as List;

        AppLogger.info('✅ Successfully fetched ${conversationsData.length} conversations', tag: 'ChatRemoteDataSource');

        // Debug: Log first conversation to check settings field
        // if (conversationsData.isNotEmpty) {
        //   final firstConv = conversationsData.first as Map<String, dynamic>;
        //   debugPrint('🔍 [API Response] First conversation keys: ${firstConv.keys.toList()}');
        //   debugPrint('🔍 [API Response] Has settings field: ${firstConv.containsKey('settings')}');
        //   if (firstConv.containsKey('settings')) {
        //     debugPrint('🔍 [API Response] Settings value: ${firstConv['settings']}');
        //   }
        // }

        return conversationsData
            .whereType<Map<String, dynamic>>()
            .map((json) => ConversationModel.fromApi(json))
            .toList();
      }

      throw ServerException(message: 'Failed to fetch conversations');
    } on ApiException {
      // ✅ Re-throw ApiException from interceptor (don't convert to ServerException)
      rethrow;
    } on DioException catch (e) {
      // ✅ Check if DioException wraps an ApiException
      if (e.error is ApiException) {
        rethrow; // Re-throw the wrapped ApiException
      }

      AppLogger.error('❌ Failed to fetch conversations - DioException', error: e, tag: 'ChatRemoteDataSource');
      AppLogger.debug(
        'Status Code: ${e.response?.statusCode}, Message: ${e.response?.data}',
        tag: 'ChatRemoteDataSource',
      );
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to fetch conversations');
    } catch (e) {
      AppLogger.error('❌ Failed to fetch conversations - Unexpected error', error: e, tag: 'ChatRemoteDataSource');
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
        // API returns cursor-based pagination: { success, message, data: { items: [...], meta: {...} } }
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
      final url = ApiConstants.messagesInConversation(conversationId);

      final response = await dio.get(url, queryParameters: {'page': page, 'size': size, 'sort': sort});

      if (response.statusCode == 200) {
        // API returns cursor-based paginated response: { success, message, data: { items: [...], meta: {...} } }
        final paginatedData = response.data['data'] as Map<String, dynamic>;
        final data = paginatedData['items'] as List;

        // Parse messages
        final messages = <MessageModel>[];
        for (var json in data.whereType<Map<String, dynamic>>()) {
          try {
            // Check if this is a POLL message without poll data
            if (json['type'] == 'POLL' && json['pollId'] != null && !json.containsKey('poll')) {
              debugPrint('🗳️ [ChatRemoteDataSource] POLL message ${json['id']} missing poll data, fetching...');

              try {
                // Fetch poll details
                final pollResponse = await dio.get('/v1/conversations/$conversationId/polls/${json['pollId']}');
                if (pollResponse.statusCode == 200) {
                  final pollData = pollResponse.data['data'] as Map<String, dynamic>;
                  // Add poll data to message JSON
                  json['poll'] = pollData;
                  debugPrint(
                    '🗳️ [ChatRemoteDataSource] Successfully fetched poll ${json['pollId']} for message ${json['id']}',
                  );
                }
              } catch (e) {
                debugPrint('⚠️ [ChatRemoteDataSource] Failed to fetch poll ${json['pollId']}: $e');
                // Continue without poll data - will show "not available" in UI
              }
            }

            messages.add(MessageModel.fromApi(json));
          } catch (e, stackTrace) {
            debugPrint('❌ [ChatRemoteDataSource] Failed to parse message ${json['id']}: $e');
            debugPrint('📋 [ChatRemoteDataSource] Message JSON: $json');
            debugPrint('📋 [ChatRemoteDataSource] Stack trace: $stackTrace');
            // Skip this message and continue with others
            continue;
          }
        }

        return messages;
      }

      throw ServerException(message: 'Failed to fetch messages');
    } on DioException catch (e) {
      // If 500 error, return empty list instead of throwing
      // This allows the app to continue working while backend is being fixed
      if (e.response?.statusCode == 500) {
        return []; // Return empty list instead of crashing
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
      final url = ApiConstants.messagesInConversation(conversationId);

      final response = await dio.post(url, data: request.toJson());

      if (response.statusCode == 201) {
        final responseData = response.data['data'] as Map<String, dynamic>;
        return MessageModel.fromApi(responseData);
      }

      throw ServerException(message: 'Failed to send message');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to send message');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SearchUserModel>> searchUsers({required String query, int limit = 20}) async {
    try {
      final url = ApiConstants.searchUsers;

      debugPrint('🔍 [SearchUsers] Searching users with query: "$query", limit: $limit');
      debugPrint('🔍 [SearchUsers] URL: $url');

      final response = await dio.get(url, queryParameters: {'query': query, 'limit': limit});

      debugPrint('🔍 [SearchUsers] Response status: ${response.statusCode}');
      debugPrint('🔍 [SearchUsers] Response data: ${response.data}');

      if (response.statusCode == 200) {
        // API returns cursor-based paginated response: { success, message, data: { items: [...], meta: {...} } }
        final paginatedData = response.data['data'] as Map<String, dynamic>;
        final data = paginatedData['items'] as List;

        debugPrint('🔍 [SearchUsers] Found ${data.length} users');

        return data.whereType<Map<String, dynamic>>().map((json) => SearchUserModel.fromJson(json)).toList();
      }

      throw ServerException(message: 'Failed to search users');
    } on DioException catch (e) {
      debugPrint('❌ [SearchUsers] DioException: ${e.message}');
      debugPrint('❌ [SearchUsers] Response: ${e.response?.data}');
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to search users');
    } catch (e) {
      debugPrint('❌ [SearchUsers] Exception: $e');
      throw ServerException(message: 'Failed to search users: $e');
    }
  }

  @override
  Future<List<ConversationModel>> searchConversations({required String query}) async {
    try {
      AppLogger.debug('🔍 Searching conversations with query: $query', tag: 'ChatRemoteDataSource');

      final response = await dio.get(ApiConstants.conversations, queryParameters: {'search': query});

      AppLogger.debug('📥 Search API Response - Status: ${response.statusCode}', tag: 'ChatRemoteDataSource');

      if (response.statusCode == 200) {
        // API returns cursor-based paginated response: { success, message, data: { items: [...], meta: { nextCursor, hasNextPage, itemsPerPage } } }
        final paginatedData = response.data['data'] as Map<String, dynamic>;
        final conversationsData = paginatedData['items'] as List;

        AppLogger.info('✅ Found ${conversationsData.length} conversations matching query', tag: 'ChatRemoteDataSource');

        return conversationsData
            .whereType<Map<String, dynamic>>()
            .map((json) => ConversationModel.fromApi(json))
            .toList();
      }

      throw ServerException(message: 'Failed to search conversations');
    } on DioException catch (e) {
      AppLogger.error('❌ Failed to search conversations - DioException', error: e, tag: 'ChatRemoteDataSource');
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to search conversations');
    } catch (e) {
      AppLogger.error('❌ Failed to search conversations - Unexpected error', error: e, tag: 'ChatRemoteDataSource');
      throw ServerException(message: 'Failed to search conversations: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> toggleReaction({required int messageId, required String emoji}) async {
    try {
      final url = ApiConstants.messageReactions(messageId);

      final response = await dio.post(url, data: {'emoji': emoji});

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
      final url = ApiConstants.messageReactions(messageId);

      final response = await dio.get(url);

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
      final url = ApiConstants.messageEdit(conversationId, messageId);

      final response = await dio.put(url, data: {'content': content});

      if (response.statusCode == 200) {
        // Check if response.data is a Map
        if (response.data is! Map<String, dynamic>) {
          throw ServerException(message: 'Invalid response format from server');
        }

        final responseData = response.data as Map<String, dynamic>;

        // Check if 'data' field exists and is a Map
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
      final url = ApiConstants.messageDelete(conversationId, messageId);

      final response = await dio.delete(url);

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
      AppLogger.debug(
        '📡 Marking conversation $conversationId as read${lastMessageId != null ? ' up to message $lastMessageId' : ''}',
        tag: 'ChatRemoteDataSource',
      );

      final url = ApiConstants.markConversationAsRead(conversationId);
      final queryParams = lastMessageId != null ? {'lastMessageId': lastMessageId.toString()} : null;

      AppLogger.debug('📡 Request URL: $url', tag: 'ChatRemoteDataSource');

      final response = await dio.post(url, queryParameters: queryParams);

      AppLogger.debug(
        '📥 Mark as read response - Status: ${response.statusCode}, Data: ${response.data}',
        tag: 'ChatRemoteDataSource',
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        AppLogger.info('✅ Successfully marked conversation $conversationId as read', tag: 'ChatRemoteDataSource');
        return;
      }

      throw ServerException(message: 'Failed to mark conversation as read', statusCode: response.statusCode);
    } on DioException catch (e) {
      AppLogger.error(
        '❌ DioException - Status: ${e.response?.statusCode}, Data: ${e.response?.data}, Message: ${e.message}',
        tag: 'ChatRemoteDataSource',
      );

      // Handle null response data safely
      String errorMessage = 'Failed to mark conversation as read';
      if (e.response?.data != null && e.response!.data is Map) {
        errorMessage = e.response!.data['message'] ?? errorMessage;
      } else if (e.message != null) {
        errorMessage = e.message!;
      }

      throw ServerException(message: errorMessage, statusCode: e.response?.statusCode);
    } catch (e) {
      AppLogger.error('❌ Unexpected error: $e', tag: 'ChatRemoteDataSource');
      throw ServerException(message: 'Failed to mark conversation as read: $e');
    }
  }

  @override
  Future<void> markConversationAsUnread({required int conversationId}) async {
    try {
      AppLogger.debug('📡 Marking conversation $conversationId as unread', tag: 'ChatRemoteDataSource');

      final url = ApiConstants.markConversationAsUnread(conversationId);

      AppLogger.debug('📡 Request URL: $url', tag: 'ChatRemoteDataSource');

      final response = await dio.post(url);

      AppLogger.debug(
        '📥 Mark as unread response - Status: ${response.statusCode}, Data: ${response.data}',
        tag: 'ChatRemoteDataSource',
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        AppLogger.info('✅ Successfully marked conversation $conversationId as unread', tag: 'ChatRemoteDataSource');
        return;
      }

      throw ServerException(message: 'Failed to mark conversation as unread', statusCode: response.statusCode);
    } on DioException catch (e) {
      AppLogger.error(
        '❌ DioException - Status: ${e.response?.statusCode}, Data: ${e.response?.data}, Message: ${e.message}',
        tag: 'ChatRemoteDataSource',
      );

      // Handle null response data safely
      String errorMessage = 'Failed to mark conversation as unread';
      if (e.response?.data != null && e.response!.data is Map) {
        errorMessage = e.response!.data['message'] ?? errorMessage;
      } else if (e.message != null) {
        errorMessage = e.message!;
      }

      throw ServerException(message: errorMessage, statusCode: e.response?.statusCode);
    } catch (e) {
      AppLogger.error('❌ Unexpected error: $e', tag: 'ChatRemoteDataSource');
      throw ServerException(message: 'Failed to mark conversation as unread: $e');
    }
  }

  @override
  Future<ConversationModel> updateConversation({
    required int conversationId,
    String? name,
    String? description,
  }) async {
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
      final response = await dio.post(
        ApiConstants.conversationMembers(conversationId),
        data: {'userIds': userIds},
      );

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
      final response = await dio.delete('${ApiConstants.conversationMembers(conversationId)}/$userId');

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
        '${ApiConstants.conversationMembers(conversationId)}/$userId/role',
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
      final response = await dio.post('${ApiConstants.conversationMembers(conversationId)}/leave');

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

      final response = await dio.put(
        '${ApiConstants.conversationById(conversationId)}/avatar',
        data: formData,
      );

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
      final response = await dio.delete('${ApiConstants.conversationById(conversationId)}/avatar');

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
      final response = await dio.post('/v1/conversations/$conversationId/messages/$messageId/pin');

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
      final response = await dio.delete('/v1/conversations/$conversationId/messages/$messageId/pin');

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
      final response = await dio.get('/v1/conversations/$conversationId/messages/pinned');

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
        '/v1/conversations/$conversationId/messages/schedule',
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
        '/v1/conversations/$conversationId/messages/scheduled',
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
      final response = await dio.get('/v1/conversations/$conversationId/messages/scheduled/$scheduledMessageId');

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
        '/v1/conversations/$conversationId/messages/scheduled/$scheduledMessageId',
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
      final response = await dio.delete('/v1/conversations/$conversationId/messages/scheduled/$scheduledMessageId');

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
        '/v1/conversations/$conversationId/messages/scheduled/bulk',
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
        '/v1/conversations/$conversationId/search/messages',
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
        '/v1/conversations/$conversationId/search/media',
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

  // ============================================================================
  // EVENTS
  // ============================================================================

  @override
  Future<List<dynamic>> getEvents({required int conversationId}) async {
    try {
      AppLogger.debug('📡 Getting events for conversation $conversationId', tag: 'ChatRemoteDataSource');

      final response = await dio.get(ApiConstants.events(conversationId));

      AppLogger.debug('📥 Get events response - Status: ${response.statusCode}', tag: 'ChatRemoteDataSource');

      if (response.statusCode == 200) {
        // API returns paginated response: { success, message, data: { items: [...], meta: {...} } }
        final responseData = response.data['data'];

        // Handle both paginated and direct array responses for backward compatibility
        final List<dynamic> events;
        if (responseData is Map<String, dynamic> && responseData.containsKey('items')) {
          // Paginated response
          events = responseData['items'] as List<dynamic>;
        } else if (responseData is List) {
          // Direct array response (legacy)
          events = responseData;
        } else {
          throw ServerException(message: 'Unexpected response format for events');
        }

        AppLogger.info('✅ Successfully retrieved ${events.length} events', tag: 'ChatRemoteDataSource');
        return events;
      }

      throw ServerException(message: 'Failed to get events');
    } on DioException catch (e) {
      AppLogger.error('❌ Failed to get events: ${e.message}', tag: 'ChatRemoteDataSource');
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
      final requestData = {
        'title': title,
        if (description != null) 'description': description,
        'startTime': startTime.millisecondsSinceEpoch,
        'endTime': endTime.millisecondsSinceEpoch,
        if (location != null) 'location': location,
      };

      AppLogger.debug('📡 Creating event in conversation $conversationId', tag: 'ChatRemoteDataSource');
      AppLogger.debug('📤 Request data: $requestData', tag: 'ChatRemoteDataSource');

      final response = await dio.post(ApiConstants.events(conversationId), data: requestData);

      AppLogger.debug('📥 Create event response - Status: ${response.statusCode}', tag: 'ChatRemoteDataSource');
      AppLogger.debug('📥 Create event response data: ${response.data}', tag: 'ChatRemoteDataSource');

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppLogger.info('✅ Successfully created event', tag: 'ChatRemoteDataSource');
        return response.data['data'];
      }

      throw ServerException(message: 'Failed to create event - Status: ${response.statusCode}');
    } on DioException catch (e) {
      AppLogger.error('❌ Failed to create event: ${e.message}', tag: 'ChatRemoteDataSource');
      AppLogger.error('❌ Response status: ${e.response?.statusCode}', tag: 'ChatRemoteDataSource');
      AppLogger.error('❌ Response data: ${e.response?.data}', tag: 'ChatRemoteDataSource');
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to create event');
    } catch (e) {
      AppLogger.error('❌ Unexpected error creating event: $e', tag: 'ChatRemoteDataSource');
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
      AppLogger.debug('📡 Updating event $eventId', tag: 'ChatRemoteDataSource');

      final response = await dio.put(
        ApiConstants.event(conversationId, eventId),
        data: {
          if (title != null) 'title': title,
          if (description != null) 'description': description,
          if (startTime != null) 'startTime': startTime.millisecondsSinceEpoch,
          if (endTime != null) 'endTime': endTime.millisecondsSinceEpoch,
          if (location != null) 'location': location,
        },
      );

      AppLogger.debug('📥 Update event response - Status: ${response.statusCode}', tag: 'ChatRemoteDataSource');

      if (response.statusCode == 200) {
        AppLogger.info('✅ Successfully updated event', tag: 'ChatRemoteDataSource');
        return response.data['data'];
      }

      throw ServerException(message: 'Failed to update event');
    } on DioException catch (e) {
      AppLogger.error('❌ Failed to update event: ${e.message}', tag: 'ChatRemoteDataSource');
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to update event');
    }
  }

  @override
  Future<dynamic> rsvpEvent({required int conversationId, required int eventId, required String status}) async {
    try {
      AppLogger.debug('📡 RSVP to event $eventId with status $status', tag: 'ChatRemoteDataSource');

      final response = await dio.post(
        ApiConstants.eventRsvp(conversationId, eventId),
        data: {'status': status},
      );

      AppLogger.debug('📥 RSVP event response - Status: ${response.statusCode}', tag: 'ChatRemoteDataSource');

      if (response.statusCode == 200) {
        AppLogger.info('✅ Successfully RSVP to event', tag: 'ChatRemoteDataSource');
        return response.data['data'];
      }

      throw ServerException(message: 'Failed to RSVP to event');
    } on DioException catch (e) {
      AppLogger.error('❌ Failed to RSVP to event: ${e.message}', tag: 'ChatRemoteDataSource');
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to RSVP to event');
    }
  }

  @override
  Future<void> deleteEvent({required int conversationId, required int eventId}) async {
    try {
      AppLogger.debug('📡 Deleting event $eventId', tag: 'ChatRemoteDataSource');

      final response = await dio.delete(ApiConstants.event(conversationId, eventId));

      AppLogger.debug('📥 Delete event response - Status: ${response.statusCode}', tag: 'ChatRemoteDataSource');

      if (response.statusCode == 200 || response.statusCode == 204) {
        AppLogger.info('✅ Successfully deleted event', tag: 'ChatRemoteDataSource');
        return;
      }

      throw ServerException(message: 'Failed to delete event');
    } on DioException catch (e) {
      AppLogger.error('❌ Failed to delete event: ${e.message}', tag: 'ChatRemoteDataSource');
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
      AppLogger.debug(
        '📤 Forwarding message $messageId to ${targetConversationIds.length} conversations',
        tag: 'ChatRemoteDataSource',
      );

      final response = await dio.post(
        '/v1/conversations/$conversationId/messages/$messageId/forward',
        data: {'conversationIds': targetConversationIds},
      );

      AppLogger.debug('📥 Forward message response - Status: ${response.statusCode}', tag: 'ChatRemoteDataSource');

      if (response.statusCode == 201 && response.data['success'] == true) {
        final List<dynamic> messagesJson = response.data['data'] as List<dynamic>;
        final messages = messagesJson.map((json) => MessageModel.fromJson(json as Map<String, dynamic>)).toList();

        AppLogger.info(
          '✅ Successfully forwarded message to ${messages.length} conversations',
          tag: 'ChatRemoteDataSource',
        );
        return messages;
      }

      throw ServerException(message: response.data['message'] ?? 'Failed to forward message');
    } on DioException catch (e) {
      AppLogger.error('❌ Failed to forward message: ${e.message}', tag: 'ChatRemoteDataSource');
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to forward message');
    }
  }
}
