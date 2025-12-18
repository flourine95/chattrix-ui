# Requirements Document - Auth Feature Refactor

## Introduction

Refactor Auth feature để tuân thủ Clean Architecture template mới nhất, migrate từ `dartz` sang `fpdart`, và áp dụng BaseRepository pattern để giảm code duplication. Đồng thời fix các deprecated patterns và đảm bảo tương thích với Riverpod 3, Freezed 3, và các dependencies mới nhất.

## Glossary

- **Auth Feature**: Authentication feature bao gồm login, register, logout, password management
- **BaseRepository**: Abstract repository class chứa common error handling logic
- **fpdart**: Functional programming library thay thế dartz (actively maintained)
- **dartz**: Functional programming library (deprecated, không còn maintain)
- **Freezed 3**: Code generation library version 3 với syntax mới
- **Riverpod 3**: State management library version 3 với code generation
- **Clean Architecture**: Kiến trúc phân tầng (Presentation → Domain → Data)
- **Either<L, R>**: Type đại diện cho một trong hai giá trị (Left = error, Right = success)
- **ApiException**: Exception được throw từ API interceptor
- **Failure**: Domain-level error representation
- **DTO**: Data Transfer Object - model dùng trong Data layer
- **Entity**: Domain object - framework agnostic
- **Mapper**: Convert giữa DTO và Entity

## Requirements

### Requirement 1: Migration từ dartz sang fpdart

**User Story:** As a developer, I want to use fpdart instead of dartz, so that the codebase uses actively maintained libraries with better null-safety support.

#### Acceptance Criteria

1. WHEN importing functional programming utilities THEN the system SHALL use `package:fpdart/fpdart.dart` instead of `package:dartz/dartz.dart`
2. WHEN creating Either instances THEN the system SHALL use lowercase `right()` and `left()` functions instead of `Right()` and `Left()` constructors
3. WHEN using Either methods THEN the system SHALL use fpdart's API which is compatible with dartz
4. WHEN building the project THEN the system SHALL NOT have any import errors or deprecation warnings related to dartz
5. WHEN running tests THEN all tests SHALL pass with fpdart implementation

### Requirement 2: Implement BaseRepository Pattern

**User Story:** As a developer, I want to use BaseRepository for common error handling, so that I don't repeat error handling code in every repository.

#### Acceptance Criteria

1. WHEN creating a new repository THEN the system SHALL extend BaseRepository abstract class
2. WHEN an API call throws ApiException THEN BaseRepository SHALL automatically convert it to appropriate Failure type
3. WHEN an API call throws DioException THEN BaseRepository SHALL automatically convert it to NetworkFailure or ServerFailure
4. WHEN an API call throws unexpected exception THEN BaseRepository SHALL convert it to ServerFailure with UNEXPECTED_ERROR code
5. WHEN using executeApiCall wrapper THEN the repository SHALL return Either<Failure, T> without manual try-catch blocks
6. WHEN error handling logic needs update THEN the developer SHALL only update BaseRepository once for all repositories

### Requirement 3: Update Failure Types theo API Spec

**User Story:** As a developer, I want Failure types to match API error codes exactly, so that error handling is consistent with backend responses.

#### Acceptance Criteria

1. WHEN API returns 400 with code "VALIDATION_ERROR" and details map THEN the system SHALL create ValidationFailure with message "Validation failed" and details containing field-specific errors
2. WHEN API returns 401 with code "UNAUTHORIZED" THEN the system SHALL create AuthFailure with the error message from API
3. WHEN API returns 403 with code "FORBIDDEN" THEN the system SHALL create AuthFailure with the error message from API
4. WHEN API returns 404 with code "RESOURCE_NOT_FOUND" THEN the system SHALL create NotFoundFailure with the error message from API
5. WHEN API returns 409 with code "CONFLICT" THEN the system SHALL create ConflictFailure with the error message from API
6. WHEN API returns 429 with code "RATE_LIMIT_EXCEEDED" THEN the system SHALL create RateLimitFailure with the error message from API
7. WHEN network timeout occurs THEN the system SHALL create NetworkFailure with message "Connection timeout" and code "TIMEOUT"
8. WHEN no internet connection THEN the system SHALL create NetworkFailure with message "No internet connection" and code "NO_CONNECTION"
9. WHEN API error response contains requestId THEN the system SHALL preserve it for debugging purposes
10. WHEN validation error contains multiple field errors THEN the system SHALL preserve all field-error mappings in details map

