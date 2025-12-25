// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'poll_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PollDto _$PollDtoFromJson(Map<String, dynamic> json) => _PollDto(
  id: (json['id'] as num).toInt(),
  question: json['question'] as String,
  conversationId: (json['conversationId'] as num).toInt(),
  creator: UserDto.fromJson(json['creator'] as Map<String, dynamic>),
  allowMultipleVotes: json['allowMultipleVotes'] as bool,
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  isClosed: json['closed'] as bool? ?? false,
  isExpired: json['expired'] as bool? ?? false,
  isActive: json['active'] as bool? ?? true,
  createdAt: DateTime.parse(json['createdAt'] as String),
  totalVoters: (json['totalVoters'] as num).toInt(),
  options: (json['options'] as List<dynamic>)
      .map((e) => PollOptionDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  currentUserVotedOptionIds:
      (json['currentUserVotedOptionIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
);

Map<String, dynamic> _$PollDtoToJson(_PollDto instance) => <String, dynamic>{
  'id': instance.id,
  'question': instance.question,
  'conversationId': instance.conversationId,
  'creator': instance.creator,
  'allowMultipleVotes': instance.allowMultipleVotes,
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'closed': instance.isClosed,
  'expired': instance.isExpired,
  'active': instance.isActive,
  'createdAt': instance.createdAt.toIso8601String(),
  'totalVoters': instance.totalVoters,
  'options': instance.options,
  'currentUserVotedOptionIds': instance.currentUserVotedOptionIds,
};
