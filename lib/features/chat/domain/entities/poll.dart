import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';

part 'poll.freezed.dart';

/// Domain entity for poll
/// Framework-agnostic - NO Flutter/Dio/json_annotation imports
@freezed
abstract class Poll with _$Poll {
  const factory Poll({
    required int id,
    required String question,
    required int conversationId,
    required User creator,
    required bool allowMultipleVotes,
    DateTime? expiresAt,
    required bool closed,
    required bool expired,
    required bool active,
    required DateTime createdAt,
    required int totalVoters,
    required List<PollOption> options,
    required List<int> currentUserVotedOptionIds,
  }) = _Poll;
}

/// Domain entity for poll option
@freezed
abstract class PollOption with _$PollOption {
  const factory PollOption({
    required int id,
    required String optionText,
    required int optionOrder,
    required int voteCount,
    required double percentage,
    required List<User> voters,
  }) = _PollOption;
}
