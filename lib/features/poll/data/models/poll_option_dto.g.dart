// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'poll_option_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PollOptionDto _$PollOptionDtoFromJson(Map<String, dynamic> json) =>
    _PollOptionDto(
      id: (json['id'] as num).toInt(),
      optionText: json['optionText'] as String,
      optionOrder: (json['optionOrder'] as num).toInt(),
      voteCount: (json['voteCount'] as num).toInt(),
      percentage: (json['percentage'] as num).toDouble(),
      voters: (json['voters'] as List<dynamic>)
          .map((e) => UserDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PollOptionDtoToJson(_PollOptionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'optionText': instance.optionText,
      'optionOrder': instance.optionOrder,
      'voteCount': instance.voteCount,
      'percentage': instance.percentage,
      'voters': instance.voters,
    };
