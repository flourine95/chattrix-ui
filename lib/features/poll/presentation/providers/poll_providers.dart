import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/poll/data/datasources/poll_api_service.dart';
import 'package:chattrix_ui/features/poll/data/repositories/poll_repository_impl.dart';
import 'package:chattrix_ui/features/poll/domain/repositories/poll_repository.dart';
import 'package:chattrix_ui/features/poll/domain/usecases/close_poll_usecase.dart';
import 'package:chattrix_ui/features/poll/domain/usecases/create_poll_usecase.dart';
import 'package:chattrix_ui/features/poll/domain/usecases/delete_poll_usecase.dart';
import 'package:chattrix_ui/features/poll/domain/usecases/get_poll_usecase.dart';
import 'package:chattrix_ui/features/poll/domain/usecases/vote_poll_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'poll_providers.g.dart';

@Riverpod(keepAlive: true)
PollApiService pollApiService(Ref ref) {
  final dio = ref.watch(dioProvider);
  return PollApiService(dio);
}

@Riverpod(keepAlive: true)
PollRepository pollRepository(Ref ref) {
  final apiService = ref.watch(pollApiServiceProvider);
  return PollRepositoryImpl(apiService);
}

@riverpod
CreatePollUseCase createPollUseCase(Ref ref) {
  final repository = ref.watch(pollRepositoryProvider);
  return CreatePollUseCase(repository);
}

@riverpod
VotePollUseCase votePollUseCase(Ref ref) {
  final repository = ref.watch(pollRepositoryProvider);
  return VotePollUseCase(repository);
}

@riverpod
GetPollUseCase getPollUseCase(Ref ref) {
  final repository = ref.watch(pollRepositoryProvider);
  return GetPollUseCase(repository);
}

@riverpod
ClosePollUseCase closePollUseCase(Ref ref) {
  final repository = ref.watch(pollRepositoryProvider);
  return ClosePollUseCase(repository);
}

@riverpod
DeletePollUseCase deletePollUseCase(Ref ref) {
  final repository = ref.watch(pollRepositoryProvider);
  return DeletePollUseCase(repository);
}
