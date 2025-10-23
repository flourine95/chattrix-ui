import 'package:chattrix_ui/features/auth/data/models/user_model.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_model.dart';
import 'package:chattrix_ui/features/chat/data/models/message_model.dart';
import 'package:chattrix_ui/features/chat/data/models/search_user_model.dart';
import 'package:chattrix_ui/features/chat/data/models/user_status_model.dart';

abstract class ChatRemoteDatasource {
  Future<ConversationModel> createConversation({
    String? name,
    required String type,
    required List<String> participantIds,
  });

  Future<List<ConversationModel>> getConversations();

  Future<ConversationModel> getConversation(String conversationId);

  Future<List<MessageModel>> getMessages({
    required String conversationId,
    int page = 0,
    int size = 50,
  });

  Future<MessageModel> sendMessage({
    required String conversationId,
    required String content,
  });

  Future<List<UserModel>> getOnlineUsers();

  Future<List<UserModel>> getOnlineUsersInConversation(String conversationId);

  Future<UserStatusModel> getUserStatus(String userId);

  Future<List<SearchUserModel>> searchUsers({
    required String query,
    int limit = 20,
  });
}
