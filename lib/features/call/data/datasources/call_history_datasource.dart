import 'package:chattrix_ui/features/call/data/models/call_history_model.dart';

abstract class CallHistoryDataSource {
  Future<List<CallHistoryModel>> getCallHistory({String? filter});
}
