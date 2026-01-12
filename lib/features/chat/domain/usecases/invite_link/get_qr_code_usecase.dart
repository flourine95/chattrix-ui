import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../repositories/invite_link_repository.dart';

/// Use case for getting QR code for an invite link
class GetQrCodeUseCase {
  final InviteLinkRepository _repository;

  GetQrCodeUseCase(this._repository);

  Future<Either<Failure, List<int>>> call({required int conversationId, required int linkId, String? apiUrl}) async {
    // Validation
    if (conversationId <= 0) {
      return left(const Failure.validation(message: 'Invalid conversation ID', code: 'INVALID_CONVERSATION_ID'));
    }
    if (linkId <= 0) {
      return left(const Failure.validation(message: 'Invalid link ID', code: 'INVALID_LINK_ID'));
    }

    return await _repository.getQrCode(conversationId: conversationId, linkId: linkId, apiUrl: apiUrl);
  }
}
