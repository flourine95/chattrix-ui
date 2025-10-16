import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class CreateConversationUsecase {
  final ChatRepository repository;

  CreateConversationUsecase(this.repository);

  Future<Either<Failure, Conversation>> call({
    String? name,
    required String type,
    required List<String> participantIds,
  }) {
    return repository.createConversation(
      name: name,
      type: type,
      participantIds: participantIds,
    );
  }
}
