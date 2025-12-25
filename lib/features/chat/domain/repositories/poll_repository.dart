import 'package:fpdart/fpdart.dart';
import '../entities/poll.dart';
import 'package:chattrix_ui/core/errors/failures.dart';

/// Repository interface for polls
/// Implementation: Data Layer
abstract class PollRepository {
  /// Create a poll
  /// Returns [Right] with [Poll] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, Poll>> createPoll({
    required int conversationId,
    required String question,
    required List<String> options,
    required bool allowMultipleVotes,
    DateTime? expiresAt,
  });

  /// Vote on a poll
  Future<Either<Failure, Poll>> votePoll({
    required int conversationId,
    required int pollId,
    required List<int> optionIds,
  });

  /// Remove vote from a poll
  Future<Either<Failure, Poll>> removeVote({
    required int conversationId,
    required int pollId,
    required List<int> optionIds,
  });

  /// Close a poll
  Future<Either<Failure, Poll>> closePoll({required int conversationId, required int pollId});

  /// Delete a poll
  Future<Either<Failure, String>> deletePoll({required int conversationId, required int pollId});

  /// Get poll details
  Future<Either<Failure, Poll>> getPollDetails({required int conversationId, required int pollId});

  /// Get all polls in a conversation
  Future<Either<Failure, List<Poll>>> getAllPolls({required int conversationId});
}
