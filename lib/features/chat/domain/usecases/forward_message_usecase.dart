import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for forwarding a message to multiple conversations
///
/// **Single Responsibility**: Forward one message to multiple conversations
class ForwardMessageUsecase {
  final ChatRepository _repository;

  ForwardMessageUsecase(this._repository);

  /// Execute the use case
  ///
  /// **Parameters:**
  /// - [conversationId]: ID of conversation containing original message
  /// - [messageId]: ID of message to forward
  /// - [targetConversationIds]: List of conversation IDs to forward to
  ///
  /// **Returns:**
  /// - Right(List<Message>): List of forwarded messages
  /// - Left(Failure): Error occurred
  Future<Either<Failure, List<Message>>> call({
    required String conversationId,
    required String messageId,
    required List<int> targetConversationIds,
  }) async {
    // Business logic validation
    if (targetConversationIds.isEmpty) {
      return left(const Failure.validation(
        message: 'At least one conversation ID is required',
        code: 'INVALID_INPUT',
      ));
    }

    // Call repository
    return await _repository.forwardMessage(
      conversationId: conversationId,
      messageId: messageId,
      targetConversationIds: targetConversationIds,
    );
  }
}
