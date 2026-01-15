import 'package:chattrix_ui/core/domain/enums/conversation_filter.dart';
import 'package:chattrix_ui/features/auth/data/models/user_dto.dart';
import 'package:chattrix_ui/features/chat/data/models/chat_message_request.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_member_dto.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_model.dart';
import 'package:chattrix_ui/features/chat/data/models/message_model.dart';
import 'package:chattrix_ui/features/chat/data/models/search_user_model.dart';
import 'package:chattrix_ui/features/chat/data/models/user_status_model.dart';

abstract class ChatRemoteDatasource {
  Future<ConversationModel> createConversation({String? name, required String type, required List<int> participantIds});

  Future<List<ConversationModel>> getConversations({ConversationFilter filter = ConversationFilter.all});

  Future<ConversationModel> getConversation(int conversationId);

  Future<List<ConversationMemberDto>> getConversationMembers({
    required int conversationId,
    String? cursor,
    int limit = 20,
  });

  Future<List<MessageModel>> getMessages({
    required int conversationId,
    int page = 0,
    int size = 50,
    String sort = 'DESC',
  });

  Future<MessageModel> sendMessage(int conversationId, ChatMessageRequest request);

  Future<List<UserDto>> getOnlineUsers();

  Future<List<UserDto>> getOnlineUsersInConversation(int conversationId);

  Future<UserStatusModel> getUserStatus(int userId);

  Future<List<SearchUserModel>> searchUsers({required String query, int limit = 20});

  Future<List<ConversationModel>> searchConversations({required String query});

  Future<Map<String, dynamic>> toggleReaction({required int messageId, required String emoji});

  Future<Map<String, dynamic>> getReactions(int messageId);

  Future<MessageModel> editMessage({required int conversationId, required int messageId, required String content});

  Future<void> deleteMessage({required int conversationId, required int messageId});

  Future<void> markConversationAsRead({required int conversationId, int? lastMessageId});

  Future<void> markConversationAsUnread({required int conversationId});

  Future<ConversationModel> updateConversation({required int conversationId, String? name, String? description});

  Future<void> deleteConversation(int conversationId);

  Future<Map<String, dynamic>> addMembers({required int conversationId, required List<int> userIds});

  Future<void> removeMember({required int conversationId, required int userId});

  Future<Map<String, dynamic>> updateMemberRole({
    required int conversationId,
    required int userId,
    required String role,
  });

  Future<void> leaveConversation(int conversationId);

  Future<ConversationModel> updateGroupAvatar({required int conversationId, required String imagePath});

  Future<void> deleteGroupAvatar(int conversationId);

  Future<MessageModel> pinMessage({required int conversationId, required int messageId});

  Future<void> unpinMessage({required int conversationId, required int messageId});

  Future<List<MessageModel>> getPinnedMessages(int conversationId);

  Future<MessageModel> createScheduledMessage({
    required int conversationId,
    required String content,
    required String type,
    required String scheduledTime,
  });

  Future<Map<String, dynamic>> getScheduledMessages({required int conversationId, String? cursor, int limit = 20});

  Future<MessageModel> getScheduledMessage({required int conversationId, required int scheduledMessageId});

  Future<MessageModel> updateScheduledMessage({
    required int conversationId,
    required int scheduledMessageId,
    String? content,
    String? scheduledTime,
  });

  Future<void> cancelScheduledMessage({required int conversationId, required int scheduledMessageId});

  Future<Map<String, dynamic>> cancelScheduledMessagesBulk({
    required int conversationId,
    required List<int> scheduledMessageIds,
  });

  Future<Map<String, dynamic>> searchMessages({
    required int conversationId,
    required String query,
    String? cursor,
    int limit = 20,
  });

  Future<Map<String, dynamic>> searchMedia({required int conversationId, String? type, String? cursor, int limit = 20});

  // Events - List with filters and pagination
  Future<Map<String, dynamic>> listEvents({
    required int conversationId,
    String status = 'all',
    String? cursor,
    int limit = 20,
  });

  Future<dynamic> getEventDetail({required int conversationId, required int messageId});

  Future<Map<String, dynamic>> getEventRsvps({
    required int conversationId,
    required int messageId,
    String? cursor,
    int limit = 20,
  });

  // Events - Legacy methods
  Future<List<dynamic>> getEvents({required int conversationId});

  Future<dynamic> createEvent({
    required int conversationId,
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
  });

  Future<dynamic> updateEvent({
    required int conversationId,
    required int eventId,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
  });

  Future<dynamic> rsvpEvent({required int conversationId, required int eventId, required String status});

  Future<void> deleteEvent({required int conversationId, required int eventId});

  Future<List<MessageModel>> forwardMessage({
    required int conversationId,
    required int messageId,
    required List<int> targetConversationIds,
  });
}
