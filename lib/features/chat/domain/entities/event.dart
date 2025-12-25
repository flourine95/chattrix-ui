import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';

part 'event.freezed.dart';

/// Domain entity for event
/// Framework-agnostic - NO Flutter/Dio/json_annotation imports
@freezed
abstract class Event with _$Event {
  const factory Event({
    required int id,
    required int conversationId,
    required User creator,
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int goingCount,
    required int maybeCount,
    required int notGoingCount,
    String? currentUserRsvpStatus,
    required List<EventRsvp> rsvps,
  }) = _Event;
}

/// Domain entity for event RSVP
@freezed
abstract class EventRsvp with _$EventRsvp {
  const factory EventRsvp({
    required int id,
    required User user,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _EventRsvp;
}
