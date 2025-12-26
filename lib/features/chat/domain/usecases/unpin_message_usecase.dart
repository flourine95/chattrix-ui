import 'package:chattrix_ui/features/chat/domain/datasources/chat_remote_datasource.dart';

/// Use case for unpinning a message
class UnpinMessageUsecase {
  final ChatRemoteDatasource _datasource;

  UnpinMessageUsecase(this._datasource);

  Future<void> call({required String conversationId, required String messageId}) async {
    await _datasource.unpinMessage(conversationId: conversationId, messageId: messageId);
  }
}
