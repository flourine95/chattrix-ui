import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetConversationUsecase {
  final ChatRepository repository;

  GetConversationUsecase(this.repository);

  Future<Either<Failure, Conversation>> call(String conversationId) {
    return repository.getConversation(conversationId);
  }
}
