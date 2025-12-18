# Quick Start Guide - Features Refactor

This guide helps you quickly understand and execute the features refactor spec.

---

## Overview

**Goal**: Refactor 5 remaining features (Profile, Notes, Contacts, Call, Chat) to use Clean Architecture with BaseRepository pattern and fpdart.

**Status**: Ready to start implementation

**Estimated Time**: 11 days

---

## What's Already Done (Auth Refactor)

✅ **Core Infrastructure** (reusable across all features):
- `lib/core/repositories/base_repository.dart` - Centralized error handling
- `lib/core/errors/failures.dart` - 7 standardized Failure types
- `lib/core/errors/exceptions.dart` - ApiException, ServerException, NetworkException
- `lib/core/network/api_response.dart` - Generic API response wrapper
- `lib/core/network/api_interceptor.dart` - Error response parser

✅ **Auth Feature** (template for other features):
- UserDto and UserMapper (reusable by Profile and Chat)
- BaseRepository pattern implemented
- fpdart migration complete
- 7 exception types for UI

---

## What Needs to Be Done

### Features to Refactor (in order):

1. **Profile** (6 errors) - 1 day
   - Reuses auth User entity/mapper
   - Update repository to extend BaseRepository
   - Update usecases to use fpdart
   - Update providers to use 7 exception types

2. **Notes** (unknown errors) - 1 day
   - Create NoteDto and NoteMapper
   - Update repository to extend BaseRepository
   - Update usecases to use fpdart
   - Update providers to use 7 exception types

3. **Contacts** (48 errors) - 2 days
   - Create ContactDto, FriendRequestDto and mappers
   - Update repository to extend BaseRepository
   - Update usecases to use fpdart
   - Update providers to use 7 exception types

4. **Call** (16 errors) - 2 days
   - Create CallDto, CallParticipantDto and mappers
   - Update repository to extend BaseRepository
   - Update usecases to use fpdart
   - Update providers to use 7 exception types

5. **Chat** (26 errors) - 3 days
   - Create MessageDto, ConversationDto, SearchUserDto and mappers
   - Update repository to extend BaseRepository
   - Update usecases to use fpdart
   - Update providers to use 7 exception types

**Total**: 96 errors to resolve

---

## How to Execute

### Option 1: Execute Tasks Manually

1. Open `.kiro/specs/features-refactor/tasks.md`
2. Start with Task 1.1 (Profile feature)
3. Follow each subtask in order
4. Test after each feature is complete
5. Move to next feature

### Option 2: Use Kiro to Execute Tasks

1. Open `.kiro/specs/features-refactor/tasks.md` in Kiro
2. Click "Start task" next to Task 1.1
3. Kiro will guide you through implementation
4. Review and approve changes
5. Continue to next task

---

## Key Patterns to Follow

### 1. Data Layer Pattern

**Before** (old pattern):
```dart
class FeatureRepositoryImpl implements FeatureRepository {
  @override
  Future<Either<Failure, Entity>> method() async {
    try {
      final model = await _apiService.method();
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(_handleServerException(e)); // 50 lines
    } on DioException catch (e) {
      return Left(_handleDioException(e)); // 20 lines
    }
  }
}
```

**After** (new pattern):
```dart
class FeatureRepositoryImpl extends BaseRepository implements FeatureRepository {
  @override
  Future<Either<Failure, Entity>> method() async {
    return executeApiCall(() async {
      final dto = await _apiService.method();
      return dto.toEntity();
    });
  }
}
```

**Result**: ~60% less code!

### 2. DTO Pattern

```dart
// lib/features/[feature]/data/models/[name]_dto.dart
@freezed
class NameDto with _$NameDto {
  const factory NameDto({
    required int id,
    required String field1,
    String? field2,  // Nullable for API NON_NULL serialization
    required String createdAt,  // ISO string from API
  }) = _NameDto;

  factory NameDto.fromJson(Map<String, dynamic> json) =>
      _$NameDtoFromJson(json);
}
```

### 3. Mapper Pattern

