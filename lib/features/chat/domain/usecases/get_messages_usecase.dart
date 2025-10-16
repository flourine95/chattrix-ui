import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class GetMessagesUsecase {
  final ChatRepository repository;

  GetMessagesUsecase(this.repository);

  Future<Either<Failure, List<Message>>> call({
    required String conversationId,
    int page = 0,
    int size = 50,
  }) {
    return repository.getMessages(
      conversationId: conversationId,
      page: page,
      size: size,
    );
  }
}
