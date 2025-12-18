# Design Document - Auth Feature Refactor

## 1. Overview

This document outlines the technical design for refactoring the Auth feature to align with Clean Architecture best practices, migrate from `dartz` to `fpdart`, implement BaseRepository pattern, and ensure full compliance with the API specification.

### 1.1. Goals

- **Eliminate Code Duplication**: Implement BaseRepository to centralize error handling (~60% code reduction in repositories)
- **Modern Dependencies**: Migrate from deprecated `dartz` to actively maintained `fpdart`
- **API Compliance**: Ensure error handling matches API spec exactly (VALIDATION_ERROR, UNAUTHORIZED, FORBIDDEN, RESOURCE_NOT_FOUND, CONFLICT, RATE_LIMIT_EXCEEDED)
- **Freezed 3 Compliance**: Use `abstract class` correctly for union types and generic types
- **Explicit Mappers**: Create dedicated mapper files for DTO ↔ Entity conversion
- **Riverpod 3 Best Practices**: Follow code generation patterns with proper lifecycle management

### 1.2. Architecture Layers

```
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                        │
│  - Providers (Riverpod 3 with @riverpod annotation)        │
│  - UI Widgets (HookConsumerWidget)                          │
│  - State Management (AsyncNotifier)                          │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                     Domain Layer                             │
│  - Entities (Framework-agnostic, freezed only)              │
│  - Repository Interfaces (Either<Failure, T>)               │
│  - Use Cases (Business logic)                                │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                      Data Layer                              │
│  - DTOs (freezed + json_serializable)                       │
│  - Mappers (DTO ↔ Entity extensions)                        │
│  - API Services (Dio)                                        │
│  - Repository Implementations (extends BaseRepository)       │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. Core Infrastructure

### 2.1. BaseRepository Pattern

**File**: `lib/core/repositories/base_repository.dart`

**Purpose**: Centralize error handling logic to eliminate duplication across all repositories.

**Key Features**:
- Generic `executeApiCall<T>()` wrapper for all API operations
- Automatic conversion of ApiException → Failure types
- Automatic conversion of DioException → NetworkFailure/ServerFailure
- Consistent error handling across entire application

**Implementation**:

```dart
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../error/failures.dart';
import '../error/exceptions.dart';

abstract class BaseRepository {
  Future<Either<Failure, T>> executeApiCall<T>(
    Future<T> Function() apiCall,
  ) async {
    try {
      final result = await apiCall();
      return right(result);
    } on ApiException catch (e) {
      return left(_handleApiException(e));
    } on DioException catch (e) {
      return left(_handleDioException(e));
    } catch (e) {
      return left(Failure.server(
        message: 'Unexpected error: $e',
        code: 'UNEXPECTED_ERROR',
      ));
    }
  }

  Failure _handleApiException(ApiException e) {
    switch (e.code) {
      case 'VALIDATION_ERROR':
        return Failure.validation(
          message: e.message,
          code: e.code,
          details: e.details,
        );
      case 'UNAUTHORIZED':
        return Failure.auth(message: e.message, code: e.code);
      case 'FORBIDDEN':
        return Failure.auth(message: e.message, code: e.code);
      case 'RESOURCE_NOT_FOUND':
        return Failure.notFound(message: e.message, code: e.code);
      case 'CONFLICT':
        return Failure.conflict(message: e.message, code: e.code);
      case 'RATE_LIMIT_EXCEEDED':
        return Failure.rateLimit(message: e.message, code: e.code);
      default:
        return Failure.server(message: e.message, code: e.code);
    }
  }

