import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/repositories/base_repository.dart';
import '../../domain/entities/birthday_user_entity.dart';
import '../../domain/repositories/birthday_repository.dart';
import '../datasources/birthday_api_service.dart';
import '../mappers/birthday_user_mapper.dart';

class BirthdayRepositoryImpl extends BaseRepository implements BirthdayRepository {
  final BirthdayApiService _apiService;

  BirthdayRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, List<BirthdayUserEntity>>> getTodayBirthdays() async {
    return executeApiCall(() async {
      final dtos = await _apiService.getTodayBirthdays();
      return dtos.map((dto) => dto.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, List<BirthdayUserEntity>>> getUpcomingBirthdays({int days = 7}) async {
    return executeApiCall(() async {
      final dtos = await _apiService.getUpcomingBirthdays(days: days);
      return dtos.map((dto) => dto.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, void>> sendBirthdayWishes({
    required int userId,
    required List<int> conversationIds,
    String? customMessage,
  }) async {
    return executeApiCall(() async {
      await _apiService.sendBirthdayWishes(
        userId: userId,
        conversationIds: conversationIds,
        customMessage: customMessage,
      );
    });
  }
}
