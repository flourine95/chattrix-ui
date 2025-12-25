import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'poll_option_entity.dart';

part 'poll_entity.freezed.dart';

@freezed
abstract class PollEntity with _$PollEntity {
  const factory PollEntity({
    required int id,
    required String question,
    required int conversationId,
    required User creator,
    required bool allowMultipleVotes,
    DateTime? expiresAt,
    required bool isClosed,
    required bool isExpired,
    required bool isActive,
    required DateTime createdAt,
    required int totalVoters,
    required List<PollOptionEntity> options,
    required List<int> currentUserVotedOptionIds,
  }) = _PollEntity;

  const PollEntity._();

  bool get hasVoted => currentUserVotedOptionIds.isNotEmpty;

  bool get canVote => isActive && !isClosed && !isExpired;

  PollOptionEntity? get winningOption {
    if (options.isEmpty) return null;
    return options.reduce((a, b) => a.voteCount > b.voteCount ? a : b);
  }

  bool get isExpiredNow {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }
}
