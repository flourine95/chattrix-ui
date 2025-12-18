# Requirements Document - Remaining Features Refactor

## Introduction

Refactor all remaining features (Call, Chat, Contacts, Notes, Profile) to align with the Clean Architecture template established in the auth refactor. Apply BaseRepository pattern, migrate from `dartz` to `fpdart`, update Failure types, create explicit mappers, and ensure consistency across the entire codebase.

## Glossary

- **BaseRepository**: Abstract repository class with centralized error handling logic
- **fpdart**: Functional programming library (actively maintained, replaces dartz)
- **dartz**: Functional programming library (deprecated, no longer maintained)
- **Freezed 3**: Code generation library version 3 with updated syntax
- **Riverpod 3**: State management library version 3 with code generation
- **Clean Architecture**: Layered architecture (Presentation → Domain → Data)
- **Either<L, R>**: Type representing one of two values (Left = error, Right = success)
- **ApiException**: Exception thrown from API interceptor
- **Failure**: Domain-level error representation (7 types: server, network, validation, auth, notFound, conflict, rateLimit)
- **DTO**: Data Transfer Object - model used in Data layer for API serialization
- **Entity**: Domain object - framework agnostic, uses proper Dart types
- **Mapper**: Extension methods for converting between DTO and Entity
- **Call Feature**: Voice/video calling functionality using Agora
- **Chat Feature**: Messaging functionality with text, images, voice, video
- **Contacts Feature**: User contacts and friend management
- **Notes Feature**: Personal notes functionality
- **Profile Feature**: User profile management

## Requirements

### Requirement 1: Apply BaseRepository Pattern to All Features

**User Story:** As a developer, I want all features to use BaseRepository for error handling, so that error handling is consistent and code duplication is eliminated.

#### Acceptance Criteria

1. WHEN CallRepositoryImpl is created THEN it SHALL extend BaseRepository
2. WHEN ChatRepositoryImpl is created THEN it SHALL extend BaseRepository
3. WHEN ContactsRepositoryImpl is created THEN it SHALL extend BaseRepository
4. WHEN NotesRepositoryImpl is created THEN it SHALL extend BaseRepository
5. WHEN ProfileRepositoryImpl is created THEN it SHALL extend BaseRepository
6. WHEN any repository method makes an API call THEN it SHALL use `executeApiCall()` wrapper
7. WHEN any repository is reviewed THEN it SHALL NOT contain manual try-catch blocks for ApiException or DioException
8. WHEN comparing old vs new repository code THEN the new code SHALL be ~60% shorter

### Requirement 2: Migrate All Features from dartz to fpdart

**User Story:** As a developer, I want all features to use fpdart instead of dartz, so that the codebase uses actively maintained libraries.

#### Acceptance Criteria

1. WHEN searching the codebase THEN there SHALL be zero imports of `package:dartz/dartz.dart`
2. WHEN creating Either instances THEN the code SHALL use lowercase `right()` and `left()` functions
3. WHEN using Either methods THEN the code SHALL use fpdart's API
4. WHEN building the project THEN there SHALL be no dartz-related errors or warnings
5. WHEN all features are migrated THEN pubspec.yaml SHALL NOT contain dartz dependency

### Requirement 3: Update All Failure Types to Match API Spec

**User Story:** As a developer, I want all features to use the 7 standardized Failure types, so that error handling is consistent across the application.

#### Acceptance Criteria

1. WHEN any feature creates a Failure THEN it SHALL use one of: server, network, validation, auth, notFound, conflict, rateLimit
2. WHEN creating ValidationFailure THEN it SHALL include `code` field and optional `details` map
3. WHEN creating AuthFailure THEN it SHALL include `code` field and optional `requestId`
4. WHEN creating any Failure THEN it SHALL include both `message` and `code` fields
5. WHEN API returns 400 THEN the system SHALL create ValidationFailure with details map
6. WHEN API returns 401/403 THEN the system SHALL create AuthFailure
7. WHEN API returns 404 THEN the system SHALL create NotFoundFailure
8. WHEN API returns 409 THEN the system SHALL create ConflictFailure
9. WHEN API returns 429 THEN the system SHALL create RateLimitFailure
10. WHEN network timeout occurs THEN the system SHALL create NetworkFailure with code "TIMEOUT"

### Requirement 4: Create DTOs and Mappers for All Features

