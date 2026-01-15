// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'event_list_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventListItemDto _$EventListItemDtoFromJson(Map<String, dynamic> json) =>
    _EventListItemDto(
      messageId: (json['messageId'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      location: json['location'] as String?,
      going: (json['going'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      maybe: (json['maybe'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      notGoing: (json['notGoing'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      createdBy: (json['createdBy'] as num).toInt(),
      createdByUsername: json['createdByUsername'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$EventListItemDtoToJson(_EventListItemDto instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'title': instance.title,
      'description': instance.description,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'location': instance.location,
      'going': instance.going,
      'maybe': instance.maybe,
      'notGoing': instance.notGoing,
      'createdBy': instance.createdBy,
      'createdByUsername': instance.createdByUsername,
      'createdAt': instance.createdAt,
    };
