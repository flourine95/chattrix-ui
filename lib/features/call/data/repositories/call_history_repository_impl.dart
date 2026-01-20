import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/repositories/base_repository.dart';
import 'package:chattrix_ui/features/call/data/datasources/call_history_datasource.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_history_item.dart';
import 'package:chattrix_ui/features/call/domain/repositories/call_history_repository.dart';

class CallHistoryRepositoryImpl extends BaseRepository implements CallHistoryRepository {
  final CallHistoryDataSource dataSource;

  CallHistoryRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<CallHistoryItem>>> getCallHistory({String? filter}) async {
    return executeApiCall(() async {
      final models = await dataSource.getCallHistory(filter: filter);
      
      // Get current user ID - you'll need to get this from auth state
      // For now, using a placeholder - you should inject AuthRepository or get from secure storage
      final currentUserId = 2; // TODO: Get from auth state
      
      return models.map((m) => m.toEntity(currentUserId)).toList();
    });
  }
}
