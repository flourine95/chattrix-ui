// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'poll_list_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PollListItemDto _$PollListItemDtoFromJson(Map<String, dynamic> json) =>
    _PollListItemDto(
      messageId: (json['messageId'] as num).toInt(),
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => PollListOptionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      allowMultiple: json['allowMultiple'] as bool,
      anonymous: json['anonymous'] as bool,
      isClosed: json['isClosed'] as bool,
      totalVotes: (json['totalVotes'] as num).toInt(),
      createdBy: (json['createdBy'] as num).toInt(),
      createdByUsername: json['createdByUsername'] as String,
      createdByFullName: json['createdByFullName'] as String?,
      createdByAvatarUrl: json['createdByAvatarUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$PollListItemDtoToJson(_PollListItemDto instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'question': instance.question,
      'options': instance.options,
      'allowMultiple': instance.allowMultiple,
      'anonymous': instance.anonymous,
      'isClosed': instance.isClosed,
      'totalVotes': instance.totalVotes,
      'createdBy': instance.createdBy,
      'createdByUsername': instance.createdByUsername,
      'createdByFullName': instance.createdByFullName,
      'createdByAvatarUrl': instance.createdByAvatarUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
    };

_PollListOptionDto _$PollListOptionDtoFromJson(Map<String, dynamic> json) =>
    _PollListOptionDto(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String,
      voteCount: (json['voteCount'] as num).toInt(),
      voterIds: (json['voterIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      hasVoted: json['hasVoted'] as bool,
    );

Map<String, dynamic> _$PollListOptionDtoToJson(_PollListOptionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'voteCount': instance.voteCount,
      'voterIds': instance.voterIds,
      'hasVoted': instance.hasVoted,
    };
