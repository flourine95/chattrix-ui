import 'package:freezed_annotation/freezed_annotation.dart';

part 'poll_vote_event_dto.freezed.dart';
part 'poll_vote_event_dto.g.dart';

@freezed
abstract class PollVoteEventDto with _$PollVoteEventDto {
  const factory PollVoteEventDto({
    required int messageId,
    required String question,
    required List<PollVoteOptionDto> options,
    required bool allowMultiple,
    required bool anonymous,
    String? closesAt,
    @Default(false) bool isClosed,
    required int totalVotes,
    required int createdBy,
    required String createdByUsername,
    required String createdAt,
  }) = _PollVoteEventDto;

  factory PollVoteEventDto.fromJson(Map<String, dynamic> json) => _$PollVoteEventDtoFromJson(json);
}

@freezed
abstract class PollVoteOptionDto with _$PollVoteOptionDto {
  const factory PollVoteOptionDto({
    required int id,
    required String text,
    required int voteCount,
    List<int>? voterIds,
    bool? hasVoted,
  }) = _PollVoteOptionDto;

  factory PollVoteOptionDto.fromJson(Map<String, dynamic> json) => _$PollVoteOptionDtoFromJson(json);
}