  Failure _handleDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return Failure.network(
        message: 'Connection timeout',
        code: 'TIMEOUT',
      );
    } else if (e.type == DioExceptionType.connectionError) {
      return Failure.network(
        message: 'No internet connection',
        code: 'NO_CONNECTION',
      );
    } else {
      return Failure.server(
        message: e.message ?? 'Server error',
        code: 'SERVER_ERROR',
      );
    }
  }
}
```

**Benefits**:
- ✅ No code duplication across repositories
- ✅ Consistent error handling
- ✅ Easy to maintain and update
- ✅ Reduces repository code by ~60%

---

### 2.2. Updated Failure Types

**File**: `lib/core/error/failures.dart`

**Changes from Current**:


1. **Keep `abstract class` keyword** (Required for union types in Freezed 3)
2. **Add `code` field** to all failure types for API error code tracking
3. **Update ValidationFailure** to use `Map<String, String>? details` instead of `List<ValidationError>?`
4. **Consolidate auth failures**: Merge `unauthorized`, `forbidden` into single `auth` failure
5. **Add requestId field** (optional) for debugging

**New Structure**:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.server({
    required String message,
    required String code,
    String? requestId,
  }) = ServerFailure;

  const factory Failure.network({
    required String message,
    required String code,
  }) = NetworkFailure;

  const factory Failure.validation({
    required String message,
    required String code,
    Map<String, String>? details,
    String? requestId,
  }) = ValidationFailure;

  const factory Failure.auth({
    required String message,
    required String code,
    String? requestId,
  }) = AuthFailure;

  const factory Failure.notFound({
    required String message,
    required String code,
    String? requestId,
  }) = NotFoundFailure;

  const factory Failure.conflict({
    required String message,
    required String code,
    String? requestId,
  }) = ConflictFailure;

  const factory Failure.rateLimit({
    required String message,
    required String code,
    String? requestId,
  }) = RateLimitFailure;
}
```

**Mapping from API Error Codes**:

| API Error Code | Failure Type | Example Message |
|----------------|--------------|-----------------|
| `VALIDATION_ERROR` | `ValidationFailure` | "Validation failed" + details map |
| `UNAUTHORIZED` | `AuthFailure` | "Invalid or expired token" |
| `FORBIDDEN` | `AuthFailure` | "Access denied" |
| `RESOURCE_NOT_FOUND` | `NotFoundFailure` | "Resource not found" |
| `CONFLICT` | `ConflictFailure` | "Email already exists" |
| `RATE_LIMIT_EXCEEDED` | `RateLimitFailure` | "Too many requests" |
| Network timeout | `NetworkFailure` | "Connection timeout" |
| No connection | `NetworkFailure` | "No internet connection" |

---

### 2.3. Updated Exception Types

**File**: `lib/core/error/exceptions.dart`

**Changes**:
1. Add `ApiException` class (thrown by interceptor)
2. Update `ServerException` to match new structure
3. Keep `NetworkException` as-is

**New Structure**:

```dart
/// API Exception thrown by Dio interceptor when parsing error response
class ApiException implements Exception {
  final String message;
  final String code;
  final int statusCode;
  final Map<String, String>? details;
  final String? requestId;

  ApiException({
    required this.message,
    required this.code,
    required this.statusCode,
    this.details,
    this.requestId,
  });

  @override
  String toString() => 'ApiException($code): $message';
}

/// Server Exception for unexpected server errors
class ServerException implements Exception {
  final String message;
  final String? errorCode;
  final int? statusCode;

  ServerException({
    required this.message,
    this.errorCode,
    this.statusCode,
  });

  @override
  String toString() => 'ServerException: $message (Code: $errorCode)';
}

/// Network Exception for connectivity issues
class NetworkException implements Exception {
  final String message;
  NetworkException({this.message = 'No internet connection'});

  @override
  String toString() => 'NetworkException: $message';
}
```

---

### 2.4. API Response Wrapper

**File**: `lib/core/network/api_response.dart`

**Purpose**: Generic wrapper for all API responses matching backend structure.

**Structure**:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@Freezed(genericArgumentFactories: true)
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required bool success,
    required String message,
    T? data,
  }) = _ApiResponse<T>;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
}
```

**Usage Example**:

```dart
// In API Service
final response = await _dio.post('/v1/auth/login', data: {...});

final apiResponse = ApiResponse<AuthTokensDto>.fromJson(
  response.data,
  (json) => AuthTokensDto.fromJson(json as Map<String, dynamic>),
);

