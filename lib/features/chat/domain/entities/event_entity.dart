import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_entity.freezed.dart';

/// Event entity - framework agnostic
@freezed
abstract class EventEntity with _$EventEntity {
  const factory EventEntity({
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
  }) = _EventEntity;
}

/// Event RSVP entity
@freezed
abstract class EventRsvp with _$EventRsvp {
  const factory EventRsvp({
    required int id,
    required User user,
    required String status, // GOING, MAYBE, NOT_GOING
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _EventRsvp;
}

/// RSVP Status enum
enum RsvpStatus {
  going('GOING'),
  maybe('MAYBE'),
  notGoing('NOT_GOING');

  final String value;

  const RsvpStatus(this.value);

  static RsvpStatus fromString(String value) {
    return RsvpStatus.values.firstWhere((e) => e.value == value, orElse: () => RsvpStatus.maybe);
  }
}
