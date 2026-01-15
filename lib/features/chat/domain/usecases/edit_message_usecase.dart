import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class EditMessageUsecase {
  final ChatRepository repository;

  EditMessageUsecase({required this.repository});

  Future<Either<Failure, Message>> call({
    required int conversationId,
    required int messageId,
    required String content,
  }) async {
    return await repository.editMessage(conversationId: conversationId, messageId: messageId, content: content);
  }
}
