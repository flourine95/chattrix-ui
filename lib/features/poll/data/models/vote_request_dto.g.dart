// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'vote_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VoteRequestDto _$VoteRequestDtoFromJson(Map<String, dynamic> json) =>
    _VoteRequestDto(
      optionIds: (json['optionIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$VoteRequestDtoToJson(_VoteRequestDto instance) =>
    <String, dynamic>{'optionIds': instance.optionIds};
