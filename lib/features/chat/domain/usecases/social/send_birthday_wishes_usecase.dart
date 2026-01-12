import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/birthday.dart';
import '../../repositories/social_repository.dart';

/// Use case for sending birthday wishes
class SendBirthdayWishesUseCase {
  final SocialRepository _repository;

  SendBirthdayWishesUseCase(this._repository);

  Future<Either<Failure, SendBirthdayWishes>> call({
    required int userId,
    required List<int> conversationIds,
    String? customMessage,
  }) async {
    // Validation
    if (conversationIds.isEmpty) {
      return left(
        const Failure.validation(message: 'Must select at least one conversation', code: 'NO_CONVERSATION_SELECTED'),
      );
    }

    return await _repository.sendBirthdayWishes(
      userId: userId,
      conversationIds: conversationIds,
      customMessage: customMessage,
    );
  }
}
