import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../features/auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/poll_api_service.dart';
import '../../data/repositories/poll_repository_impl.dart';
import '../../domain/repositories/poll_repository.dart';
import '../../domain/usecases/create_poll_usecase.dart';
import '../../domain/usecases/vote_poll_usecase.dart';
import '../../domain/usecases/get_poll_usecase.dart';
import '../../domain/usecases/close_poll_usecase.dart';
import '../../domain/usecases/delete_poll_usecase.dart';

part 'poll_providers.g.dart';

/// Poll API Service Provider
@Riverpod(keepAlive: true)
PollApiService pollApiService(Ref ref) {
  final dio = ref.watch(dioProvider);
  return PollApiService(dio);
}

/// Poll Repository Provider
@Riverpod(keepAlive: true)
PollRepository pollRepository(Ref ref) {
  final apiService = ref.watch(pollApiServiceProvider);
  return PollRepositoryImpl(apiService);
}

/// Create Poll Use Case Provider
@riverpod
CreatePollUseCase createPollUseCase(Ref ref) {
  final repository = ref.watch(pollRepositoryProvider);
  return CreatePollUseCase(repository);
}

/// Vote Poll Use Case Provider
@riverpod
VotePollUseCase votePollUseCase(Ref ref) {
  final repository = ref.watch(pollRepositoryProvider);
  return VotePollUseCase(repository);
}

/// Get Poll Use Case Provider
@riverpod
GetPollUseCase getPollUseCase(Ref ref) {
  final repository = ref.watch(pollRepositoryProvider);
  return GetPollUseCase(repository);
}

/// Close Poll Use Case Provider
@riverpod
ClosePollUseCase closePollUseCase(Ref ref) {
  final repository = ref.watch(pollRepositoryProvider);
  return ClosePollUseCase(repository);
}

/// Delete Poll Use Case Provider
@riverpod
DeletePollUseCase deletePollUseCase(Ref ref) {
  final repository = ref.watch(pollRepositoryProvider);
  return DeletePollUseCase(repository);
}
