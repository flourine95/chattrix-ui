import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/auth/data/models/user_dto.dart';

part 'poll_model.freezed.dart';
part 'poll_model.g.dart';

@freezed
abstract class PollModel with _$PollModel {
  const factory PollModel({
    required int id,
    required String question,
    required int conversationId,
    required UserDto creator,
    required bool allowMultipleVotes,
    DateTime? expiresAt,
    @Default(false) bool closed,
    @Default(false) bool expired,
    @Default(true) bool active,
    required DateTime createdAt,
    @Default(0) int totalVoters,
    @Default([]) List<PollOptionModel> options,
    @Default([]) List<int> currentUserVotedOptionIds,
  }) = _PollModel;

  factory PollModel.fromJson(Map<String, dynamic> json) => _$PollModelFromJson(json);
}

@freezed
abstract class PollOptionModel with _$PollOptionModel {
  const factory PollOptionModel({
    required int id,
    required String optionText,
    required int optionOrder,
    @Default(0) int voteCount,
    @Default(0.0) double percentage,
    @Default([]) List<UserDto> voters,
  }) = _PollOptionModel;

  factory PollOptionModel.fromJson(Map<String, dynamic> json) => _$PollOptionModelFromJson(json);
}

@freezed
abstract class CreatePollRequest with _$CreatePollRequest {
  const factory CreatePollRequest({
    required String question,
    required List<String> options,
    @Default(false) bool allowMultipleVotes,
    @JsonKey(toJson: _dateTimeToUtcString) DateTime? expiresAt,
  }) = _CreatePollRequest;

  factory CreatePollRequest.fromJson(Map<String, dynamic> json) => _$CreatePollRequestFromJson(json);
}

/// Convert DateTime to UTC ISO-8601 string with Z suffix for backend Instant parsing
String? _dateTimeToUtcString(DateTime? dateTime) {
  if (dateTime == null) return null;
  return dateTime.toUtc().toIso8601String();
}

@freezed
abstract class VotePollRequest with _$VotePollRequest {
  const factory VotePollRequest({required List<int> optionIds}) = _VotePollRequest;

  factory VotePollRequest.fromJson(Map<String, dynamic> json) => _$VotePollRequestFromJson(json);
}

@freezed
abstract class RemoveVoteRequest with _$RemoveVoteRequest {
  const factory RemoveVoteRequest({required List<int> optionIds}) = _RemoveVoteRequest;

  factory RemoveVoteRequest.fromJson(Map<String, dynamic> json) => _$RemoveVoteRequestFromJson(json);
}