### Requirement 4: Fix Deprecated Freezed Patterns

**User Story:** As a developer, I want to use Freezed 3 syntax correctly, so that there are no deprecation warnings and the code follows best practices.

#### Acceptance Criteria

1. WHEN defining freezed classes THEN the system SHALL NOT use `abstract class` keyword with `@freezed` annotation
2. WHEN defining freezed classes THEN the system SHALL use `class` keyword directly with `@freezed` annotation
3. WHEN defining freezed entities in Domain layer THEN the system SHALL NOT import json_annotation
4. WHEN defining freezed DTOs in Data layer THEN the system SHALL use both `@freezed` and `@JsonSerializable` annotations
5. WHEN building the project THEN the system SHALL NOT show any Freezed-related deprecation warnings

### Requirement 5: Tạo Mappers cho DTO ↔ Entity

**User Story:** As a developer, I want explicit mappers between DTOs and Entities, so that the conversion logic is clear and maintainable.

#### Acceptance Criteria

1. WHEN converting DTO to Entity THEN the system SHALL use extension method `toEntity()` on DTO
2. WHEN converting Entity to DTO THEN the system SHALL use extension method `toDto()` on Entity
3. WHEN mapper is defined THEN it SHALL be in separate file `lib/features/auth/data/mappers/[name]_mapper.dart`
4. WHEN DTO has nullable fields THEN mapper SHALL handle null values correctly
5. WHEN Entity has required fields THEN mapper SHALL provide default values or throw clear error if DTO field is null

### Requirement 6: Refactor AuthRepository Implementation

**User Story:** As a developer, I want AuthRepository to use BaseRepository pattern, so that error handling is consistent and code is cleaner.

#### Acceptance Criteria

1. WHEN AuthRepositoryImpl is defined THEN it SHALL extend BaseRepository
2. WHEN implementing repository methods THEN they SHALL use `executeApiCall()` wrapper
3. WHEN API call succeeds THEN the method SHALL return mapped Entity wrapped in right()
4. WHEN API call fails THEN BaseRepository SHALL automatically handle error conversion
5. WHEN repository method is implemented THEN it SHALL NOT contain manual try-catch blocks for ApiException or DioException
6. WHEN repository code is reviewed THEN it SHALL be significantly shorter than current implementation

### Requirement 7: Update Auth Providers theo Riverpod 3

**User Story:** As a developer, I want Auth providers to follow Riverpod 3 best practices, so that state management is type-safe and performant.

#### Acceptance Criteria

1. WHEN defining providers THEN the system SHALL use `@riverpod` annotation with code generation
2. WHEN defining stateful providers THEN the system SHALL use `AsyncNotifier` or `Notifier` classes
3. WHEN provider needs to persist THEN it SHALL use `@Riverpod(keepAlive: true)` annotation
4. WHEN consuming AsyncValue THEN the UI SHALL use `switch` expression for pattern matching
5. WHEN checking context after await THEN the system SHALL verify `context.mounted` before using context
6. WHEN provider is disposed THEN it SHALL only cleanup resources in `ref.onDispose()`, NOT modify state

### Requirement 8: Create Core Infrastructure Files

**User Story:** As a developer, I want core infrastructure files (BaseRepository, Failures, Exceptions, ApiResponse) to be properly organized, so that they can be reused across all features.

#### Acceptance Criteria

