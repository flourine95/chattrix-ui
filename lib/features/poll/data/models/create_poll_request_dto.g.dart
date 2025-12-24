// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'create_poll_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreatePollRequestDto _$CreatePollRequestDtoFromJson(
  Map<String, dynamic> json,
) => _CreatePollRequestDto(
  question: json['question'] as String,
  options: (json['options'] as List<dynamic>).map((e) => e as String).toList(),
  allowMultipleVotes: json['allowMultipleVotes'] as bool,
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
);

Map<String, dynamic> _$CreatePollRequestDtoToJson(
  _CreatePollRequestDto instance,
) => <String, dynamic>{
  'question': instance.question,
  'options': instance.options,
  'allowMultipleVotes': instance.allowMultipleVotes,
  'expiresAt': instance.expiresAt?.toIso8601String(),
};
