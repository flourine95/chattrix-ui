import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_history_item.dart';

abstract class CallHistoryRepository {
  Future<Either<Failure, List<CallHistoryItem>>> getCallHistory({String? filter});
}
