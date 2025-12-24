import '../models/poll_dto.dart';
import '../models/poll_option_dto.dart';
import '../models/create_poll_request_dto.dart';
import '../models/vote_request_dto.dart';
import '../../domain/entities/poll_entity.dart';
import '../../domain/entities/poll_option_entity.dart';
import '../../domain/entities/create_poll_params.dart';
import '../../../auth/data/mappers/user_mapper.dart';

/// Mapper for Poll DTO ↔ Entity
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

/// Mapper for PollOption DTO ↔ Entity
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

/// Mapper for CreatePollParams → DTO
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

/// Mapper for Vote params → DTO
extension VoteParamsMapper on List<int> {
  VoteRequestDto toDto() {
    return VoteRequestDto(optionIds: this);
  }
}
