import 'package:chattrix_ui/features/auth/data/models/user_dto.dart';
import 'package:chattrix_ui/features/chat/domain/entities/event_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_dto.freezed.dart';
part 'event_dto.g.dart';

/// Event DTO for API communication
@freezed
abstract class EventDto with _$EventDto {
  const EventDto._();

  const factory EventDto({
    required int id,
    required int conversationId,
    required UserDto creator,
    required String title,
    String? description,
    required String startTime,
    required String endTime,
    String? location,
    required String createdAt,
    required String updatedAt,
    required int goingCount,
    required int maybeCount,
    required int notGoingCount,
    String? currentUserRsvpStatus,
    required List<EventRsvpDto> rsvps,
  }) = _EventDto;

  factory EventDto.fromJson(Map<String, dynamic> json) => _$EventDtoFromJson(json);

  EventEntity toEntity() {
    return EventEntity(
      id: id,
      conversationId: conversationId,
      creator: creator.toEntity(),
      title: title,
      description: description,
      startTime: DateTime.parse(startTime),
      endTime: DateTime.parse(endTime),
      location: location,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
      goingCount: goingCount,
      maybeCount: maybeCount,
      notGoingCount: notGoingCount,
      currentUserRsvpStatus: currentUserRsvpStatus,
      rsvps: rsvps.map((r) => r.toEntity()).toList(),
    );
  }
}

/// Event RSVP DTO
@freezed
abstract class EventRsvpDto with _$EventRsvpDto {
  const EventRsvpDto._();

  const factory EventRsvpDto({
    required int id,
    required UserDto user,
    required String status,
    required String createdAt,
    required String updatedAt,
  }) = _EventRsvpDto;

  factory EventRsvpDto.fromJson(Map<String, dynamic> json) => _$EventRsvpDtoFromJson(json);

  EventRsvp toEntity() {
    return EventRsvp(
      id: id,
      user: user.toEntity(),
      status: status,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}

/// Create Event Request DTO
@freezed
abstract class CreateEventRequestDto with _$CreateEventRequestDto {
  const factory CreateEventRequestDto({
    required String title,
    String? description,
    required String startTime,
    required String endTime,
    String? location,
  }) = _CreateEventRequestDto;

  factory CreateEventRequestDto.fromJson(Map<String, dynamic> json) => _$CreateEventRequestDtoFromJson(json);
}

/// Update Event Request DTO
@freezed
abstract class UpdateEventRequestDto with _$UpdateEventRequestDto {
  const factory UpdateEventRequestDto({
    String? title,
    String? description,
    String? startTime,
    String? endTime,
    String? location,
  }) = _UpdateEventRequestDto;

  factory UpdateEventRequestDto.fromJson(Map<String, dynamic> json) => _$UpdateEventRequestDtoFromJson(json);
}

/// RSVP Request DTO
@freezed
abstract class RsvpRequestDto with _$RsvpRequestDto {
  const factory RsvpRequestDto({required String status}) = _RsvpRequestDto;

  factory RsvpRequestDto.fromJson(Map<String, dynamic> json) => _$RsvpRequestDtoFromJson(json);
}
