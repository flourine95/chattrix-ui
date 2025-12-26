import 'package:chattrix_ui/features/chat/domain/datasources/chat_remote_datasource.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';

/// Use case for getting pinned messages in a conversation
class GetPinnedMessagesUsecase {
  final ChatRemoteDatasource _datasource;

  GetPinnedMessagesUsecase(this._datasource);

  Future<List<Message>> call(String conversationId) async {
    final messageModels = await _datasource.getPinnedMessages(conversationId);

    return messageModels.map((model) => model.toEntity()).toList();
  }
}
