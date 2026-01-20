import 'package:chattrix_ui/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:chattrix_ui/features/call/data/datasources/call_history_datasource.dart';
import 'package:chattrix_ui/features/call/data/datasources/call_history_datasource_impl.dart';
import 'package:chattrix_ui/features/call/data/repositories/call_history_repository_impl.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_history_item.dart';
import 'package:chattrix_ui/features/call/domain/repositories/call_history_repository.dart';
import 'package:chattrix_ui/features/call/domain/usecases/get_call_history_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'call_history_provider.g.dart';

// DataSource Provider
@riverpod
CallHistoryDataSource callHistoryDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return CallHistoryDataSourceImpl(dio);
}

// Repository Provider
@riverpod
CallHistoryRepository callHistoryRepository(Ref ref) {
  final dataSource = ref.watch(callHistoryDataSourceProvider);
  return CallHistoryRepositoryImpl(dataSource);
}

// UseCase Provider
@riverpod
GetCallHistoryUseCase getCallHistoryUseCase(Ref ref) {
  final repository = ref.watch(callHistoryRepositoryProvider);
  return GetCallHistoryUseCase(repository);
}

// State Provider
@riverpod
class CallHistory extends _$CallHistory {
  @override
  Future<List<CallHistoryItem>> build() async {
    return _fetchHistory();
  }

  Future<List<CallHistoryItem>> _fetchHistory({String? filter}) async {
    final useCase = ref.read(getCallHistoryUseCaseProvider);
    final result = await useCase(filter: filter);

    return result.fold((failure) => throw Exception(failure.message), (history) => history);
  }

  Future<void> refresh({String? filter}) async {
    state = const AsyncValue.loading();

    try {
      final history = await _fetchHistory(filter: filter);
      state = AsyncValue.data(history);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
