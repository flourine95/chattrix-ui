# Requirements Document - API Integration Update

## Introduction

This document defines the requirements for integrating the updated Chattrix backend API specifications into the Flutter UI application. The integration includes new endpoints for conversation management, settings, message features, polls, events, invite links, and social features. This update ensures the client application can leverage all backend capabilities following Clean Architecture principles and the established API flow template.

## Glossary

- **API_Service**: Data layer service responsible for making HTTP requests to backend endpoints
- **Repository**: Data layer component that implements domain repository interfaces and handles API responses
- **DTO**: Data Transfer Object used for API request/response serialization
- **Entity**: Domain layer model representing business objects
- **Mapper**: Component that converts between DTOs and Entities
- **Conversation_API**: Backend API endpoints for conversation management
- **Settings_API**: Backend API endpoints for conversation settings and preferences
- **Message_Features_API**: Backend API endpoints for pinned messages, scheduled messages, and search
- **Poll_API**: Backend API endpoints for poll creation and voting
- **Event_API**: Backend API endpoints for event management and RSVP
- **Invite_Link_API**: Backend API endpoints for group invite link management
- **Social_API**: Backend API endpoints for birthdays, announcements, and mutual groups
- **System**: The Chattrix Flutter application

## Requirements

### Requirement 1: Update Conversation API Services

**User Story:** As a developer, I want to update the conversation API services with new endpoints, so that the application can use all conversation management features provided by the backend.

#### Acceptance Criteria

1. WHEN implementing conversation list API, THE System SHALL call `GET /v1/conversations` with filter, limit, and cursor parameters
2. WHEN implementing conversation details API, THE System SHALL call `GET /v1/conversations/{conversationId}` to retrieve full conversation information
3. WHEN implementing conversation creation API, THE System SHALL call `POST /v1/conversations` with type and participantIds
4. WHEN implementing conversation update API, THE System SHALL call `PUT /v1/conversations/{conversationId}` with name and description fields
5. WHEN implementing conversation deletion API, THE System SHALL call `DELETE /v1/conversations/{conversationId}`
6. WHEN implementing member list API, THE System SHALL call `GET /v1/conversations/{conversationId}/members` with pagination support
7. WHEN implementing add members API, THE System SHALL call `POST /v1/conversations/{conversationId}/members` with userIds array
8. WHEN implementing remove member API, THE System SHALL call `DELETE /v1/conversations/{conversationId}/members/{userId}`
9. WHEN implementing update member role API, THE System SHALL call `PUT /v1/conversations/{conversationId}/members/{userId}/role` with role field
10. WHEN implementing leave conversation API, THE System SHALL call `POST /v1/conversations/{conversationId}/members/leave`

### Requirement 2: Implement Conversation Settings API

**User Story:** As a developer, I want to implement conversation settings API endpoints, so that users can customize their conversation preferences.

#### Acceptance Criteria

1. WHEN implementing get settings API, THE System SHALL call `GET /v1/conversations/{conversationId}/settings` to retrieve user-specific settings
2. WHEN implementing update settings API, THE System SHALL call `PUT /v1/conversations/{conversationId}/settings` with customNickname, theme, and notificationsEnabled fields
3. WHEN implementing mute API, THE System SHALL call `POST /v1/conversations/{conversationId}/settings/mute`
4. WHEN implementing unmute API, THE System SHALL call `POST /v1/conversations/{conversationId}/settings/unmute`
5. WHEN implementing pin API, THE System SHALL call `POST /v1/conversations/{conversationId}/settings/pin`
6. WHEN implementing unpin API, THE System SHALL call `POST /v1/conversations/{conversationId}/settings/unpin`
7. WHEN implementing hide API, THE System SHALL call `POST /v1/conversations/{conversationId}/settings/hide`
8. WHEN implementing unhide API, THE System SHALL call `POST /v1/conversations/{conversationId}/settings/unhide`
9. WHEN implementing archive API, THE System SHALL call `POST /v1/conversations/{conversationId}/settings/archive`
10. WHEN implementing unarchive API, THE System SHALL call `POST /v1/conversations/{conversationId}/settings/unarchive`
11. WHEN implementing block API for DIRECT conversations, THE System SHALL call `POST /v1/conversations/{conversationId}/settings/block`
12. WHEN implementing unblock API for DIRECT conversations, THE System SHALL call `POST /v1/conversations/{conversationId}/settings/unblock`

### Requirement 3: Implement Group Permissions API

**User Story:** As a developer, I want to implement group permissions API, so that admins can control what members can do in group conversations.

#### Acceptance Criteria

