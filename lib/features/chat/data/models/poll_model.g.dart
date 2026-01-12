// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'poll_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PollModel _$PollModelFromJson(Map<String, dynamic> json) => _PollModel(
  id: (json['id'] as num).toInt(),
  question: json['question'] as String,
  conversationId: (json['conversationId'] as num).toInt(),
  creator: UserDto.fromJson(json['creator'] as Map<String, dynamic>),
  allowMultipleVotes: json['allowMultipleVotes'] as bool,
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  closed: json['closed'] as bool? ?? false,
  expired: json['expired'] as bool? ?? false,
  active: json['active'] as bool? ?? true,
  createdAt: DateTime.parse(json['createdAt'] as String),
  totalVoters: (json['totalVoters'] as num?)?.toInt() ?? 0,
  options:
      (json['options'] as List<dynamic>?)
          ?.map((e) => PollOptionModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  currentUserVotedOptionIds:
      (json['currentUserVotedOptionIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
);

Map<String, dynamic> _$PollModelToJson(_PollModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'conversationId': instance.conversationId,
      'creator': instance.creator,
      'allowMultipleVotes': instance.allowMultipleVotes,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'closed': instance.closed,
      'expired': instance.expired,
      'active': instance.active,
      'createdAt': instance.createdAt.toIso8601String(),
      'totalVoters': instance.totalVoters,
      'options': instance.options,
      'currentUserVotedOptionIds': instance.currentUserVotedOptionIds,
    };

_PollOptionModel _$PollOptionModelFromJson(Map<String, dynamic> json) =>
    _PollOptionModel(
      id: (json['id'] as num).toInt(),
      optionText: json['optionText'] as String,
      optionOrder: (json['optionOrder'] as num).toInt(),
      voteCount: (json['voteCount'] as num?)?.toInt() ?? 0,
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
      voters:
          (json['voters'] as List<dynamic>?)
              ?.map((e) => UserDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PollOptionModelToJson(_PollOptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'optionText': instance.optionText,
      'optionOrder': instance.optionOrder,
      'voteCount': instance.voteCount,
      'percentage': instance.percentage,
      'voters': instance.voters,
    };

_CreatePollRequest _$CreatePollRequestFromJson(Map<String, dynamic> json) =>
    _CreatePollRequest(
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      allowMultipleVotes: json['allowMultipleVotes'] as bool? ?? false,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$CreatePollRequestToJson(_CreatePollRequest instance) =>
    <String, dynamic>{
      'question': instance.question,
      'options': instance.options,
      'allowMultipleVotes': instance.allowMultipleVotes,
      'expiresAt': _dateTimeToUtcString(instance.expiresAt),
    };

_VotePollRequest _$VotePollRequestFromJson(Map<String, dynamic> json) =>
    _VotePollRequest(
      optionIds: (json['optionIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$VotePollRequestToJson(_VotePollRequest instance) =>
    <String, dynamic>{'optionIds': instance.optionIds};

_RemoveVoteRequest _$RemoveVoteRequestFromJson(Map<String, dynamic> json) =>
    _RemoveVoteRequest(
      optionIds: (json['optionIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$RemoveVoteRequestToJson(_RemoveVoteRequest instance) =>
    <String, dynamic>{'optionIds': instance.optionIds};
