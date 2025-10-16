import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class GetConversationsUsecase {
  final ChatRepository repository;

  GetConversationsUsecase(this.repository);

  Future<Either<Failure, List<Conversation>>> call() {
    return repository.getConversations();
  }
}