if (apiResponse.success && apiResponse.data != null) {
  return apiResponse.data!;
} else {
  throw ApiException(
    message: apiResponse.message,
    code: 'UNKNOWN_ERROR',
    statusCode: 500,
  );
}
```

---

### 2.5. API Interceptor

**File**: `lib/core/network/api_interceptor.dart`

**Purpose**: Parse error responses and throw ApiException with proper structure.

**Implementation**:


```dart
import 'package:dio/dio.dart';
import '../error/exceptions.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null && err.response!.data != null) {
      final data = err.response!.data;
      
      if (data is Map<String, dynamic>) {
        // Parse error response structure:
        // {success: false, message: string, code: string, details?: Map, requestId: string}
        final message = data['message'] as String? ?? 'Unknown error';
        final code = data['code'] as String? ?? 'UNKNOWN_ERROR';
        final requestId = data['requestId'] as String?;
        
        // Parse details map for validation errors
        Map<String, String>? details;
        if (data['details'] != null && data['details'] is Map) {
          details = (data['details'] as Map).map(
            (key, value) => MapEntry(key.toString(), value.toString()),
          );
        }
        
        throw ApiException(
          message: message,
          code: code,
          statusCode: err.response!.statusCode ?? 500,
          details: details,
          requestId: requestId,
        );
      }
    }
    
    // If not a structured error response, pass through
    super.onError(err, handler);
  }
}
```

**Error Response Parsing**:

```json
// Success Response
{
  "success": true,
  "message": "Login successful",
  "data": {
    "accessToken": "...",
    "refreshToken": "...",
    "tokenType": "Bearer",
    "expiresIn": 86400
  }
}

// Error Response (Validation)
{
  "success": false,
  "message": "Validation failed",
  "code": "VALIDATION_ERROR",
  "details": {
    "email": "Email already exists",
    "username": "Username must be 4-20 characters"
  },
  "requestId": "req-reg001"
}

// Error Response (Auth)
{
  "success": false,
  "message": "Invalid or expired token",
  "code": "UNAUTHORIZED",
  "requestId": "req-auth001"
}
```

---

## 3. Data Layer Design

### 3.1. DTOs (Data Transfer Objects)

**Location**: `lib/features/auth/data/models/`

**Changes**:
1. DTOs with single factory constructor don't require `abstract class` (optional but recommended for consistency)
2. Keep `@freezed` and `@JsonSerializable` annotations
3. Handle nullable fields according to Jackson NON_NULL serialization

**Updated AuthTokensDto**:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_tokens_dto.freezed.dart';
part 'auth_tokens_dto.g.dart';

@freezed
class AuthTokensDto with _$AuthTokensDto {
  const factory AuthTokensDto({
    required String accessToken,
    required String refreshToken,
    required String tokenType,
    required int expiresIn,
  }) = _AuthTokensDto;

  factory AuthTokensDto.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensDtoFromJson(json);
}
```

**Updated UserDto**:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required int id,
    required String username,
    required String email,
    required bool emailVerified,
    String? phone,
    required String fullName,
    String? avatarUrl,
    String? bio,
    String? gender,  // String from API, will map to enum in Entity
    String? dateOfBirth,  // ISO string from API
    String? location,
    String? profileVisibility,  // String from API, will map to enum
    required bool online,
    String? lastSeen,  // ISO string from API
    required String createdAt,  // ISO string from API
    String? updatedAt,  // ISO string from API
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
```

**Key Points**:
- DTO fields match API response exactly (all strings for dates/enums)
- Nullable fields (`String?`) for fields that can be omitted (NON_NULL serialization)
- No business logic in DTOs
- No imports from Domain layer

---

### 3.2. Mappers

**Location**: `lib/features/auth/data/mappers/`

**Purpose**: Explicit conversion between DTOs and Entities with proper type transformations.

**AuthTokensMapper**:

**File**: `lib/features/auth/data/mappers/auth_tokens_mapper.dart`

```dart
import '../models/auth_tokens_dto.dart';
import '../../../domain/entities/auth_tokens.dart';

extension AuthTokensDtoMapper on AuthTokensDto {
  AuthTokens toEntity() {
    return AuthTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      tokenType: tokenType,
      expiresIn: expiresIn,
    );
  }
}

