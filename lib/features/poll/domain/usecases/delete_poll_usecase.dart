import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/poll_repository.dart';

/// Use case for deleting a poll
///
/// Single Responsibility: Delete a poll (creator only)
class DeletePollUseCase {
  final PollRepository _repository;

  DeletePollUseCase(this._repository);

  /// Execute the use case
  ///
  /// Parameters:
  /// - [pollId]: ID of the poll to delete
  ///
  /// Returns:
  /// - Right(String): Success message
  /// - Left(Failure): Error occurred
  Future<Either<Failure, String>> call({required int pollId}) async {
    return await _repository.deletePoll(pollId: pollId);
  }
}