1. WHEN implementing get permissions API, THE System SHALL call `GET /v1/conversations/{conversationId}/settings/permissions`
2. WHEN implementing update permissions API, THE System SHALL call `PUT /v1/conversations/{conversationId}/settings/permissions` with permission fields
3. WHEN implementing mute member API, THE System SHALL call `POST /v1/conversations/{conversationId}/settings/members/{userId}/mute` with duration field
4. WHEN implementing unmute member API, THE System SHALL call `POST /v1/conversations/{conversationId}/settings/members/{userId}/unmute`
5. WHEN receiving permissions response, THE System SHALL map sendMessages, addMembers, removeMembers, editGroupInfo, pinMessages, deleteMessages, and createPolls fields

### Requirement 4: Implement Group Avatar Management API

**User Story:** As a developer, I want to implement group avatar management API, so that users can update and remove group avatars.

#### Acceptance Criteria

1. WHEN implementing update avatar API, THE System SHALL call `PUT /v1/conversations/{conversationId}/avatar` with multipart/form-data
2. WHEN implementing delete avatar API, THE System SHALL call `DELETE /v1/conversations/{conversationId}/avatar`
3. WHEN uploading avatar, THE System SHALL compress the image before sending to the API
4. WHEN avatar update succeeds, THE System SHALL update the local conversation entity with the new avatar URL

### Requirement 5: Implement Pinned Messages API

**User Story:** As a developer, I want to implement pinned messages API, so that users can pin and unpin important messages in conversations.

#### Acceptance Criteria

1. WHEN implementing pin message API, THE System SHALL call `POST /v1/conversations/{conversationId}/messages/{messageId}/pin`
2. WHEN implementing unpin message API, THE System SHALL call `DELETE /v1/conversations/{conversationId}/messages/{messageId}/pin`
3. WHEN implementing get pinned messages API, THE System SHALL call `GET /v1/conversations/{conversationId}/messages/pinned`
4. WHEN receiving pinned message response, THE System SHALL map pinnedAt, pinnedBy, pinnedByUsername, and pinnedByFullName fields

### Requirement 6: Implement Scheduled Messages API

**User Story:** As a developer, I want to implement scheduled messages API, so that users can schedule messages to be sent at a future time.

#### Acceptance Criteria

1. WHEN implementing create scheduled message API, THE System SHALL call `POST /v1/conversations/{conversationId}/messages/schedule` with content, type, and scheduledTime fields
2. WHEN implementing get scheduled messages API, THE System SHALL call `GET /v1/conversations/{conversationId}/messages/scheduled` with pagination
3. WHEN implementing get scheduled message details API, THE System SHALL call `GET /v1/conversations/{conversationId}/messages/scheduled/{scheduledMessageId}`
4. WHEN implementing update scheduled message API, THE System SHALL call `PUT /v1/conversations/{conversationId}/messages/scheduled/{scheduledMessageId}` with content and scheduledTime fields
5. WHEN implementing cancel scheduled message API, THE System SHALL call `DELETE /v1/conversations/{conversationId}/messages/scheduled/{scheduledMessageId}`
6. WHEN implementing bulk cancel API, THE System SHALL call `DELETE /v1/conversations/{conversationId}/messages/scheduled/bulk` with scheduledMessageIds array
7. WHEN receiving scheduled message response, THE System SHALL map scheduledTime and scheduledStatus fields

### Requirement 7: Implement Message Search API

**User Story:** As a developer, I want to implement message search API, so that users can search for messages and media in conversations.

#### Acceptance Criteria

1. WHEN implementing search messages API, THE System SHALL call `GET /v1/conversations/{conversationId}/search/messages` with query, limit, and cursor parameters
2. WHEN implementing search media API, THE System SHALL call `GET /v1/conversations/{conversationId}/search/media` with type, limit, and cursor parameters
3. WHEN searching messages, THE System SHALL support filtering by query text
4. WHEN searching media, THE System SHALL support filtering by type (IMAGE, VIDEO, FILE, etc.)

### Requirement 8: Update Poll API Services

**User Story:** As a developer, I want to update poll API services with new endpoints, so that the application supports all poll management features.

#### Acceptance Criteria

1. WHEN implementing create poll API, THE System SHALL call `POST /v1/conversations/{conversationId}/polls` with question, options, allowMultipleVotes, and expiresAt fields
2. WHEN implementing vote API, THE System SHALL call `POST /v1/conversations/{conversationId}/polls/{pollId}/vote` with optionIds array
3. WHEN implementing remove vote API, THE System SHALL call `DELETE /v1/conversations/{conversationId}/polls/{pollId}/vote` with optionIds array
4. WHEN implementing close poll API, THE System SHALL call `POST /v1/conversations/{conversationId}/polls/{pollId}/close`
5. WHEN implementing delete poll API, THE System SHALL call `DELETE /v1/conversations/{conversationId}/polls/{pollId}`
6. WHEN receiving poll response, THE System SHALL map creator, totalVoters, options with voters, and currentUserVotedOptionIds fields