extension AuthTokensEntityMapper on AuthTokens {
  AuthTokensDto toDto() {
    return AuthTokensDto(
      accessToken: accessToken,
      refreshToken: refreshToken,
      tokenType: tokenType,
      expiresIn: expiresIn,
    );
  }
}
```

**UserMapper**:

**File**: `lib/features/auth/data/mappers/user_mapper.dart`

```dart
import '../models/user_dto.dart';
import '../../../domain/entities/user.dart';
import '../../../../core/domain/enums/enums.dart';

extension UserDtoMapper on UserDto {
  User toEntity() {
    return User(
      id: id,
      username: username,
      email: email,
      emailVerified: emailVerified,
      phone: phone,
      fullName: fullName,
      avatarUrl: avatarUrl,
      bio: bio,
      gender: _parseGender(gender),
      dateOfBirth: dateOfBirth != null ? DateTime.tryParse(dateOfBirth!) : null,
      location: location,
      profileVisibility: _parseProfileVisibility(profileVisibility),
      online: online,
      lastSeen: lastSeen != null ? DateTime.tryParse(lastSeen!) : null,
      createdAt: DateTime.parse(createdAt),
      updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
    );
  }

  Gender? _parseGender(String? value) {
    if (value == null) return null;
    switch (value.toUpperCase()) {
      case 'MALE':
        return Gender.male;
      case 'FEMALE':
        return Gender.female;
      case 'OTHER':
        return Gender.other;
      default:
        return Gender.other;
    }
  }

  ProfileVisibility? _parseProfileVisibility(String? value) {
    if (value == null) return null;
    switch (value.toUpperCase()) {
      case 'PUBLIC':
        return ProfileVisibility.public;
      case 'FRIENDS_ONLY':
        return ProfileVisibility.friendsOnly;
      case 'PRIVATE':
        return ProfileVisibility.private;
      default:
        return ProfileVisibility.public;
    }
  }
}

extension UserEntityMapper on User {
  UserDto toDto() {
    return UserDto(
      id: id,
      username: username,
      email: email,
      emailVerified: emailVerified,
      phone: phone,
      fullName: fullName,
      avatarUrl: avatarUrl,
      bio: bio,
      gender: gender?.name.toUpperCase(),
      dateOfBirth: dateOfBirth?.toIso8601String(),
      location: location,
      profileVisibility: profileVisibility?.name.toUpperCase(),
      online: online,
      lastSeen: lastSeen?.toIso8601String(),
      createdAt: createdAt.toIso8601String(),
      updatedAt: updatedAt?.toIso8601String(),
    );
  }
}
```

**Benefits**:
- ✅ Clear separation of concerns
- ✅ Type-safe conversions (String → DateTime, String → Enum)
- ✅ Handles nullable fields correctly
- ✅ Easy to test and maintain

---

### 3.3. Repository Implementation

**File**: `lib/features/auth/data/repositories/auth_repository_impl.dart`

**Changes**:
1. Extend `BaseRepository`
2. Use `executeApiCall()` wrapper
3. Remove manual try-catch blocks
4. Use mappers for DTO ↔ Entity conversion
5. Use `fpdart` instead of `dartz`

**Example Method (Before)**:

```dart
@override
Future<Either<Failure, AuthTokens>> login({
  required String usernameOrEmail,
  required String password,
}) async {
  try {
    final tokensModel = await remoteDataSource.login(
      usernameOrEmail: usernameOrEmail,
      password: password,
    );
    await localDataSource.saveTokens(
      accessToken: tokensModel.accessToken,
      refreshToken: tokensModel.refreshToken,
    );
    return Right(tokensModel.toEntity());
  } on ServerException catch (e) {
    return Left(_mapServerExceptionToFailure(e));
  } on NetworkException catch (e) {
    return Left(Failure.network(message: e.message));
  } catch (e) {
    return Left(Failure.unknown(message: e.toString()));
  }
}
```

**Example Method (After)**:

```dart
@override
Future<Either<Failure, AuthTokens>> login({
  required String usernameOrEmail,
  required String password,
}) async {
  return executeApiCall(() async {
    final tokensDto = await _apiService.login(
      usernameOrEmail: usernameOrEmail,
      password: password,
    );
    
    await _localDataSource.saveTokens(
      accessToken: tokensDto.accessToken,
      refreshToken: tokensDto.refreshToken,
    );
    
    return tokensDto.toEntity();
  });
}
```

**Code Reduction**: ~100 lines → ~15 lines per repository!

---

## 4. Domain Layer Design

### 4.1. Entities

**Location**: `lib/features/auth/domain/entities/`

**Changes**:
1. Entities with single factory constructor don't require `abstract class` (optional but recommended for consistency)
2. Keep entities framework-agnostic (no json_annotation)
3. Use proper Dart types (DateTime, enums)

**Updated AuthTokens Entity**:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_tokens.freezed.dart';

@freezed
class AuthTokens with _$AuthTokens {
  const factory AuthTokens({
    required String accessToken,
    required String refreshToken,
    required String tokenType,
    required int expiresIn,
  }) = _AuthTokens;
}
```

