import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/birthday/domain/entities/birthday_user_entity.dart';

abstract class BirthdayRepository {
  Future<Either<Failure, List<BirthdayUserEntity>>> getTodayBirthdays();

  Future<Either<Failure, List<BirthdayUserEntity>>> getUpcomingBirthdays({int days = 7});

  Future<Either<Failure, void>> sendBirthdayWishes({
    required int userId,
    required List<int> conversationIds,
    String? customMessage,
  });
}
