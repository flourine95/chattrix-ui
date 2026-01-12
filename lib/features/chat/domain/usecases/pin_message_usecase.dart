import 'package:chattrix_ui/features/chat/domain/datasources/chat_remote_datasource.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';

/// Use case for pinning a message
class PinMessageUsecase {
  final ChatRemoteDatasource _datasource;

  PinMessageUsecase(this._datasource);

  Future<Message> call({required String conversationId, required String messageId}) async {
    final messageModel = await _datasource.pinMessage(conversationId: conversationId, messageId: messageId);

    return messageModel.toEntity();
  }
}
