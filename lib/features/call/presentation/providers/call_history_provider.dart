import 'package:chattrix_ui/features/call/domain/entities/call_history_entity.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'call_history_provider.g.dart';

/// Call History Notifier - manages call history state
@riverpod
class CallHistory extends _$CallHistory {
  @override
  Future<List<CallHistoryEntity>> build() async {
    return _loadCallHistory();
  }

  Future<List<CallHistoryEntity>> _loadCallHistory() async {
    final repository = ref.read(callRepositoryProvider);
    final result = await repository.getCallHistory();

    return result.fold((failure) => throw failure, (history) => history);
  }

  /// Refresh call history
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadCallHistory());
  }
}
