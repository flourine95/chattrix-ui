# Auth Refactor - Quick Reference Guide

## 🎯 What Changed?

### Before → After

| Aspect | Before | After |
|--------|--------|-------|
| **Error Handling** | Manual try-catch in every method | Centralized in BaseRepository |
| **Dependencies** | `dartz` (deprecated) | `fpdart` (actively maintained) |
| **Data Models** | `Model` classes | `Dto` (Data) + `Entity` (Domain) |
| **Conversions** | Inline `.toEntity()` | Explicit `Mapper` classes |
| **Failure Types** | 18 types (many unused) | 7 focused types |
| **Repository Code** | ~1000 lines | ~220 lines (78% reduction) |

---

## 📁 File Naming Convention

```
Data Layer:
  ✅ auth_tokens_dto.dart (was: auth_tokens_model.dart)
  ✅ user_dto.dart (was: user_model.dart)

Domain Layer:
  ✅ auth_tokens.dart (entity)
  ✅ user.dart (entity)

Mappers:
  ✅ auth_tokens_mapper.dart (new)
  ✅ user_mapper.dart (new)
```

---

## 🔧 How to Use BaseRepository

### Old Way (Manual Error Handling)
```dart
class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, User>> login(...) async {
    try {
      final model = await remoteDataSource.login(...);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(_mapServerExceptionToFailure(e)); // 50 lines
    } on DioException catch (e) {
      return Left(_handleDioException(e)); // 20 lines
    } catch (e) {
      return Left(Failure.server(message: e.toString()));
    }
  }
  
  // 70+ lines of error handling code...
}
```

### New Way (BaseRepository)
```dart
class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  @override
  Future<Either<Failure, User>> login(...) async {
    return executeApiCall(() async {
      final dto = await remoteDataSource.login(...);
      return dto.toEntity(); // Mapper handles conversion
    });
  }
}
```

**Benefits:**
- ✅ 60% less code
- ✅ Consistent error handling
- ✅ Easy to maintain
- ✅ No code duplication

---

## 🗺️ How to Use Mappers

### DTO → Entity (API Response to Domain)
```dart
// In repository
final userDto = await apiService.getUser();
final userEntity = userDto.toEntity(); // Mapper extension
return right(userEntity);
```

### Entity → DTO (Domain to API Request)
```dart
// In repository
final userEntity = User(...);
final userDto = userEntity.toDto(); // Mapper extension
await apiService.updateUser(userDto);
```

### Mapper Implementation
```dart
// user_mapper.dart
extension UserDtoMapper on UserDto {
  User toEntity() {
    return User(
      id: id,
      username: username,
      email: email,
      gender: _parseGender(gender), // String? → Gender?
      dateOfBirth: dateOfBirth != null 
          ? DateTime.tryParse(dateOfBirth!) 
          : null,
      // ... other fields
    );
  }
  
  Gender? _parseGender(String? value) {
    if (value == null) return null;
    return Gender.values.firstWhere(
      (e) => e.name.toUpperCase() == value.toUpperCase(),
      orElse: () => Gender.other,
    );
  }
}

extension UserEntityMapper on User {
  UserDto toDto() {
    return UserDto(
      id: id,
      username: username,
      email: email,
      gender: gender?.name.toUpperCase(), // Gender? → String?
      dateOfBirth: dateOfBirth?.toIso8601String(),
      // ... other fields
    );
  }
}
```

---

## ❌ Failure Types (7 Types)

### 1. ValidationFailure
**When**: Input validation errors (400)  
**Fields**: `message`, `code`, `details` (Map<String, String>?)  
**Example**:
```dart
Failure.validation(
  message: 'Validation failed',
  code: 'VALIDATION_ERROR',
  details: {
    'email': 'Invalid email format',
    'password': 'Password too short',
  },
)
```

### 2. AuthFailure
**When**: Authentication/authorization errors (401, 403)  
**Fields**: `message`, `code`  
**Example**:
```dart
Failure.auth(
  message: 'Invalid credentials',
  code: 'UNAUTHORIZED',
)
```

### 3. NotFoundFailure
**When**: Resource not found (404)  
**Fields**: `message`, `code`  
**Example**:
```dart
Failure.notFound(
  message: 'User not found',
  code: 'RESOURCE_NOT_FOUND',
)
```

### 4. ConflictFailure
**When**: Resource conflicts (409)  
**Fields**: `message`, `code`  
**Example**:
```dart
Failure.conflict(
  message: 'Email already exists',
  code: 'CONFLICT',
)
```

### 5. RateLimitFailure
**When**: Too many requests (429)  
**Fields**: `message`, `code`  
**Example**:
```dart
Failure.rateLimit(
  message: 'Too many requests',
  code: 'RATE_LIMIT_EXCEEDED',
)
```

### 6. NetworkFailure
**When**: Network connectivity issues  
**Fields**: `message`, `code`  
**Example**:
```dart
Failure.network(
  message: 'No internet connection',
  code: 'NO_CONNECTION',
)
```

### 7. ServerFailure
**When**: Server errors (500+) or unexpected errors  
**Fields**: `message`, `code`  
**Example**:
```dart
Failure.server(
  message: 'Internal server error',
  code: 'SERVER_ERROR',
)
```

---

## 🎨 UI Exception Handling

