import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteMessageUsecase {
  final ChatRepository repository;

  DeleteMessageUsecase({required this.repository});

  Future<Either<Failure, void>> call({required String conversationId, required String messageId}) async {
    return await repository.deleteMessage(conversationId: conversationId, messageId: messageId);
  }
}
