import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/birthday/domain/entities/birthday_user_entity.dart';
import 'package:chattrix_ui/features/birthday/domain/repositories/birthday_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetUpcomingBirthdaysUseCase {
  final BirthdayRepository _repository;

  GetUpcomingBirthdaysUseCase(this._repository);

  Future<Either<Failure, List<BirthdayUserEntity>>> call({int days = 7}) async {
    return await _repository.getUpcomingBirthdays(days: days);
  }
}
