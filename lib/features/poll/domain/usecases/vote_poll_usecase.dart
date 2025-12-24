import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/poll_entity.dart';
import '../repositories/poll_repository.dart';

/// Use case for voting on a poll
///
/// Single Responsibility: Cast a vote on a poll
class VotePollUseCase {
  final PollRepository _repository;

  VotePollUseCase(this._repository);

  /// Execute the use case
  ///
  /// Parameters:
  /// - [pollId]: ID of the poll to vote on
  /// - [optionIds]: List of option IDs to vote for
  ///
  /// Returns:
  /// - Right(PollEntity): Success with updated poll
  /// - Left(Failure): Error occurred
  Future<Either<Failure, PollEntity>> call({required int pollId, required List<int> optionIds}) async {
    // Validate input
    if (optionIds.isEmpty) {
      return left(const Failure.validation(message: 'Must select at least one option', code: 'NO_OPTIONS_SELECTED'));
    }

    // Call repository
    return await _repository.votePoll(pollId: pollId, optionIds: optionIds);
  }
}
