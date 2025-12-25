import '../models/event_model.dart';
import '../../domain/entities/event.dart';
import 'package:chattrix_ui/features/auth/data/mappers/user_mapper.dart';

extension EventModelMapper on EventModel {
  Event toEntity() {
    return Event(
      id: id,
      conversationId: conversationId,
      creator: creator.toEntity(),
      title: title,
      description: description,
      startTime: startTime,
      endTime: endTime,
      location: location,
      createdAt: createdAt,
      updatedAt: updatedAt,
      goingCount: goingCount,
      maybeCount: maybeCount,
      notGoingCount: notGoingCount,
      currentUserRsvpStatus: currentUserRsvpStatus,
      rsvps: rsvps.map((rsvp) => rsvp.toEntity()).toList(),
    );
  }
}

extension EventRsvpModelMapper on EventRsvpModel {
  EventRsvp toEntity() {
    return EventRsvp(id: id, user: user.toEntity(), status: status, createdAt: createdAt, updatedAt: updatedAt);
  }
}