**Updated User Entity**:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/domain/enums/enums.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String username,
    required String email,
    required bool emailVerified,
    String? phone,
    required String fullName,
    String? avatarUrl,
    String? bio,
    Gender? gender,
    DateTime? dateOfBirth,
    String? location,
    ProfileVisibility? profileVisibility,
    required bool online,
    DateTime? lastSeen,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _User;
}
```

**Key Points**:
- No `abstract class` keyword
- No `json_annotation` imports
- Use Dart types (DateTime, enums) not strings
- Framework-agnostic

---

### 4.2. Repository Interface

**File**: `lib/features/auth/domain/repositories/auth_repository.dart`

**Changes**:
1. Use `fpdart` instead of `dartz`
2. Update return types to use new Failure structure

**Example**:

```dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth_tokens.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> register({
    required String username,
    required String email,
    required String password,
    required String fullName,
  });

  Future<Either<Failure, AuthTokens>> login({
    required String usernameOrEmail,
    required String password,
  });

  Future<Either<Failure, User>> getCurrentUser();

  Future<Either<Failure, AuthTokens>> refreshToken();

  Future<Either<Failure, void>> logout();

  Future<bool> isLoggedIn();
}
```

---

## 5. Presentation Layer Design

### 5.1. Provider Updates

**File**: `lib/features/auth/presentation/providers/auth_state_provider.dart`

**Changes**:
1. Update exception mapping to match new Failure types
2. Use `fpdart` fold syntax
3. Ensure proper error handling

**Updated Exception Mapping**:


```dart
Exception _mapFailureToException(Failure failure) {
  return failure.when(
    server: (message, code, requestId) => ServerException(message, code),
    network: (message, code) => NetworkException(message),
    validation: (message, code, details, requestId) => 
        ValidationException(message, details),
    auth: (message, code, requestId) => AuthException(message, code),
    notFound: (message, code, requestId) => NotFoundException(message, code),
    conflict: (message, code, requestId) => ConflictException(message, code),
    rateLimit: (message, code, requestId) => RateLimitException(message),
  );
}
```

**Custom Exceptions for UI**:

```dart
class ServerException implements Exception {
  final String message;
  final String? code;
  ServerException(this.message, [this.code]);
  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
  @override
  String toString() => message;
}

class ValidationException implements Exception {
  final String message;
  final Map<String, String>? details;
  ValidationException(this.message, [this.details]);
  
  @override
  String toString() {
    if (details != null && details!.isNotEmpty) {
      return details!.values.join(', ');
    }
    return message;
  }
}

class AuthException implements Exception {
  final String message;
  final String? code;
  AuthException(this.message, [this.code]);
  @override
  String toString() => message;
}

class NotFoundException implements Exception {
  final String message;
  final String? code;
  NotFoundException(this.message, [this.code]);
  @override
  String toString() => message;
}

class ConflictException implements Exception {
  final String message;
  final String? code;
  ConflictException(this.message, [this.code]);
  @override
  String toString() => message;
}

