import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/invite_link_entity.dart';
import '../repositories/invite_links_repository.dart';

/// Use case for creating invite link
class CreateInviteLinkUseCase {
  final InviteLinksRepository _repository;

  CreateInviteLinkUseCase(this._repository);

  /// Execute the use case
  ///
  /// **Parameters:**
  /// - [conversationId]: ID of the conversation
  /// - [expiresIn]: Time in seconds until link expires (null = no expiry)
  /// - [maxUses]: Maximum number of uses (null = unlimited)
  ///
  /// **Returns:**
  /// - Right(InviteLinkEntity): Success
  /// - Left(Failure): Error occurred
  Future<Either<Failure, InviteLinkEntity>> call({required int conversationId, int? expiresIn, int? maxUses}) async {
    // Validation
    if (conversationId <= 0) {
      return left(
        const Failure.validation(message: 'ID cuộc trò chuyện không hợp lệ', code: 'INVALID_CONVERSATION_ID'),
      );
    }

    if (expiresIn != null && expiresIn <= 0) {
      return left(const Failure.validation(message: 'Thời gian hết hạn phải lớn hơn 0', code: 'INVALID_EXPIRES_IN'));
    }

    if (maxUses != null && maxUses <= 0) {
      return left(const Failure.validation(message: 'Số lần sử dụng tối đa phải lớn hơn 0', code: 'INVALID_MAX_USES'));
    }

    return await _repository.createInviteLink(conversationId: conversationId, expiresIn: expiresIn, maxUses: maxUses);
  }
}
