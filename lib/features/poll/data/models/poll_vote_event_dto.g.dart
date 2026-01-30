// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'poll_vote_event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PollVoteEventDto _$PollVoteEventDtoFromJson(Map<String, dynamic> json) =>
    _PollVoteEventDto(
      messageId: (json['messageId'] as num).toInt(),
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => PollVoteOptionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      allowMultiple: json['allowMultiple'] as bool,
      anonymous: json['anonymous'] as bool,
      closesAt: json['closesAt'] as String?,
      isClosed: json['isClosed'] as bool? ?? false,
      totalVotes: (json['totalVotes'] as num).toInt(),
      createdBy: (json['createdBy'] as num).toInt(),
      createdByUsername: json['createdByUsername'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$PollVoteEventDtoToJson(_PollVoteEventDto instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'question': instance.question,
      'options': instance.options,
      'allowMultiple': instance.allowMultiple,
      'anonymous': instance.anonymous,
      'closesAt': instance.closesAt,
      'isClosed': instance.isClosed,
      'totalVotes': instance.totalVotes,
      'createdBy': instance.createdBy,
      'createdByUsername': instance.createdByUsername,
      'createdAt': instance.createdAt,
    };

_PollVoteOptionDto _$PollVoteOptionDtoFromJson(Map<String, dynamic> json) =>
    _PollVoteOptionDto(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String,
      voteCount: (json['voteCount'] as num).toInt(),
      voterIds: (json['voterIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      hasVoted: json['hasVoted'] as bool?,
    );

Map<String, dynamic> _$PollVoteOptionDtoToJson(_PollVoteOptionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'voteCount': instance.voteCount,
      'voterIds': instance.voterIds,
      'hasVoted': instance.hasVoted,
    };
