import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/chat/domain/entities/event_entity.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';

part 'event_list_item_dto.freezed.dart';
part 'event_list_item_dto.g.dart';

/// Event List Item DTO - matches actual API response from GET /v1/conversations/{id}/events
@freezed
abstract class EventListItemDto with _$EventListItemDto {
  const EventListItemDto._();

  const factory EventListItemDto({
    required int messageId,
    required String title,
    String? description,
    required String startTime,
    required String endTime,
    String? location,
    required List<int> going,
    required List<int> maybe,
    required List<int> notGoing,
    required int createdBy,
    required String createdByUsername,
    required String createdAt,
  }) = _EventListItemDto;

  factory EventListItemDto.fromJson(Map<String, dynamic> json) =>
      _$EventListItemDtoFromJson(json);

  /// Convert to EventEntity with optional creator from cache
  EventEntity toEntity({User? creatorFromCache}) {
    // Create minimal creator if not provided from cache
    final creator = creatorFromCache ?? User(
      id: createdBy,
      username: createdByUsername,
      email: '',
      emailVerified: false,
      fullName: createdByUsername, // Use username as fallback
      avatarUrl: null,
      bio: null,
      gender: null,
      dateOfBirth: null,
      location: null,
      profileVisibility: null, // Nullable in User entity
      lastSeen: null,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(createdAt),
    );

    return EventEntity(
      id: messageId,
      conversationId: 0, // Will be set by caller
      creator: creator,
      title: title,
      description: description,
      startTime: DateTime.parse(startTime),
      endTime: DateTime.parse(endTime),
      location: location,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(createdAt),
      goingCount: going.length,
      maybeCount: maybe.length,
      notGoingCount: notGoing.length,
      currentUserRsvpStatus: null, // Not provided in list
      rsvps: [], // Not provided in list
    );
  }
}
