import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class EditMessageUsecase {
  final ChatRepository repository;

  EditMessageUsecase({required this.repository});

  Future<Either<Failure, Message>> call({
    required String messageId,
    required String content,
  }) async {
    return await repository.editMessage(
      messageId: messageId,
      content: content,
    );
  }
}

