import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_history_item.dart';
import 'package:chattrix_ui/features/call/domain/repositories/call_history_repository.dart';

class GetCallHistoryUseCase {
  final CallHistoryRepository repository;

  GetCallHistoryUseCase(this.repository);

  Future<Either<Failure, List<CallHistoryItem>>> call({String? filter}) {
    return repository.getCallHistory(filter: filter);
  }
}
