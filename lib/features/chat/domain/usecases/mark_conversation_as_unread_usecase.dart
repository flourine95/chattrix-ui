import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';

/// Use case for marking a conversation as unread
///
/// This sets the unreadCount to 1 if currently 0, creating an unread notification effect.
///
/// **API:** `POST /v1/read-receipts/conversations/{conversationId}/unread`
class MarkConversationAsUnreadUseCase {
  final ChatRepository _repository;

  MarkConversationAsUnreadUseCase(this._repository);

  /// Execute the use case
  ///
  /// **Parameters:**
  /// - [conversationId]: ID of the conversation to mark as unread
  ///
  /// **Returns:**
  /// - Right(void): Successfully marked as unread
  /// - Left(Failure): Error occurred
  ///
  /// **Effects:**
  /// - Sets unreadCount to 1 if currently 0
  /// - Creates unread notification effect in UI
  Future<Either<Failure, void>> call({required int conversationId}) async {
    return await _repository.markConversationAsUnread(conversationId: conversationId);
  }
}
