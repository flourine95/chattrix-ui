import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class ForwardMessageUsecase {
  final ChatRepository _repository;

  ForwardMessageUsecase(this._repository);

  Future<Either<Failure, List<Message>>> call({
    required int conversationId,
    required int messageId,
    required List<int> targetConversationIds,
  }) async {
    if (targetConversationIds.isEmpty) {
      return left(const Failure.validation(message: 'At least one conversation ID is required', code: 'INVALID_INPUT'));
    }

    return await _repository.forwardMessage(
      conversationId: conversationId,
      messageId: messageId,
      targetConversationIds: targetConversationIds,
    );
  }
}