### Requirement 9: Implement Event Management API

**User Story:** As a developer, I want to implement event management API, so that users can create and manage events in group conversations.

#### Acceptance Criteria

1. WHEN implementing create event API, THE System SHALL call `POST /v1/conversations/{conversationId}/events` with title, description, startTime, endTime, and location fields
2. WHEN implementing update event API, THE System SHALL call `PUT /v1/conversations/{conversationId}/events/{eventId}` with event fields
3. WHEN implementing RSVP API, THE System SHALL call `POST /v1/conversations/{conversationId}/events/{eventId}/rsvp` with status field (GOING, MAYBE, NOT_GOING)
4. WHEN implementing get events API, THE System SHALL call `GET /v1/conversations/{conversationId}/events`
5. WHEN receiving event response, THE System SHALL map creator, goingCount, maybeCount, notGoingCount, currentUserRsvpStatus, and rsvps fields

### Requirement 10: Update Invite Links API

**User Story:** As a developer, I want to update invite links API with new endpoints, so that the application supports all invite link features.

#### Acceptance Criteria

1. WHEN implementing create invite link API, THE System SHALL call `POST /v1/conversations/{conversationId}/invite-links` with expiresInDays and maxUses fields
2. WHEN implementing get invite links API, THE System SHALL call `GET /v1/conversations/{conversationId}/invite-links` with pagination
3. WHEN implementing revoke invite link API, THE System SHALL call `DELETE /v1/conversations/{conversationId}/invite-links/{linkId}`
4. WHEN implementing get link info API, THE System SHALL call `GET /v1/invite-links/{token}` without authentication
5. WHEN implementing join via link API, THE System SHALL call `POST /v1/invite-links/{token}/join` with authentication
6. WHEN receiving invite link response, THE System SHALL map token, createdBy, createdByUsername, maxUses, currentUses, revoked, and valid fields

### Requirement 11: Implement Birthday and Announcements API

**User Story:** As a developer, I want to implement birthday and announcements API, so that users can see birthdays and create announcements.

#### Acceptance Criteria

1. WHEN implementing get birthdays today API, THE System SHALL call `GET /v1/birthdays/today`
2. WHEN implementing send birthday wishes API, THE System SHALL call `POST /v1/birthdays/send-wishes` with userId, conversationIds, and customMessage fields
3. WHEN implementing create announcement API, THE System SHALL call `POST /v1/conversations/{conversationId}/announcements` with content field
4. WHEN receiving birthday response, THE System SHALL map userId, username, fullName, avatarUrl, dateOfBirth, age, and birthdayMessage fields

### Requirement 12: Implement Mutual Groups API

**User Story:** As a developer, I want to implement mutual groups API, so that users can see which groups they share with other users.

#### Acceptance Criteria

1. WHEN implementing get mutual groups API, THE System SHALL call `GET /v1/users/{userId}/mutual-groups`
2. WHEN receiving mutual groups response, THE System SHALL map conversation data with participants

### Requirement 13: Update Data Models and DTOs

**User Story:** As a developer, I want to create and update DTOs for new API endpoints, so that request and response data can be properly serialized.

#### Acceptance Criteria

1. WHEN creating DTOs, THE System SHALL use @freezed annotation for immutability
2. WHEN creating DTOs, THE System SHALL use @JsonSerializable for JSON serialization
3. WHEN creating DTOs, THE System SHALL define separate request and response DTOs where appropriate
4. WHEN creating DTOs, THE System SHALL use nullable fields for optional API fields
5. WHEN creating DTOs, THE System SHALL follow the naming convention [Name]RequestDto and [Name]ResponseDto

### Requirement 14: Update Domain Entities

**User Story:** As a developer, I want to update domain entities to reflect new API data, so that the domain layer has complete business models.

#### Acceptance Criteria

1. WHEN creating entities, THE System SHALL use @freezed annotation without json_serializable
2. WHEN creating entities, THE System SHALL keep entities framework-agnostic (no Flutter, Dio, or json_annotation imports)
3. WHEN creating entities, THE System SHALL define entities in the domain layer
4. WHEN updating existing entities, THE System SHALL add new fields from API responses

### Requirement 15: Implement Mappers

**User Story:** As a developer, I want to implement mappers between DTOs and Entities, so that data can be converted between layers.

#### Acceptance Criteria

1. WHEN creating mappers, THE System SHALL use extension methods on DTO classes
2. WHEN creating mappers, THE System SHALL implement toEntity() method to convert DTO to Entity
3. WHEN creating mappers, THE System SHALL implement toDto() method to convert Entity to DTO where needed
4. WHEN mapping data, THE System SHALL handle nullable fields appropriately

### Requirement 16: Update Repositories

**User Story:** As a developer, I want to update repositories to use new API services, so that the domain layer can access new backend features.

#### Acceptance Criteria

