import 'package:chattrix_ui/features/chat/data/models/event_dto.dart';
import 'package:chattrix_ui/features/chat/domain/entities/event_entity.dart';
import 'package:chattrix_ui/features/auth/data/mappers/user_mapper.dart';

/// Extension to convert EventDto to EventEntity
extension EventDtoMapper on EventDto {
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
      rsvps: rsvps.map((rsvp) => rsvp.toEntity()).toList(),
    );
  }
}

/// Extension to convert EventRsvpDto to EventRsvp
extension EventRsvpDtoMapper on EventRsvpDto {
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