class RateLimitException implements Exception {
  final String message;
  RateLimitException(this.message);
  @override
  String toString() => message;
}
```

---

### 5.2. UI Error Handling

**Pattern for handling errors in UI**:

```dart
Widget build(BuildContext context, WidgetRef ref) {
  final asyncState = ref.watch(authProvider);
  
  return switch (asyncState) {
    AsyncData(:final value) => _buildSuccess(value),
    AsyncError(:final error) => _buildError(context, error),
    AsyncLoading() => const Center(child: CircularProgressIndicator()),
    _ => const Center(child: Text('Ready')),
  };
}

Widget _buildError(BuildContext context, Object error) {
  String message = 'An error occurred';
  String? details;

  if (error is ValidationException) {
    message = error.message;
    if (error.details != null) {
      details = error.details!.entries
          .map((e) => '${e.key}: ${e.value}')
          .join('\n');
    }
  } else if (error is AuthException) {
    message = error.message;
    // Navigate to login
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        context.go('/login');
      }
    });
  } else if (error is NetworkException) {
    message = error.message;
  } else if (error is ConflictException) {
    message = error.message;
  } else if (error is RateLimitException) {
    message = error.message;
  }

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, size: 48, color: Colors.red),
        const SizedBox(height: 16),
        Text(message, style: const TextStyle(fontSize: 16)),
        if (details != null) ...[
          const SizedBox(height: 8),
          Text(
            details,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ],
    ),
  );
}
```

---

## 6. Migration Strategy

### 6.1. Phase 1: Core Infrastructure (Day 1)

**Tasks**:
1. Create `lib/core/repositories/base_repository.dart`
2. Update `lib/core/error/failures.dart` (keep `abstract class` for union type, add `code` field)
3. Update `lib/core/error/exceptions.dart` (add `ApiException`)
4. Create `lib/core/network/api_response.dart`
5. Create `lib/core/network/api_interceptor.dart`
6. Run `dart run build_runner build --delete-conflicting-outputs`

**Verification**:
- No build errors
- Freezed generates correctly without warnings

---

### 6.2. Phase 2: Data Layer (Day 2)

**Tasks**:
1. Rename `auth_tokens_model.dart` → `auth_tokens_dto.dart`
2. Rename `user_model.dart` → `user_dto.dart`
3. DTOs can optionally use `abstract class` for consistency (not required for single factory constructors)
4. Create `lib/features/auth/data/mappers/auth_tokens_mapper.dart`
5. Create `lib/features/auth/data/mappers/user_mapper.dart`
6. Update `auth_repository_impl.dart` to extend `BaseRepository`
7. Update all repository methods to use `executeApiCall()`
8. Update imports from `dartz` to `fpdart`
9. Run `dart run build_runner build --delete-conflicting-outputs`

**Verification**:
- Repository code reduced by ~60%
- No manual try-catch blocks in repository
- All methods return `Either<Failure, T>`

---

### 6.3. Phase 3: Domain Layer (Day 3)

**Tasks**:
1. Entities can optionally use `abstract class` for consistency (not required for single factory constructors)
2. Verify entities are framework-agnostic
3. Update repository interface to use `fpdart`
4. Update all use cases to use `fpdart`
5. Run `dart run build_runner build --delete-conflicting-outputs`

**Verification**:
- No Freezed deprecation warnings
- Domain layer has no Flutter/Dio/json_annotation imports

---

### 6.4. Phase 4: Presentation Layer (Day 4)

**Tasks**:
1. Update `auth_state_provider.dart` exception mapping
2. Update all UI screens to handle new exception types
3. Test all auth flows (login, register, logout, etc.)
4. Update error messages to be user-friendly

**Verification**:
- All auth flows work identically
- Error messages are clear and helpful
- No crashes or unexpected behavior

---

### 6.5. Phase 5: Testing (Day 5)

**Tasks**:
1. Update repository tests to mock `BaseRepository.executeApiCall`
2. Update mapper tests for DTO ↔ Entity conversion
3. Update provider tests for new exception types
4. Add integration tests for complete auth flows

**Verification**:
- All tests pass
- Code coverage maintained or improved

---

## 7. Testing Approach

### 7.1. Unit Tests

**BaseRepository Test**:

```dart
test('should return right when API call succeeds', () async {
  // Arrange
  final repository = TestRepository();
  
  // Act
  final result = await repository.executeApiCall(() async => 'success');
  
  // Assert
  expect(result.isRight(), true);
  result.fold(
    (failure) => fail('Should not fail'),
    (value) => expect(value, 'success'),
  );
});

