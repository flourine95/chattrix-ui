import '../models/poll_model.dart';
import '../../domain/entities/poll.dart';
import 'package:chattrix_ui/features/auth/data/mappers/user_mapper.dart';

extension PollModelMapper on PollModel {
  Poll toEntity() {
    return Poll(
      id: id,
      question: question,
      conversationId: conversationId,
      creator: creator.toEntity(),
      allowMultipleVotes: allowMultipleVotes,
      expiresAt: expiresAt,
      closed: closed,
      expired: expired,
      active: active,
      createdAt: createdAt,
      totalVoters: totalVoters,
      options: options.map((option) => option.toEntity()).toList(),
      currentUserVotedOptionIds: currentUserVotedOptionIds,
    );
  }
}

extension PollOptionModelMapper on PollOptionModel {
  PollOption toEntity() {
    return PollOption(
      id: id,
      optionText: optionText,
      optionOrder: optionOrder,
      voteCount: voteCount,
      percentage: percentage,
      voters: voters.map((voter) => voter.toEntity()).toList(),
    );
  }
}
