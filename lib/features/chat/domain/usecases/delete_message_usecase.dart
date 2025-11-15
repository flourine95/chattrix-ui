import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteMessageUsecase {
  final ChatRepository repository;

  DeleteMessageUsecase({required this.repository});

  Future<Either<Failure, void>> call({required String messageId}) async {
    return await repository.deleteMessage(messageId);
  }
}
