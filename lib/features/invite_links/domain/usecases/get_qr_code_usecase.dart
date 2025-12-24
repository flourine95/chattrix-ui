import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../repositories/invite_links_repository.dart';

/// Use case for getting QR code
class GetQRCodeUseCase {
  final InviteLinksRepository _repository;

  GetQRCodeUseCase(this._repository);

  /// Execute the use case
  ///
  /// **Parameters:**
  /// - [conversationId]: ID of the conversation
  /// - [linkId]: ID of the link
  /// - [size]: Size of QR code (default: 300)
  /// - [apiUrl]: Base URL of API (for ngrok)
  ///
  /// **Returns:**
  /// - Right(List<int>): Image bytes
  /// - Left(Failure): Error occurred
  Future<Either<Failure, List<int>>> call({
    required int conversationId,
    required int linkId,
    int size = 300,
    String? apiUrl,
  }) async {
    // Validation
    if (conversationId <= 0) {
      return left(
        const Failure.validation(message: 'ID cuộc trò chuyện không hợp lệ', code: 'INVALID_CONVERSATION_ID'),
      );
    }

    if (linkId <= 0) {
      return left(const Failure.validation(message: 'ID link không hợp lệ', code: 'INVALID_LINK_ID'));
    }

    if (size < 100 || size > 2000) {
      return left(const Failure.validation(message: 'Kích thước QR code phải từ 100 đến 2000', code: 'INVALID_SIZE'));
    }

    return await _repository.getQRCode(conversationId: conversationId, linkId: linkId, size: size, apiUrl: apiUrl);
  }
}