**User Story:** As a developer, I want explicit DTOs and Mappers for all features, so that the separation between Data and Domain layers is clear.

#### Acceptance Criteria

1. WHEN a feature has models THEN they SHALL be renamed from `*_model.dart` to `*_dto.dart`
2. WHEN a DTO is created THEN it SHALL use `@freezed` and `@JsonSerializable` annotations
3. WHEN a DTO has nullable fields THEN it SHALL use `String?` for fields that can be omitted in API responses
4. WHEN a mapper is created THEN it SHALL be in `lib/features/[feature]/data/mappers/[name]_mapper.dart`
5. WHEN converting DTO to Entity THEN the mapper SHALL use extension method `toEntity()`
6. WHEN converting Entity to DTO THEN the mapper SHALL use extension method `toDto()`
7. WHEN mapper handles dates THEN it SHALL convert String (DTO) ↔ DateTime (Entity)
8. WHEN mapper handles enums THEN it SHALL convert String (DTO) ↔ Enum (Entity)
9. WHEN mapper handles nullable fields THEN it SHALL provide appropriate defaults or null values
10. WHEN all features are refactored THEN every DTO SHALL have a corresponding mapper

### Requirement 5: Update All Entities to Freezed 3 Standards

**User Story:** As a developer, I want all entities to follow Freezed 3 best practices, so that there are no deprecation warnings.

#### Acceptance Criteria

1. WHEN an entity has single factory constructor THEN it MAY omit `abstract class` keyword (optional but recommended for consistency)
2. WHEN an entity has multiple factory constructors THEN it MUST use `abstract class` keyword
3. WHEN an entity has generic types THEN it MUST use `abstract class` keyword
4. WHEN an entity is in Domain layer THEN it SHALL NOT import json_annotation
5. WHEN an entity uses dates THEN it SHALL use DateTime type (not String)
6. WHEN an entity uses enums THEN it SHALL use proper Dart enum types (not String)
7. WHEN building the project THEN there SHALL be no Freezed-related deprecation warnings

### Requirement 6: Refactor Call Feature

**User Story:** As a developer, I want the Call feature to use Clean Architecture patterns, so that it's consistent with the auth feature.

#### Acceptance Criteria

1. WHEN CallRepositoryImpl is refactored THEN it SHALL extend BaseRepository
2. WHEN Call DTOs are created THEN they SHALL handle: CallDto, CallParticipantDto, CallEventDto
3. WHEN Call mappers are created THEN they SHALL convert between DTOs and Entities
4. WHEN Call entities are updated THEN they SHALL use proper Dart types (DateTime, enums)
5. WHEN Call usecases are updated THEN they SHALL use fpdart instead of dartz
6. WHEN Call providers are updated THEN they SHALL handle 7 failure types
7. WHEN Call feature is complete THEN all 16 errors SHALL be resolved
8. WHEN Call feature is tested THEN initiate call, answer call, end call, and reject call SHALL work

### Requirement 7: Refactor Chat Feature

**User Story:** As a developer, I want the Chat feature to use Clean Architecture patterns, so that messaging functionality is maintainable.

#### Acceptance Criteria

1. WHEN ChatRepositoryImpl is refactored THEN it SHALL extend BaseRepository
2. WHEN Chat DTOs are created THEN they SHALL handle: MessageDto, ConversationDto, AttachmentDto, SearchUserDto
3. WHEN Chat mappers are created THEN they SHALL handle UserDto mapping (shared with auth)
4. WHEN Chat entities are updated THEN they SHALL use proper Dart types for timestamps and message types
5. WHEN Chat usecases are updated THEN they SHALL use fpdart instead of dartz
6. WHEN Chat providers are updated THEN they SHALL handle 7 failure types
7. WHEN Chat feature is complete THEN all 26 errors SHALL be resolved
8. WHEN Chat feature is tested THEN send message, receive message, upload media, and search users SHALL work

### Requirement 8: Refactor Contacts Feature

**User Story:** As a developer, I want the Contacts feature to use Clean Architecture patterns, so that friend management is consistent.

#### Acceptance Criteria