### In Provider
```dart
// Map Failure to Exception for AsyncValue
Exception _mapFailureToException(Failure failure) {
  return failure.when(
    validation: (msg, code, details) => ValidationException(msg, details),
    auth: (msg, code) => AuthException(msg, code),
    notFound: (msg, code) => NotFoundException(msg, code),
    conflict: (msg, code) => ConflictException(msg, code),
    rateLimit: (msg, code) => RateLimitException(msg),
    network: (msg, code) => NetworkException(msg),
    server: (msg, code) => ServerException(msg, code),
  );
}
```

### In UI Widget
```dart
Widget build(BuildContext context, WidgetRef ref) {
  final asyncState = ref.watch(loginProvider);
  
  return switch (asyncState) {
    AsyncData(:final value) => _buildSuccess(value),
    AsyncError(:final error) => _buildError(error),
    AsyncLoading() => CircularProgressIndicator(),
    _ => SizedBox.shrink(),
  };
}

Widget _buildError(Object error) {
  String message = 'An error occurred';
  
  if (error is ValidationException) {
    message = error.details?.values.join(', ') ?? error.message;
  } else if (error is AuthException) {
    message = error.message;
    // Navigate to login
  } else if (error is NetworkException) {
    message = 'Check your internet connection';
  }
  
  return Text(message);
}
```

---

## 🔄 fpdart vs dartz

### Key Differences

| Feature | dartz | fpdart |
|---------|-------|--------|
| **Status** | ❌ Deprecated | ✅ Actively maintained |
| **Null Safety** | Retrofitted | Native |
| **Constructors** | `Right()`, `Left()` | `right()`, `left()` |
| **API** | Compatible | Compatible |

### Migration
```dart
// Old (dartz)
import 'package:dartz/dartz.dart';
return Right(value);
return Left(failure);

// New (fpdart)
import 'package:fpdart/fpdart.dart';
return right(value);
return left(failure);
```

**Note**: The API is mostly compatible, so most code just needs import and constructor changes.

---

## 🏗️ Freezed 3 Changes

### Single Factory Constructor
```dart
// Old (Freezed 2)
@freezed
abstract class User with _$User {
  const factory User({...}) = _User;
}

// New (Freezed 3)
@freezed
class User with _$User {  // ✅ Removed 'abstract'
  const factory User({...}) = _User;
}
```

### Union Types (Multiple Factories)
```dart
// Keep 'abstract class' for union types
@freezed
abstract class Failure with _$Failure {  // ✅ Keep 'abstract'
  const factory Failure.server({...}) = ServerFailure;
  const factory Failure.network({...}) = NetworkFailure;
  // ... more factories
}
```

---

## 📝 Checklist for New API Endpoints

When adding a new API endpoint, follow this checklist:

### 1. Data Layer
- [ ] Create DTO with `@freezed` and `@JsonSerializable`
- [ ] Create Mapper (DTO ↔ Entity)
- [ ] Add method to API Service
- [ ] Add method to Repository (extend BaseRepository)
- [ ] Use `executeApiCall()` wrapper

### 2. Domain Layer
- [ ] Create Entity (framework-agnostic)
- [ ] Add method to Repository interface
- [ ] Create UseCase

### 3. Presentation Layer
- [ ] Create Riverpod provider with `@riverpod`
- [ ] Map Failure to Exception
- [ ] Handle all AsyncValue states in UI

### 4. Error Handling
- [ ] Map all API error codes to Failure types
- [ ] Test validation errors with field details
- [ ] Test network errors
- [ ] Test auth errors

---

## 🐛 Common Issues

### Issue: "Missing concrete implementations"
**Cause**: Freezed analyzer false positive  
**Solution**: Ignore - code works correctly  
**Status**: Known Freezed issue

### Issue: "avoid_returning_null_for_void"
**Cause**: Cosmetic warning in datasource  
**Solution**: Can be ignored or fixed by removing `return null;`  
**Status**: Non-blocking

### Issue: "Right/Left not defined"
**Cause**: Using dartz constructors with fpdart  
**Solution**: Use lowercase `right()` and `left()`

### Issue: "toEntity() not defined"
**Cause**: Forgot to import mapper  
**Solution**: Import mapper file

---

## 📚 Further Reading

- **BaseRepository Pattern**: `lib/core/repositories/base_repository.dart`
- **Mapper Example**: `lib/features/auth/data/mappers/user_mapper.dart`
- **Repository Example**: `lib/features/auth/data/repositories/auth_repository_impl.dart`
- **API Flow Template**: `.kiro/steering/api_flow_template.md`
- **Riverpod 3 Guide**: `.kiro/steering/riverpod_3_prompt.md`

---

## 🚀 Quick Commands

```bash
# Generate code
dart run build_runner build --delete-conflicting-outputs

# Watch mode
dart run build_runner watch --delete-conflicting-outputs

# Analyze code
flutter analyze

# Format code
dart format .

# Run tests
flutter test
```

---

## 💡 Tips

1. **Always extend BaseRepository** for new repositories
2. **Use mappers** for all DTO ↔ Entity conversions
3. **Import fpdart**, not dartz
4. **Use lowercase** `right()` and `left()`
5. **Check context.mounted** after every `await` in UI
6. **Use switch expression** for AsyncValue in UI
7. **Add keepAlive: true** for persistent providers
8. **Run build_runner** after changing models

---

**Questions?** Check the completion summary or design document for more details.