test('should return ValidationFailure when ApiException with VALIDATION_ERROR', () async {
  // Arrange
  final repository = TestRepository();
  
  // Act
  final result = await repository.executeApiCall(() async {
    throw ApiException(
      message: 'Validation failed',
      code: 'VALIDATION_ERROR',
      statusCode: 400,
      details: {'email': 'Email already exists'},
    );
  });
  
  // Assert
  expect(result.isLeft(), true);
  result.fold(
    (failure) {
      expect(failure, isA<ValidationFailure>());
      expect(failure.message, 'Validation failed');
      expect(failure.code, 'VALIDATION_ERROR');
    },
    (value) => fail('Should not succeed'),
  );
});
```

**Mapper Test**:

```dart
test('should convert UserDto to User entity correctly', () {
  // Arrange
  final dto = UserDto(
    id: 1,
    username: 'testuser',
    email: 'test@example.com',
    emailVerified: true,
    fullName: 'Test User',
    online: true,
    createdAt: '2025-01-01T00:00:00Z',
    gender: 'MALE',
    dateOfBirth: '1990-01-01T00:00:00Z',
  );
  
  // Act
  final entity = dto.toEntity();
  
  // Assert
  expect(entity.id, 1);
  expect(entity.username, 'testuser');
  expect(entity.gender, Gender.male);
  expect(entity.dateOfBirth, DateTime.parse('1990-01-01T00:00:00Z'));
});

test('should handle nullable fields correctly', () {
  // Arrange
  final dto = UserDto(
    id: 1,
    username: 'testuser',
    email: 'test@example.com',
    emailVerified: true,
    fullName: 'Test User',
    online: true,
    createdAt: '2025-01-01T00:00:00Z',
    // avatarUrl, bio, gender, etc. are null
  );
  
  // Act
  final entity = dto.toEntity();
  
  // Assert
  expect(entity.avatarUrl, null);
  expect(entity.bio, null);
  expect(entity.gender, null);
});
```

---

### 7.2. Integration Tests

**Login Flow Test**:

```dart
test('should complete login flow successfully', () async {
  // Arrange
  final container = ProviderContainer(
    overrides: [
      authRepositoryProvider.overrideWithValue(mockRepository),
    ],
  );
  
  when(mockRepository.login(
    usernameOrEmail: 'testuser',
    password: 'password123',
  )).thenAnswer((_) async => right(mockAuthTokens));
  
  when(mockRepository.getCurrentUser())
      .thenAnswer((_) async => right(mockUser));
  
  // Act
  await container.read(authProvider.notifier).login(
    usernameOrEmail: 'testuser',
    password: 'password123',
  );
  
  // Assert
  final state = container.read(authProvider);
  expect(state.hasValue, true);
  expect(state.value!.isAuthenticated, true);
  expect(state.value!.user, mockUser);
});

