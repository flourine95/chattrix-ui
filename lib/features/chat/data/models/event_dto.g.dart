// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventDto _$EventDtoFromJson(Map<String, dynamic> json) => _EventDto(
  id: (json['id'] as num).toInt(),
  conversationId: (json['conversationId'] as num).toInt(),
  creator: UserDto.fromJson(json['creator'] as Map<String, dynamic>),
  title: json['title'] as String,
  description: json['description'] as String?,
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  location: json['location'] as String?,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  goingCount: (json['goingCount'] as num).toInt(),
  maybeCount: (json['maybeCount'] as num).toInt(),
  notGoingCount: (json['notGoingCount'] as num).toInt(),
  currentUserRsvpStatus: json['currentUserRsvpStatus'] as String?,
  rsvps: (json['rsvps'] as List<dynamic>)
      .map((e) => EventRsvpDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$EventDtoToJson(_EventDto instance) => <String, dynamic>{
  'id': instance.id,
  'conversationId': instance.conversationId,
  'creator': instance.creator,
  'title': instance.title,
  'description': instance.description,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'location': instance.location,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'goingCount': instance.goingCount,
  'maybeCount': instance.maybeCount,
  'notGoingCount': instance.notGoingCount,
  'currentUserRsvpStatus': instance.currentUserRsvpStatus,
  'rsvps': instance.rsvps,
};

_EventRsvpDto _$EventRsvpDtoFromJson(Map<String, dynamic> json) =>
    _EventRsvpDto(
      id: (json['id'] as num).toInt(),
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$EventRsvpDtoToJson(_EventRsvpDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

_CreateEventRequestDto _$CreateEventRequestDtoFromJson(
  Map<String, dynamic> json,
) => _CreateEventRequestDto(
  title: json['title'] as String,
  description: json['description'] as String?,
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  location: json['location'] as String?,
);

Map<String, dynamic> _$CreateEventRequestDtoToJson(
  _CreateEventRequestDto instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'location': instance.location,
};

_UpdateEventRequestDto _$UpdateEventRequestDtoFromJson(
  Map<String, dynamic> json,
) => _UpdateEventRequestDto(
  title: json['title'] as String?,
  description: json['description'] as String?,
  startTime: json['startTime'] as String?,
  endTime: json['endTime'] as String?,
  location: json['location'] as String?,
);

Map<String, dynamic> _$UpdateEventRequestDtoToJson(
  _UpdateEventRequestDto instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'location': instance.location,
};

_RsvpRequestDto _$RsvpRequestDtoFromJson(Map<String, dynamic> json) =>
    _RsvpRequestDto(status: json['status'] as String);

Map<String, dynamic> _$RsvpRequestDtoToJson(_RsvpRequestDto instance) =>
    <String, dynamic>{'status': instance.status};
