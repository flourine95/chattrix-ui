import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/poll_entity.dart';
import '../repositories/poll_repository.dart';

/// Use case for closing a poll
///
/// Single Responsibility: Close a poll (creator only)
class ClosePollUseCase {
  final PollRepository _repository;

  ClosePollUseCase(this._repository);

  /// Execute the use case
  ///
  /// Parameters:
  /// - [pollId]: ID of the poll to close
  ///
  /// Returns:
  /// - Right(PollEntity): Success with closed poll
  /// - Left(Failure): Error occurred
  Future<Either<Failure, PollEntity>> call({required int pollId}) async {
    return await _repository.closePoll(pollId: pollId);
  }
}
