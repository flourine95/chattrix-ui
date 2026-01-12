import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/birthday.dart';
import '../../repositories/social_repository.dart';

/// Use case for getting today's birthdays
class GetBirthdaysTodayUseCase {
  final SocialRepository _repository;

  GetBirthdaysTodayUseCase(this._repository);

  Future<Either<Failure, List<Birthday>>> call() async {
    return await _repository.getBirthdaysToday();
  }
}
