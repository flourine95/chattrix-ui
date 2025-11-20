import 'package:chattrix_ui/features/call/domain/entities/call_history_entity.dart';

abstract class CallLocalDataSource {
  /// Save a call history entry to local storage
  Future<void> saveCallHistory(CallHistoryEntity callHistory);

  /// Get all call history entries from local storage
  Future<List<CallHistoryEntity>> getCallHistory();

  /// Delete a specific call history entry by ID
  Future<void> deleteCallHistory(String callId);

  /// Delete all call history entries
  Future<void> clearCallHistory();
}
