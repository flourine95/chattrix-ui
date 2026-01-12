import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/scheduled_message.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/scheduled_message_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetScheduledMessagesUseCase {
  final ScheduledMessageRepository _repository;

  GetScheduledMessagesUseCase(this._repository);

  Future<Either<Failure, List<ScheduledMessage>>> call({
    int? conversationId,
    String status = 'PENDING',
    int page = 0,
    int size = 20,
  }) async {
    return await _repository.getScheduledMessages(
      conversationId: conversationId,
      status: status,
      page: page,
      size: size,
    );
  }
}