1. WHEN ContactsRepositoryImpl is refactored THEN it SHALL extend BaseRepository
2. WHEN Contacts DTOs are created THEN they SHALL handle: ContactDto, FriendRequestDto
3. WHEN Contacts mappers are created THEN they SHALL convert between DTOs and Entities
4. WHEN Contacts entities are updated THEN they SHALL use proper Dart types
5. WHEN Contacts usecases are updated THEN they SHALL use fpdart instead of dartz
6. WHEN Contacts providers are updated THEN they SHALL handle 7 failure types
7. WHEN Contacts feature is complete THEN all 48 errors SHALL be resolved
8. WHEN Contacts feature is tested THEN add friend, accept request, reject request, and remove friend SHALL work

### Requirement 9: Refactor Notes Feature

**User Story:** As a developer, I want the Notes feature to use Clean Architecture patterns, so that personal notes functionality is maintainable.

#### Acceptance Criteria

1. WHEN NotesRepositoryImpl is refactored THEN it SHALL extend BaseRepository
2. WHEN Notes DTOs are created THEN they SHALL handle: NoteDto
3. WHEN Notes mappers are created THEN they SHALL convert between DTOs and Entities
4. WHEN Notes entities are updated THEN they SHALL use proper Dart types for timestamps
5. WHEN Notes usecases are updated THEN they SHALL use fpdart instead of dartz
6. WHEN Notes providers are updated THEN they SHALL handle 7 failure types
7. WHEN Notes feature is complete THEN all errors SHALL be resolved
8. WHEN Notes feature is tested THEN create note, update note, delete note, and list notes SHALL work

### Requirement 10: Refactor Profile Feature

**User Story:** As a developer, I want the Profile feature to use Clean Architecture patterns, so that profile management is consistent with auth.

#### Acceptance Criteria

1. WHEN ProfileRepositoryImpl is refactored THEN it SHALL extend BaseRepository
2. WHEN Profile DTOs are created THEN they SHALL reuse UserDto from auth feature
3. WHEN Profile mappers are created THEN they SHALL reuse UserMapper from auth feature
4. WHEN Profile entities are updated THEN they SHALL reuse User entity from auth feature
5. WHEN Profile usecases are updated THEN they SHALL use fpdart instead of dartz
6. WHEN Profile providers are updated THEN they SHALL handle 7 failure types
7. WHEN Profile feature is complete THEN all 6 errors SHALL be resolved
8. WHEN Profile feature is tested THEN update profile, upload avatar, and get profile SHALL work

### Requirement 11: Update All Providers to Use 7 Exception Types

**User Story:** As a developer, I want all providers to use the 7 standardized exception types, so that UI error handling is consistent.

#### Acceptance Criteria

1. WHEN any provider maps Failure to Exception THEN it SHALL use one of: ServerException, NetworkException, ValidationException, AuthException, NotFoundException, ConflictException, RateLimitException
2. WHEN ValidationException is created THEN it SHALL include optional `details` map
3. WHEN any exception is created THEN it SHALL include user-friendly message
4. WHEN AuthException occurs THEN the UI SHALL redirect to login screen
5. WHEN NetworkException occurs THEN the UI SHALL show "Network error. Please check your internet connection."
6. WHEN RateLimitException occurs THEN the UI SHALL show "Too many requests. Please wait a moment."
7. WHEN ValidationException with details occurs THEN the UI SHALL show all field-specific errors

### Requirement 12: Maintain Backward Compatibility

**User Story:** As a developer, I want the refactor to maintain all existing functionality, so that no features break during migration.

#### Acceptance Criteria

1. WHEN refactor is complete THEN all existing feature flows SHALL work identically
2. WHEN user makes a call THEN call initiation, connection, and termination SHALL work
3. WHEN user sends a message THEN message delivery and receipt SHALL work
4. WHEN user uploads media THEN image/video/voice upload SHALL work
5. WHEN user manages contacts THEN add, remove, and list contacts SHALL work
6. WHEN user creates notes THEN CRUD operations SHALL work
7. WHEN user updates profile THEN profile changes SHALL persist
8. WHEN network error occurs THEN user SHALL see appropriate error message
9. WHEN validation error occurs THEN user SHALL see field-specific errors
10. WHEN any error occurs THEN app SHALL NOT crash

### Requirement 13: Remove All dartz Dependencies

**User Story:** As a developer, I want to completely remove dartz from the project, so that we only use actively maintained dependencies.

#### Acceptance Criteria

