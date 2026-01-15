import 'package:chattrix_ui/features/chat/domain/datasources/chat_remote_datasource.dart';

class UnpinMessageUsecase {
  final ChatRemoteDatasource _datasource;

  UnpinMessageUsecase(this._datasource);

  Future<void> call({required int conversationId, required int messageId}) async {
    await _datasource.unpinMessage(conversationId: conversationId, messageId: messageId);
  }
}
