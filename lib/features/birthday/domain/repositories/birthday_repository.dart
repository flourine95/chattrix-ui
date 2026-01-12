import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/birthday_user_entity.dart';

/// Repository interface for birthday operations
abstract class BirthdayRepository {
  /// Get users with birthday today
  ///
  /// Returns [Right] with list of [BirthdayUserEntity] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<BirthdayUserEntity>>> getTodayBirthdays();

  /// Get users with upcoming birthdays
  ///
  /// Returns [Right] with list of [BirthdayUserEntity] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<BirthdayUserEntity>>> getUpcomingBirthdays({int days = 7});

  /// Send birthday wishes to user in specified conversations
  ///
  /// Returns [Right] with void on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, void>> sendBirthdayWishes({
    required int userId,
    required List<int> conversationIds,
    String? customMessage,
  });
}
