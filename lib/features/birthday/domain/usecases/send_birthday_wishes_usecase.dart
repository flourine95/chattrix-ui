import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/birthday_repository.dart';

/// Use case for sending birthday wishes
class SendBirthdayWishesUseCase {
  final BirthdayRepository _repository;

  SendBirthdayWishesUseCase(this._repository);

  /// Execute the use case
  ///
  /// **Parameters:**
  /// - [userId]: ID of the birthday user
  /// - [conversationIds]: List of conversation IDs to send wishes to
  /// - [customMessage]: Optional custom message (uses template if null)
  ///
  /// **Returns:**
  /// - Right(void): Success
  /// - Left(Failure): Error occurred
  Future<Either<Failure, void>> call({
    required int userId,
    required List<int> conversationIds,
    String? customMessage,
  }) async {
    // Validation
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