test('should handle validation error correctly', () async {
  // Arrange
  final container = ProviderContainer(
    overrides: [
      authRepositoryProvider.overrideWithValue(mockRepository),
    ],
  );
  
  when(mockRepository.login(
    usernameOrEmail: '',
    password: '',
  )).thenAnswer((_) async => left(Failure.validation(
    message: 'Validation failed',
    code: 'VALIDATION_ERROR',
    details: {
      'usernameOrEmail': 'Username or email cannot be blank',
      'password': 'Password cannot be blank',
    },
  )));
  
  // Act
  await container.read(authProvider.notifier).login(
    usernameOrEmail: '',
    password: '',
  );
  
  // Assert
  final state = container.read(authProvider);
  expect(state.hasError, true);
  expect(state.error, isA<ValidationException>());
});
```

---

## 8. File Structure

```
lib/
├── core/
│   ├── error/
│   │   ├── exceptions.dart (ApiException, ServerException, NetworkException)
│   │   └── failures.dart (Failure types with freezed)
│   ├── network/
│   │   ├── api_response.dart (Generic API response wrapper)
│   │   └── api_interceptor.dart (Dio interceptor for error parsing)
│   └── repositories/
│       └── base_repository.dart (Abstract base with executeApiCall)
│
├── features/
│   └── auth/
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── auth_local_datasource.dart
│       │   │   ├── auth_local_datasource_impl.dart
│       │   │   ├── auth_remote_datasource.dart
│       │   │   └── auth_remote_datasource_impl.dart
│       │   ├── models/
│       │   │   ├── auth_tokens_dto.dart (renamed from auth_tokens_model.dart)
│       │   │   ├── user_dto.dart (renamed from user_model.dart)
│       │   │   └── ... (other request DTOs)
│       │   ├── mappers/
│       │   │   ├── auth_tokens_mapper.dart (NEW)
│       │   │   └── user_mapper.dart (NEW)
│       │   └── repositories/
│       │       └── auth_repository_impl.dart (extends BaseRepository)
│       │
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── auth_tokens.dart (no abstract class)
│       │   │   └── user.dart (no abstract class)
│       │   ├── repositories/
│       │   │   └── auth_repository.dart (uses fpdart)
│       │   └── usecases/
│       │       └── ... (all use fpdart)
│       │
│       └── presentation/
│           ├── providers/
│           │   └── auth_state_provider.dart (updated exception mapping)
│           ├── pages/
│           │   └── ... (updated error handling)
│           └── widgets/
│               └── ...
```

---

## 9. Success Criteria

### 9.1. Code Quality

- ✅ Zero `dartz` imports, all using `fpdart`
- ✅ Zero Freezed deprecation warnings (`abstract class` removed)
- ✅ BaseRepository implemented and used by all repositories
- ✅ Repository code reduced by ~60%
- ✅ All error codes match API spec exactly
- ✅ Explicit mappers for all DTO ↔ Entity conversions

### 9.2. Functionality

- ✅ All auth flows work identically to before
- ✅ Login with valid credentials saves tokens and loads user
- ✅ Register creates account and sends verification email
- ✅ Email verification works with OTP
- ✅ Logout clears tokens and resets state
- ✅ Token refresh works automatically
- ✅ Error messages are user-friendly and specific

### 9.3. Testing

- ✅ All unit tests pass
- ✅ All integration tests pass
- ✅ Code coverage maintained or improved
- ✅ No flaky tests

### 9.4. Build

- ✅ Build succeeds without errors or warnings
- ✅ Code generation completes successfully
- ✅ No runtime errors

---

## 10. Risk Mitigation

### 10.1. Breaking Changes

**Risk**: Refactor breaks existing functionality

**Mitigation**:
- Implement changes incrementally (phase by phase)
- Run tests after each phase
- Keep old code until new code is verified
- Use feature flags if needed

### 10.2. API Response Changes

**Risk**: API response structure doesn't match expectations

**Mitigation**:
- Verify API responses with backend team
- Add comprehensive error logging
- Test with real API (not just mocks)
- Handle unexpected response formats gracefully

### 10.3. Migration Complexity

**Risk**: Migration takes longer than expected

**Mitigation**:
- Break down into small, manageable tasks
- Focus on one layer at a time
- Document all changes
- Get code reviews at each phase

---

## 11. Next Steps

1. **Review this design document** with team
2. **Get approval** from stakeholders
3. **Create tasks.md** with detailed implementation checklist
4. **Begin Phase 1** (Core Infrastructure)
5. **Iterate** through phases with testing at each step

---

## 12. References

- [fpdart Documentation](https://pub.dev/packages/fpdart)
- [Freezed 3 Migration Guide](https://pub.dev/packages/freezed)
- [Riverpod 3 Documentation](https://riverpod.dev/)
- [Clean Architecture Principles](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- API Specification: `api-spec.yaml`
- Template: `.kiro/steering/api_flow_template.md`