1. WHEN BaseRepository is created THEN it SHALL be in `lib/core/repositories/base_repository.dart`
2. WHEN Failures are defined THEN they SHALL be in `lib/core/error/failures.dart` with types: ValidationFailure, AuthFailure, NotFoundFailure, ConflictFailure, RateLimitFailure, NetworkFailure, ServerFailure
3. WHEN ApiException is defined THEN it SHALL be in `lib/core/error/exceptions.dart` with fields: message, code, statusCode, details, requestId
4. WHEN ApiResponse wrapper is created THEN it SHALL be in `lib/core/network/api_response.dart` with generic type support
5. WHEN ApiInterceptor parses error response THEN it SHALL extract: success (false), message, code, details (Map<String, String>?), requestId
6. WHEN ApiInterceptor encounters 400 error THEN it SHALL throw ApiException with code from response and details map
7. WHEN ApiInterceptor encounters 401/403/404/409/429 THEN it SHALL throw ApiException with appropriate code
8. WHEN any feature needs error handling THEN it SHALL reuse these core files

### Requirement 9: Handle API Response Structure Correctly

**User Story:** As a developer, I want to handle API response structure correctly, so that nullable fields are handled properly according to Jackson NON_NULL serialization.

#### Acceptance Criteria

1. WHEN API returns success response THEN the system SHALL parse structure: `{success: true, message: string, data: T}`
2. WHEN API returns error response THEN the system SHALL parse structure: `{success: false, message: string, code: string, details?: Map<String, String>, requestId: string}`
3. WHEN UserResponse contains nullable fields (avatarUrl, bio, phone, etc.) THEN the system SHALL handle their absence in JSON response
4. WHEN DTO has nullable field that is omitted from response THEN mapper SHALL set Entity field to null
5. WHEN AuthResponse is parsed THEN it SHALL extract: accessToken, refreshToken, tokenType, expiresIn
6. WHEN validation error response is parsed THEN it SHALL extract details map with field-specific errors
7. WHEN error response is parsed THEN it SHALL preserve requestId for debugging

### Requirement 10: Maintain Backward Compatibility

**User Story:** As a developer, I want the refactor to maintain existing functionality, so that no features break during migration.

#### Acceptance Criteria

1. WHEN refactor is complete THEN all existing auth flows SHALL work identically
2. WHEN user logs in with valid credentials THEN tokens SHALL be saved to secure storage and user data SHALL be loaded
3. WHEN user registers with valid data THEN account SHALL be created and verification email SHALL be sent
4. WHEN user verifies email with correct OTP THEN email SHALL be marked as verified
5. WHEN user logs out THEN tokens SHALL be cleared from secure storage and auth state SHALL reset to unauthenticated
6. WHEN access token expires THEN system SHALL automatically refresh using refresh token
7. WHEN network error occurs THEN user SHALL see "Network error. Please check your internet connection."
8. WHEN validation error occurs with multiple fields THEN user SHALL see all field-specific error messages
9. WHEN rate limit is exceeded THEN user SHALL see "Too many requests. Please wait a moment and try again."
10. WHEN unauthorized error occurs THEN user SHALL be redirected to login screen

### Requirement 11: Update Tests

**User Story:** As a developer, I want tests to be updated for new implementation, so that test coverage is maintained.

#### Acceptance Criteria

1. WHEN repository tests are updated THEN they SHALL mock BaseRepository.executeApiCall
2. WHEN testing error handling THEN tests SHALL verify correct Failure types are returned for each error code
3. WHEN testing mappers THEN tests SHALL verify DTO ↔ Entity conversion handles nullable fields correctly
4. WHEN testing providers THEN tests SHALL use Riverpod 3 testing utilities with AsyncValue assertions
5. WHEN testing validation errors THEN tests SHALL verify details map is preserved
6. WHEN all tests run THEN they SHALL pass without errors or warnings

---

## Out of Scope

- UI/UX changes (chỉ refactor code structure)
- New authentication features (OAuth, biometric, etc.)
- Performance optimization (ngoài việc dùng fpdart)
- API endpoint changes
- Database schema changes

---

## Success Criteria

1. ✅ Zero dartz imports, all using fpdart
2. ✅ BaseRepository implemented và được dùng bởi AuthRepository
3. ✅ Zero Freezed deprecation warnings
4. ✅ All auth flows work identically to before
5. ✅ Code coverage maintained or improved
6. ✅ Repository code reduced by ~60% (less error handling boilerplate)
7. ✅ Build succeeds without warnings
8. ✅ All tests pass