```dart
// lib/features/[feature]/data/mappers/[name]_mapper.dart
extension NameDtoMapper on NameDto {
  Name toEntity() {
    return Name(
      id: id,
      field1: field1,
      field2: field2,
      createdAt: DateTime.parse(createdAt),  // String → DateTime
    );
  }
}

extension NameEntityMapper on Name {
  NameDto toDto() {
    return NameDto(
      id: id,
      field1: field1,
      field2: field2,
      createdAt: createdAt.toIso8601String(),  // DateTime → String
    );
  }
}
```

### 4. Entity Pattern

```dart
// lib/features/[feature]/domain/entities/[name].dart
@freezed
class Name with _$Name {
  const factory Name({
    required int id,
    required String field1,
    String? field2,
    required DateTime createdAt,  // Proper Dart type
  }) = _Name;
}
```

### 5. UseCase Pattern

```dart
// lib/features/[feature]/domain/usecases/[name]_usecase.dart
import 'package:fpdart/fpdart.dart';  // ← Use fpdart, not dartz

class NameUseCase {
  final FeatureRepository _repository;
  
  NameUseCase(this._repository);
  
  Future<Either<Failure, Entity>> call() async {
    return await _repository.method();
  }
}
```

### 6. Provider Pattern

```dart
// lib/features/[feature]/presentation/providers/[name]_provider.dart
Exception _mapFailureToException(Failure failure) {
  return failure.when(
    server: (message, code, requestId) => ServerException(message),
    network: (message, code) => NetworkException(message),
    validation: (message, code, details, requestId) => 
        ValidationException(message, details),
    auth: (message, code, requestId) => AuthException(message),
    notFound: (message, code, requestId) => NotFoundException(message),
    conflict: (message, code, requestId) => ConflictException(message),
    rateLimit: (message, code, requestId) => RateLimitException(message),
  );
}
```

---

## Common Commands

### Code Generation
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Analysis
```bash
flutter analyze
```

### Format Code
```bash
dart format lib/
```

### Run Tests
```bash
flutter test
```

### Search for dartz
```bash
grep -r "package:dartz" lib/
grep -r "Right(" lib/
grep -r "Left(" lib/
```

---

## Checklist for Each Feature

- [ ] Create DTOs with `@freezed` and `@JsonSerializable`
- [ ] Create Mappers with `toEntity()` and `toDto()` extensions
- [ ] Run code generation
- [ ] Update Repository to extend BaseRepository
- [ ] Use `executeApiCall()` wrapper
- [ ] Remove manual try-catch blocks
- [ ] Update Repository interface to use fpdart
- [ ] Update all UseCases to use fpdart
- [ ] Use lowercase `right()` and `left()`
- [ ] Update Providers to use 7 exception types
- [ ] Update UI error handling
- [ ] Manual testing
- [ ] Verify errors are resolved

---

## Success Criteria

When you're done, you should have:

✅ Zero `dartz` imports  
✅ Zero `Right()` or `Left()` constructors (use lowercase)  
✅ All 96 errors resolved  
✅ BaseRepository used by all 5 features  
✅ All features tested and working  
✅ Build succeeds without warnings  
✅ All tests pass  

---

## Need Help?

- **Requirements**: `.kiro/specs/features-refactor/requirements.md`
- **Design**: `.kiro/specs/features-refactor/design.md`
- **Tasks**: `.kiro/specs/features-refactor/tasks.md`
- **Auth Template**: `.kiro/specs/auth-refactor/` (completed example)
- **API Flow Template**: `.kiro/steering/api_flow_template.md`
- **Riverpod 3 Standards**: `.kiro/steering/riverpod_3_prompt.md`
- **Tech Stack Rules**: `.kiro/steering/tech.md`

---

## Ready to Start?

1. Open `.kiro/specs/features-refactor/tasks.md`
2. Start with Task 1.1 (Profile feature)
3. Follow the patterns above
4. Test after each feature
5. Celebrate when all 96 errors are gone! 🎉