1. WHEN all features are migrated THEN pubspec.yaml SHALL NOT list dartz as a dependency
2. WHEN searching codebase for "dartz" THEN zero results SHALL be found
3. WHEN searching codebase for "Right(" THEN zero results SHALL be found (should use lowercase `right()`)
4. WHEN searching codebase for "Left(" THEN zero results SHALL be found (should use lowercase `left()`)
5. WHEN building the project THEN there SHALL be no dartz-related errors

### Requirement 14: Ensure Consistent Error Messages

**User Story:** As a user, I want to see consistent, user-friendly error messages, so that I understand what went wrong.

#### Acceptance Criteria

1. WHEN validation error occurs THEN message SHALL be "Validation failed" with field details
2. WHEN unauthorized error occurs THEN message SHALL be "Invalid or expired token"
3. WHEN forbidden error occurs THEN message SHALL be "Access denied"
4. WHEN not found error occurs THEN message SHALL be "Resource not found"
5. WHEN conflict error occurs THEN message SHALL describe the conflict (e.g., "Email already exists")
6. WHEN rate limit error occurs THEN message SHALL be "Too many requests. Please wait a moment and try again."
7. WHEN network timeout occurs THEN message SHALL be "Connection timeout"
8. WHEN no internet occurs THEN message SHALL be "No internet connection"
9. WHEN server error occurs THEN message SHALL be "Server error. Please try again later."
10. WHEN unexpected error occurs THEN message SHALL be "An unexpected error occurred"

### Requirement 15: Update All Tests

**User Story:** As a developer, I want tests to be updated for new implementation, so that test coverage is maintained.

#### Acceptance Criteria

1. WHEN repository tests are updated THEN they SHALL mock BaseRepository.executeApiCall
2. WHEN testing error handling THEN tests SHALL verify correct Failure types for each error code
3. WHEN testing mappers THEN tests SHALL verify DTO ↔ Entity conversion handles nullable fields
4. WHEN testing providers THEN tests SHALL use Riverpod 3 testing utilities
5. WHEN testing validation errors THEN tests SHALL verify details map is preserved
6. WHEN all tests run THEN they SHALL pass without errors or warnings

---

## Out of Scope

- UI/UX redesign (only refactor code structure)
- New features or functionality
- Performance optimization (beyond using fpdart)
- API endpoint changes
- Database schema changes
- WebSocket implementation changes
- Third-party service integration changes (Agora, Cloudinary, etc.)

---

## Success Criteria

1. ✅ Zero dartz imports across entire codebase
2. ✅ BaseRepository used by all 5 feature repositories
3. ✅ All 96 errors in other features resolved
4. ✅ Zero Freezed deprecation warnings
5. ✅ All feature flows work identically to before
6. ✅ Code coverage maintained or improved
7. ✅ Repository code reduced by ~60% across all features
8. ✅ Build succeeds without warnings
9. ✅ All tests pass
10. ✅ Consistent error handling across all features

---

## Feature Priority Order

Based on complexity and dependencies:

1. **Profile** (6 errors) - Simplest, reuses auth User entity/mapper
2. **Notes** (unknown errors) - Simple CRUD operations
3. **Contacts** (48 errors) - Medium complexity, friend management
4. **Call** (16 errors) - Medium complexity, real-time communication
5. **Chat** (26 errors) - Most complex, multiple DTOs, media handling

---

## Estimated Effort

- **Profile Feature**: 1 day
- **Notes Feature**: 1 day
- **Contacts Feature**: 2 days
- **Call Feature**: 2 days
- **Chat Feature**: 3 days
- **Testing & Verification**: 2 days

**Total**: ~11 days

---

## Dependencies

All features depend on:
- `lib/core/repositories/base_repository.dart` ✅ (created in auth refactor)
- `lib/core/errors/failures.dart` ✅ (updated in auth refactor)
- `lib/core/errors/exceptions.dart` ✅ (updated in auth refactor)
- `lib/core/network/api_response.dart` ✅ (created in auth refactor)
- `lib/core/network/api_interceptor.dart` ✅ (updated in auth refactor)

Profile and Chat features depend on:
- `lib/features/auth/data/models/user_dto.dart` ✅ (from auth refactor)
- `lib/features/auth/data/mappers/user_mapper.dart` ✅ (from auth refactor)
- `lib/features/auth/domain/entities/user.dart` ✅ (from auth refactor)
