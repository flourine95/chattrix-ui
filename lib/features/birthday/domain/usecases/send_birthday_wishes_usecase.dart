import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/birthday/domain/repositories/birthday_repository.dart';
import 'package:fpdart/fpdart.dart';

class SendBirthdayWishesUseCase {
  final BirthdayRepository _repository;

  SendBirthdayWishesUseCase(this._repository);

  Future<Either<Failure, void>> call({
    required int userId,
    required List<int> conversationIds,
    String? customMessage,
  }) async {
    if (conversationIds.isEmpty) {
      return left(const Failure.validation(message: 'Please select at least one conversation', code: 'INVALID_INPUT'));
    }

    return await _repository.sendBirthdayWishes(
      userId: userId,
      conversationIds: conversationIds,
      customMessage: customMessage,
    );
  }
}
