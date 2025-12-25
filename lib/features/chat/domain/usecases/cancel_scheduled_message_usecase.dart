import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';
import '../repositories/scheduled_message_repository.dart';

/// UseCase for cancelling a scheduled message
class CancelScheduledMessageUseCase {
  final ScheduledMessageRepository _repository;

  CancelScheduledMessageUseCase(this._repository);

  /// Execute the use case
  ///
  /// **Parameters:**
  /// - [conversationId]: ID of the conversation
  /// - [scheduledMessageId]: ID of the scheduled message to cancel
  ///
  /// **Returns:**
  /// - Right(void): Success
  /// - Left(Failure): Error occurred
  Future<Either<Failure, void>> call({required int conversationId, required int scheduledMessageId}) async {
    return await _repository.cancelScheduledMessage(
      conversationId: conversationId,
      scheduledMessageId: scheduledMessageId,
    );
  }
}
