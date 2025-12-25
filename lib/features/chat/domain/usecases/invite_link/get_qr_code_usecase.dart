import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../repositories/invite_link_repository.dart';

/// Use case for getting QR code for an invite link
class GetQrCodeUseCase {
  final InviteLinkRepository _repository;

  GetQrCodeUseCase(this._repository);

  Future<Either<Failure, List<int>>> call({required String token}) async {
    // Validation
    if (token.trim().isEmpty) {
      return left(const Failure.validation(message: 'Token cannot be empty', code: 'INVALID_TOKEN'));
    }

    return await _repository.getQrCode(token: token);
  }
}
