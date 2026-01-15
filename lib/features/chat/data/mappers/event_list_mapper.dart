import '../models/event_list_item_dto.dart';
import '../../domain/entities/event_entity.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../../core/domain/enums/profile_visibility.dart';

extension EventListItemMapper on EventListItemDto {
  EventEntity toEntity({
    User? creatorFromCache,
  }) {
    // Calculate counts
    final goingCount = going.length;
    final maybeCount = maybe.length;
    final notGoingCount = notGoing.length;

    // Use creator from cache if available, otherwise create minimal User
    final creator = creatorFromCache ?? User(
      id: createdBy,
      username: createdByUsername,
      email: '', // Not provided in list API
      emailVerified: false,
      fullName: createdByUsername, // Fallback to username
      avatarUrl: null,
      bio: null,
      gender: null,
      dateOfBirth: null,
      location: null,
      profileVisibility: ProfileVisibility.public,
      lastSeen: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return EventEntity(
      id: messageId,
      conversationId: 0, // Will be set by provider
      creator: creator,
      title: title,
      description: description,
      startTime: DateTime.parse(startTime),
      endTime: DateTime.parse(endTime),
      location: location,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(createdAt), // Use createdAt as updatedAt
      goingCount: goingCount,
      maybeCount: maybeCount,
      notGoingCount: notGoingCount,
      currentUserRsvpStatus: null, // Not provided in list API
      rsvps: [], // Not provided in list API
    );
  }
}
