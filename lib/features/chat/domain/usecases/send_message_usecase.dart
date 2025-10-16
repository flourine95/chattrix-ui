import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class SendMessageUsecase {
  final ChatRepository repository;

  SendMessageUsecase(this.repository);

  Future<Either<Failure, Message>> call({
    required String conversationId,
    required String content,
  }) {
    return repository.sendMessage(
      conversationId: conversationId,
      content: content,
    );
  }
}
