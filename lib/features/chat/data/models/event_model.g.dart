// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventModel _$EventModelFromJson(Map<String, dynamic> json) => _EventModel(
  id: (json['id'] as num).toInt(),
  conversationId: (json['conversationId'] as num).toInt(),
  creator: UserDto.fromJson(json['creator'] as Map<String, dynamic>),
  title: json['title'] as String,
  description: json['description'] as String?,
  startTime: DateTime.parse(json['startTime'] as String),
  endTime: DateTime.parse(json['endTime'] as String),
  location: json['location'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  goingCount: (json['goingCount'] as num?)?.toInt() ?? 0,
  maybeCount: (json['maybeCount'] as num?)?.toInt() ?? 0,
  notGoingCount: (json['notGoingCount'] as num?)?.toInt() ?? 0,
  currentUserRsvpStatus: json['currentUserRsvpStatus'] as String?,
  rsvps:
      (json['rsvps'] as List<dynamic>?)
          ?.map((e) => EventRsvpModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$EventModelToJson(_EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'creator': instance.creator,
      'title': instance.title,
      'description': instance.description,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'location': instance.location,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'goingCount': instance.goingCount,
      'maybeCount': instance.maybeCount,
      'notGoingCount': instance.notGoingCount,
      'currentUserRsvpStatus': instance.currentUserRsvpStatus,
      'rsvps': instance.rsvps,
    };

_EventRsvpModel _$EventRsvpModelFromJson(Map<String, dynamic> json) =>
    _EventRsvpModel(
      id: (json['id'] as num).toInt(),
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$EventRsvpModelToJson(_EventRsvpModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_CreateEventRequest _$CreateEventRequestFromJson(Map<String, dynamic> json) =>
    _CreateEventRequest(
      title: json['title'] as String,
      description: json['description'] as String?,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      location: json['location'] as String?,
    );

Map<String, dynamic> _$CreateEventRequestToJson(_CreateEventRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'location': instance.location,
    };

_UpdateEventRequest _$UpdateEventRequestFromJson(Map<String, dynamic> json) =>
    _UpdateEventRequest(
      title: json['title'] as String?,
      description: json['description'] as String?,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      location: json['location'] as String?,
    );

Map<String, dynamic> _$UpdateEventRequestToJson(_UpdateEventRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'location': instance.location,
    };

_RsvpEventRequest _$RsvpEventRequestFromJson(Map<String, dynamic> json) =>
    _RsvpEventRequest(status: json['status'] as String);

Map<String, dynamic> _$RsvpEventRequestToJson(_RsvpEventRequest instance) =>
    <String, dynamic>{'status': instance.status};
