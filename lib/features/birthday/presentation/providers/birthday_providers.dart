import 'package:chattrix_ui/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:chattrix_ui/features/birthday/data/datasources/birthday_api_service.dart';
import 'package:chattrix_ui/features/birthday/data/repositories/birthday_repository_impl.dart';
import 'package:chattrix_ui/features/birthday/domain/entities/birthday_user_entity.dart';
import 'package:chattrix_ui/features/birthday/domain/repositories/birthday_repository.dart';
import 'package:chattrix_ui/features/birthday/domain/usecases/get_today_birthdays_usecase.dart';
import 'package:chattrix_ui/features/birthday/domain/usecases/get_upcoming_birthdays_usecase.dart';
import 'package:chattrix_ui/features/birthday/domain/usecases/send_birthday_wishes_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'birthday_providers.g.dart';

@Riverpod(keepAlive: true)
BirthdayApiService birthdayApiService(Ref ref) {
  final dioInstance = ref.watch(dioProvider);
  return BirthdayApiService(dioInstance);
}

@Riverpod(keepAlive: true)
BirthdayRepository birthdayRepository(Ref ref) {
  final apiService = ref.watch(birthdayApiServiceProvider);
  return BirthdayRepositoryImpl(apiService);
}

@Riverpod(keepAlive: true)
GetTodayBirthdaysUseCase getTodayBirthdaysUseCase(Ref ref) {
  final repository = ref.watch(birthdayRepositoryProvider);
  return GetTodayBirthdaysUseCase(repository);
}

@riverpod
GetUpcomingBirthdaysUseCase getUpcomingBirthdaysUseCase(Ref ref) {
  final repository = ref.watch(birthdayRepositoryProvider);
  return GetUpcomingBirthdaysUseCase(repository);
}

@riverpod
SendBirthdayWishesUseCase sendBirthdayWishesUseCase(Ref ref) {
  final repository = ref.watch(birthdayRepositoryProvider);
  return SendBirthdayWishesUseCase(repository);
}

@Riverpod(keepAlive: true)
class TodayBirthdays extends _$TodayBirthdays {
  @override
  Future<List<BirthdayUserEntity>> build() async {
    final useCase = ref.read(getTodayBirthdaysUseCaseProvider);
    final result = await useCase();

    return result.fold((failure) => throw Exception(failure.message), (birthdays) => birthdays);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(getTodayBirthdaysUseCaseProvider);
      final result = await useCase();

      return result.fold((failure) => throw Exception(failure.message), (birthdays) => birthdays);
    });
  }
}

@riverpod
class UpcomingBirthdays extends _$UpcomingBirthdays {
  @override
  Future<List<BirthdayUserEntity>> build({int days = 7}) async {
    final useCase = ref.read(getUpcomingBirthdaysUseCaseProvider);
    final result = await useCase(days: days);

    return result.fold((failure) => throw Exception(failure.message), (birthdays) => birthdays);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(getUpcomingBirthdaysUseCaseProvider);
      final result = await useCase(days: days);

      return result.fold((failure) => throw Exception(failure.message), (birthdays) => birthdays);
    });
  }
}
