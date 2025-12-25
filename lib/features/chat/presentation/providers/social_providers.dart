import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../features/auth/presentation/providers/auth_repository_provider.dart';
import '../../data/datasources/social_datasource_impl.dart';
import '../../data/repositories/social_repository_impl.dart';
import '../../domain/datasources/social_datasource.dart';
import '../../domain/repositories/social_repository.dart';
import '../../domain/entities/mutual_group.dart';
import '../../domain/entities/birthday.dart';
import '../../domain/usecases/social/get_birthdays_today_usecase.dart';
import '../../domain/usecases/social/send_birthday_wishes_usecase.dart';
import '../../domain/usecases/social/create_announcement_usecase.dart';
import '../../domain/usecases/social/get_mutual_groups_usecase.dart';

part 'social_providers.g.dart';

// Datasource Provider
@riverpod
SocialDatasource socialDatasource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return SocialDatasourceImpl(dio: dio);
}

// Repository Provider
@riverpod
SocialRepository socialRepository(Ref ref) {
  final datasource = ref.watch(socialDatasourceProvider);
  return SocialRepositoryImpl(datasource);
}

// Use Case Providers
@riverpod
GetBirthdaysTodayUseCase getBirthdaysTodayUseCase(Ref ref) {
  final repository = ref.watch(socialRepositoryProvider);
  return GetBirthdaysTodayUseCase(repository);
}

@riverpod
SendBirthdayWishesUseCase sendBirthdayWishesUseCase(Ref ref) {
  final repository = ref.watch(socialRepositoryProvider);
  return SendBirthdayWishesUseCase(repository);
}

@riverpod
CreateAnnouncementUseCase createAnnouncementUseCase(Ref ref) {
  final repository = ref.watch(socialRepositoryProvider);
  return CreateAnnouncementUseCase(repository);
}

@riverpod
GetMutualGroupsUseCase getMutualGroupsUseCase(Ref ref) {
  final repository = ref.watch(socialRepositoryProvider);
  return GetMutualGroupsUseCase(repository);
}

// State Providers

/// Provider for fetching mutual groups with a specific user
@riverpod
Future<List<MutualGroup>> mutualGroups(Ref ref, int userId) async {
  final useCase = ref.watch(getMutualGroupsUseCaseProvider);
  final result = await useCase(userId: userId);

  return result.fold((failure) => throw Exception(failure.message), (groups) => groups);
}

/// Provider for fetching today's birthdays
@riverpod
Future<List<Birthday>> birthdaysToday(Ref ref) async {
  final useCase = ref.watch(getBirthdaysTodayUseCaseProvider);
  final result = await useCase();

  return result.fold((failure) => throw Exception(failure.message), (birthdays) => birthdays);
}

/// Notifier for sending birthday wishes
@riverpod
class SendBirthdayWishesNotifier extends _$SendBirthdayWishesNotifier {
  @override
  FutureOr<void> build() {
    // Initial state
  }

  Future<void> sendWishes(int userId, List<int> conversationIds, {String? customMessage}) async {
    state = const AsyncValue.loading();

    final useCase = ref.read(sendBirthdayWishesUseCaseProvider);
    final result = await useCase(userId: userId, conversationIds: conversationIds, customMessage: customMessage);

    state = result.fold(
      (failure) => AsyncValue.error(Exception(failure.message), StackTrace.current),
      (_) => const AsyncValue.data(null),
    );
  }
}
