import 'package:chattrix_ui/features/poll/data/models/poll_dto.dart';
import 'package:chattrix_ui/features/poll/data/models/poll_option_dto.dart';
import 'package:chattrix_ui/features/poll/data/models/create_poll_request_dto.dart';
import 'package:chattrix_ui/features/poll/data/models/vote_request_dto.dart';
import 'package:chattrix_ui/features/poll/domain/entities/poll_entity.dart';
import 'package:chattrix_ui/features/poll/domain/entities/poll_option_entity.dart';
import 'package:chattrix_ui/features/poll/domain/entities/create_poll_params.dart';
import 'package:chattrix_ui/features/auth/data/mappers/user_mapper.dart';

extension PollDtoMapper on PollDto {
  PollEntity toEntity() {
    return PollEntity(
      id: id,
      question: question,
      conversationId: conversationId,
      creator: creator.toEntity(),
      allowMultipleVotes: allowMultipleVotes,
      expiresAt: expiresAt,
      isClosed: isClosed,
      isExpired: isExpired,
      isActive: isActive,
      createdAt: createdAt,
      totalVoters: totalVoters,
      options: options.map((o) => o.toEntity()).toList(),
      currentUserVotedOptionIds: currentUserVotedOptionIds,
    );
  }
}

extension PollOptionDtoMapper on PollOptionDto {
  PollOptionEntity toEntity() {
    return PollOptionEntity(
      id: id,
      optionText: optionText,
      optionOrder: optionOrder,
      voteCount: voteCount,
      percentage: percentage,
      voters: voters.map((v) => v.toEntity()).toList(),
    );
  }
}

extension CreatePollParamsMapper on CreatePollParams {
  CreatePollRequestDto toDto() {
    return CreatePollRequestDto(
      question: question,
      options: options,
      allowMultipleVotes: allowMultipleVotes,
      expiresAt: expiresAt,
    );
  }
}

extension VoteParamsMapper on List<int> {
  VoteRequestDto toDto() {
    return VoteRequestDto(optionIds: this);
  }
}
