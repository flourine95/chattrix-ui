import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../entities/invite_link_entity.dart';
import '../repositories/invite_links_repository.dart';

/// Use case for joining group via invite link
class JoinGroupViaLinkUseCase {
  final InviteLinksRepository _repository;

  JoinGroupViaLinkUseCase(this._repository);

  /// Execute the use case
  ///
  /// **Parameters:**
  /// - [token]: Token of the invite link
  ///
  /// **Returns:**
  /// - Right(JoinGroupResultEntity): Success
  /// - Left(Failure): Error occurred
  Future<Either<Failure, JoinGroupResultEntity>> call({required String token}) async {
    // Validation
    if (token.isEmpty) {
      return left(const Failure.validation(message: 'Token không được để trống', code: 'INVALID_TOKEN'));
    }

    return await _repository.joinGroupViaLink(token: token);
  }
}