1. WHEN implementing repositories, THE System SHALL extend BaseRepository for error handling
2. WHEN implementing repositories, THE System SHALL use executeApiCall() wrapper for all API calls
3. WHEN implementing repositories, THE System SHALL return Either<Failure, T> for all operations
4. WHEN implementing repositories, THE System SHALL map DTOs to Entities before returning
5. WHEN API returns success with data, THE System SHALL return right(entity)
6. WHEN API returns error, THE System SHALL return left(failure)

### Requirement 17: Error Handling

**User Story:** As a developer, I want consistent error handling across all API integrations, so that errors are properly communicated to users.

#### Acceptance Criteria

1. WHEN API returns 400, THE System SHALL map to ValidationFailure with error details
2. WHEN API returns 401, THE System SHALL map to AuthFailure
3. WHEN API returns 403, THE System SHALL map to AuthFailure with permission denied message
4. WHEN API returns 404, THE System SHALL map to NotFoundFailure
5. WHEN API returns 409, THE System SHALL map to ConflictFailure
6. WHEN API returns 429, THE System SHALL map to RateLimitFailure
7. WHEN network timeout occurs, THE System SHALL map to NetworkFailure
8. WHEN network connection fails, THE System SHALL map to NetworkFailure
9. WHEN unexpected error occurs, THE System SHALL map to ServerFailure

### Requirement 18: API Response Validation

**User Story:** As a developer, I want to validate API responses, so that the application handles unexpected data gracefully.

#### Acceptance Criteria

1. WHEN API returns success=true with null data, THE System SHALL throw ApiException
2. WHEN API returns success=false, THE System SHALL throw ApiException with message and code
3. WHEN API response cannot be parsed, THE System SHALL throw ApiException
4. WHEN required fields are missing, THE System SHALL throw ApiException

### Requirement 19: Pagination Support

**User Story:** As a developer, I want to implement cursor-based pagination for list endpoints, so that large datasets can be loaded efficiently.

#### Acceptance Criteria

1. WHEN implementing paginated endpoints, THE System SHALL support limit parameter
2. WHEN implementing paginated endpoints, THE System SHALL support cursor parameter
3. WHEN receiving paginated response, THE System SHALL map meta.nextCursor field
4. WHEN receiving paginated response, THE System SHALL map meta.hasNextPage field
5. WHEN receiving paginated response, THE System SHALL map meta.itemsPerPage field

### Requirement 20: Code Generation

**User Story:** As a developer, I want to use code generation for DTOs and providers, so that boilerplate code is automatically generated.

#### Acceptance Criteria

1. WHEN creating DTOs, THE System SHALL run `dart run build_runner build --delete-conflicting-outputs` to generate code
2. WHEN creating providers, THE System SHALL run build_runner to generate provider code
3. WHEN generated files exist, THE System SHALL include them in version control
4. WHEN DTO or provider changes, THE System SHALL regenerate code before testing

### Requirement 21: Testing

**User Story:** As a developer, I want to test API integrations, so that I can verify they work correctly.

#### Acceptance Criteria

1. WHEN testing repositories, THE System SHALL mock API services
2. WHEN testing repositories, THE System SHALL verify correct API methods are called
3. WHEN testing repositories, THE System SHALL verify DTOs are mapped to Entities correctly
4. WHEN testing repositories, THE System SHALL verify error handling works correctly
5. WHEN testing repositories, THE System SHALL verify Either<Failure, T> is returned correctly

### Requirement 22: Documentation

**User Story:** As a developer, I want API methods to be documented, so that other developers understand how to use them.

#### Acceptance Criteria

1. WHEN implementing API methods, THE System SHALL include dartdoc comments describing the endpoint
2. WHEN implementing API methods, THE System SHALL document the HTTP method and path
3. WHEN implementing API methods, THE System SHALL document possible error codes
4. WHEN implementing API methods, THE System SHALL document required parameters

### Requirement 23: Backward Compatibility

**User Story:** As a developer, I want to maintain backward compatibility, so that existing features continue to work.

#### Acceptance Criteria

1. WHEN updating existing API methods, THE System SHALL not break existing functionality
2. WHEN adding new fields to entities, THE System SHALL make them nullable if not guaranteed by API
3. WHEN updating DTOs, THE System SHALL maintain existing field names unless API changed
4. WHEN updating repositories, THE System SHALL maintain existing method signatures

### Requirement 24: Performance Optimization

**User Story:** As a developer, I want API integrations to be performant, so that the application remains responsive.

#### Acceptance Criteria

1. WHEN making API calls, THE System SHALL use appropriate timeout values
2. WHEN loading lists, THE System SHALL use pagination to limit data transfer
3. WHEN uploading images, THE System SHALL compress them before sending
4. WHEN caching is appropriate, THE System SHALL implement caching strategies

