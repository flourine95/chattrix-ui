import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for marking a conversation as read
///
/// Marks all unread messages in a conversation as read by creating read receipts.
/// This resets the unread count and allows other users to see "Read" status.
///
/// **API:** `POST /v1/read-receipts/conversations/{conversationId}`
class MarkConversationAsReadUseCase {
  final ChatRepository _repository;

  MarkConversationAsReadUseCase(this._repository);

  /// Mark all messages in conversation as read
  ///
  /// **Parameters:**
  /// - [conversationId]: ID of the conversation to mark as read
  /// - [lastMessageId]: Optional - ID of last message to mark as read.
  ///   If not provided, marks all messages as read.
  ///
  /// **Returns:**
  /// - Right(void): Successfully marked as read
  /// - Left(Failure): Error occurred (network, auth, not found, etc.)
  ///
  /// **Side Effects:**
  /// - Creates read receipts in backend
  /// - Resets unread count in participant table
  /// - Other users can see "Read" status
  Future<Either<Failure, void>> call({required int conversationId, int? lastMessageId}) async {
    return await _repository.markConversationAsRead(conversationId: conversationId, lastMessageId: lastMessageId);
  }
}
