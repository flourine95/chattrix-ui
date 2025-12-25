import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/invite_links/domain/repositories/invite_links_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetQRCodeUseCase {
  final InviteLinksRepository _repository;

  GetQRCodeUseCase(this._repository);

  Future<Either<Failure, List<int>>> call({
    required int conversationId,
    required int linkId,
    int size = 300,
    String? apiUrl,
  }) async {
    if (conversationId <= 0) {
      return left(const Failure.validation(message: 'Invalid conversation ID', code: 'INVALID_CONVERSATION_ID'));
    }

    if (linkId <= 0) {
      return left(const Failure.validation(message: 'Invalid link ID', code: 'INVALID_LINK_ID'));
    }

    if (size < 100 || size > 2000) {
      return left(const Failure.validation(message: 'QR code size must be between 100 and 2000', code: 'INVALID_SIZE'));
    }

    return await _repository.getQRCode(conversationId: conversationId, linkId: linkId, size: size, apiUrl: apiUrl);
  }
}
