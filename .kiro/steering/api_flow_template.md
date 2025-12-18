# API Flow Template - Flutter Clean Architecture

## Mục đích
Template này định nghĩa cách xử lý một API endpoint từ đầu đến cuối trong Flutter Clean Architecture, đảm bảo error handling đầy đủ dựa trên API spec.

## Dependencies
```yaml
dependencies:
  # Functional Programming
  fpdart: ^1.2.0  # ✅ Use this (actively maintained, null-safe native)
  # dartz: ^0.10.1  # ❌ Don't use (deprecated, no longer maintained)
  
  # State Management
  hooks_riverpod: ^3.0.3
  riverpod_annotation: ^3.0.3
  flutter_hooks: ^0.21.3
  
  # Data Serialization
  freezed_annotation: ^3.0.0
  json_annotation: ^4.9.0
  
  # Networking
  dio: ^5.9.0

dev_dependencies:
  # Code Generation
  build_runner: ^2.7.1
  freezed: ^3.2.3
  json_serializable: ^6.7.1
  riverpod_generator: ^3.0.3
  riverpod_lint: ^3.0.3
  custom_lint: ^0.8.0
```

---

## 1. Phân tích API Endpoint

### Thông tin cơ bản
- **Endpoint**: `[METHOD] /api/v1/[path]`
- **Tag**: [Authentication/Users/Messages/Conversations/Call/etc]
- **Authentication**: Required/Not Required
- **Description**: [Mô tả chức năng]

### Request
```yaml
# Path Parameters
- param1: type (description)

# Query Parameters  
- param1: type (default: value, description)

# Request Body
{
  "field1": "type (required/optional)",
  "field2": "type (required/optional)"
}
```

### Response Success (200/201)
```json
{
  "success": true,
  "message": "Success message",
  "data": {
    // Response data structure
  }
}
```

### Response Errors
| Status | Code | Message | Khi nào xảy ra |
|--------|------|---------|----------------|
| 400 | VALIDATION_ERROR | "Validation failed" | Input không hợp lệ |
| 401 | UNAUTHORIZED | "Invalid or expired token" | Token không hợp lệ |
| 403 | FORBIDDEN | "Access denied" | Không có quyền |
| 404 | RESOURCE_NOT_FOUND | "Resource not found" | Không tìm thấy |
| 409 | CONFLICT | "Resource conflict" | Xung đột dữ liệu |
| 429 | RATE_LIMIT_EXCEEDED | "Too many requests" | Vượt rate limit |

---

## 2. Data Layer Implementation

### 2.1. DTO (Data Transfer Object)
**File**: `lib/data/models/[feature]/[name]_dto.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '[name]_dto.freezed.dart';
part '[name]_dto.g.dart';

/// DTO for API request
@freezed
class [Name]RequestDto with _$[Name]RequestDto {
  const factory [Name]RequestDto({
    required String field1,
    String? field2,
  }) = _[Name]RequestDto;

  factory [Name]RequestDto.fromJson(Map<String, dynamic> json) =>
      _$[Name]RequestDtoFromJson(json);
}

/// DTO for API response
@freezed
class [Name]ResponseDto with _$[Name]ResponseDto {
  const factory [Name]ResponseDto({
    required int id,
    required String field1,
    String? field2,
  }) = _[Name]ResponseDto;

  factory [Name]ResponseDto.fromJson(Map<String, dynamic> json) =>
      _$[Name]ResponseDtoFromJson(json);
}
```

**Lưu ý:**
- DTO chỉ dùng trong Data Layer
- Nullable fields (`String?`) cho các field có thể null trong API (NON_NULL serialization)
- Không import Flutter/Domain dependencies

### 2.2. Mapper (DTO ↔ Entity)
**File**: `lib/data/mappers/[feature]/[name]_mapper.dart`

```dart
import '../../models/[feature]/[name]_dto.dart';
import '../../../domain/entities/[feature]/[name]_entity.dart';

extension [Name]DtoMapper on [Name]ResponseDto {
  [Name]Entity toEntity() {
    return [Name]Entity(
      id: id,
      field1: field1,
      field2: field2,
    );
  }
}

extension [Name]EntityMapper on [Name]Entity {
  [Name]RequestDto toDto() {
    return [Name]RequestDto(
      field1: field1,
      field2: field2,
    );
  }
}
```

### 2.3. API Service
**File**: `lib/data/datasources/remote/[feature]_api_service.dart`

```dart
import 'package:dio/dio.dart';
import '../../models/[feature]/[name]_dto.dart';
import '../../../core/network/api_response.dart';

class [Feature]ApiService {
  final Dio _dio;

  [Feature]ApiService(this._dio);

  /// [Endpoint description]
  /// 
  /// **Endpoint**: `[METHOD] /api/v1/[path]`
  /// 
  /// **Errors:**
  /// - 400: Validation failed
  /// - 401: Unauthorized
  /// - 404: Not found
  Future<ApiResponse<[Name]ResponseDto>> [methodName]({
    required String param1,
    String? param2,
  }) async {
    final response = await _dio.[method](
      '/v1/[path]',
      data: {
        'field1': param1,
        if (param2 != null) 'field2': param2,
      },
    );

    return ApiResponse<[Name]ResponseDto>.fromJson(
      response.data,
      (json) => [Name]ResponseDto.fromJson(json as Map<String, dynamic>),
    );
  }
}
```

### 2.4. Base Repository (DRY - Don't Repeat Yourself)
**File**: `lib/data/repositories/base_repository.dart`

```dart
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';

/// Base repository with common error handling
/// 
/// **Usage**: Extend this class in all repository implementations
abstract class BaseRepository {
  /// Execute API call with automatic error handling
  /// 
  /// **Returns**: Either<Failure, T>
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
      return left(ServerFailure(
        message: 'Unexpected error: $e',
        code: 'UNEXPECTED_ERROR',
      ));
    }
  }

  /// Handle API exceptions from interceptor
  Failure _handleApiException(ApiException e) {
    switch (e.code) {
      case 'VALIDATION_ERROR':
        return ValidationFailure(
          message: e.message,
          code: e.code,
          details: e.details,
        );
      case 'UNAUTHORIZED':
        return AuthFailure(
          message: e.message,
          code: e.code,
        );
      case 'FORBIDDEN':
        return AuthFailure(
          message: e.message,
          code: e.code,
        );
      case 'RESOURCE_NOT_FOUND':
        return NotFoundFailure(
          message: e.message,
          code: e.code,
        );
      case 'CONFLICT':
        return ConflictFailure(
          message: e.message,
          code: e.code,
        );
      case 'RATE_LIMIT_EXCEEDED':
        return RateLimitFailure(
          message: e.message,
          code: e.code,
        );
      default:
        return ServerFailure(
          message: e.message,
          code: e.code,
        );
    }
  }

  /// Handle Dio exceptions (network errors)
  Failure _handleDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return NetworkFailure(
        message: 'Connection timeout',
        code: 'TIMEOUT',
      );
    } else if (e.type == DioExceptionType.connectionError) {
      return NetworkFailure(
        message: 'No internet connection',
        code: 'NO_CONNECTION',
      );
    } else {
      return ServerFailure(
        message: e.message ?? 'Server error',
        code: 'SERVER_ERROR',
      );
    }
  }
}
```

### 2.5. Repository Implementation (Clean & Simple)
**File**: `lib/data/repositories/[feature]_repository_impl.dart`

```dart
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/[feature]/[name]_entity.dart';
import '../../domain/repositories/[feature]_repository.dart';
import '../../core/error/failures.dart';
import '../datasources/remote/[feature]_api_service.dart';
import '../mappers/[feature]/[name]_mapper.dart';
import 'base_repository.dart';

class [Feature]RepositoryImpl extends BaseRepository 
    implements [Feature]Repository {
  final [Feature]ApiService _apiService;

  [Feature]RepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, [Name]Entity>> [methodName]({
    required String param1,
    String? param2,
  }) async {
    return executeApiCall(() async {
      final response = await _apiService.[methodName](
        param1: param1,
        param2: param2,
      );

      if (response.success && response.data != null) {
        return response.data!.toEntity();
      } else {
        throw ApiException(
          message: response.message ?? 'Unknown error',
          code: 'UNKNOWN_ERROR',
          statusCode: 500,
        );
      }
    });
  }
}
```

**Lợi ích:**
- ✅ Không lặp code error handling
- ✅ Consistent error handling across all repositories
- ✅ Easy to maintain và update
- ✅ Repository code ngắn gọn, tập trung vào business logic

---

## 3. Domain Layer Implementation

### 3.1. Entity
**File**: `lib/domain/entities/[feature]/[name]_entity.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '[name]_entity.freezed.dart';

/// Domain entity - framework agnostic
/// 
/// **KHÔNG ĐƯỢC import:**
/// - Flutter packages
/// - Dio
/// - json_annotation
/// - Bất kỳ Data Layer dependencies nào
@freezed
class [Name]Entity with _$[Name]Entity {
  const factory [Name]Entity({
    required int id,
    required String field1,
    String? field2,
  }) = _[Name]Entity;
}
```

### 3.2. Repository Interface
**File**: `lib/domain/repositories/[feature]_repository.dart`

```dart
import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/[feature]/[name]_entity.dart';

/// Repository interface - defines contract
/// 
/// **Implementation**: Data Layer
abstract class [Feature]Repository {
  /// [Method description]
  /// 
  /// Returns [Right] with [Name]Entity on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, [Name]Entity>> [methodName]({
    required String param1,
    String? param2,
  });
}
```

### 3.3. Use Case
**File**: `lib/domain/usecases/[feature]/[name]_usecase.dart`

```dart
import 'package:fpdart/fpdart.dart';
import '../../../core/error/failures.dart';
import '../../entities/[feature]/[name]_entity.dart';
import '../../repositories/[feature]_repository.dart';

/// Use case for [description]
/// 
/// **Single Responsibility**: Execute one business operation
class [Name]UseCase {
  final [Feature]Repository _repository;

  [Name]UseCase(this._repository);

  /// Execute the use case
  /// 
  /// **Parameters:**
  /// - [param1]: Description
  /// - [param2]: Description (optional)
  /// 
  /// **Returns:**
  /// - Right([Name]Entity): Success
  /// - Left(Failure): Error occurred
  Future<Either<Failure, [Name]Entity>> call({
    required String param1,
    String? param2,
  }) async {
    // Business logic validation (if needed)
    if (param1.isEmpty) {
      return left(ValidationFailure(
        message: 'Param1 cannot be empty',
        code: 'INVALID_INPUT',
      ));
    }

    // Call repository
    return await _repository.[methodName](
      param1: param1,
      param2: param2,
    );
  }
}
```

---

## 4. Presentation Layer Implementation

### 4.1. State Provider (Riverpod 3)
**File**: `lib/presentation/providers/[feature]/[name]_provider.dart`

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/entities/[feature]/[name]_entity.dart';
import '../../../domain/usecases/[feature]/[name]_usecase.dart';
import '../../../core/error/failures.dart';

part '[name]_provider.g.dart';

/// Provider for [description]
/// 
/// **State**: AsyncValue<[Name]Entity>
/// **Lifecycle**: Auto-dispose (or keepAlive: true if needed)
@riverpod
class [Name]Notifier extends _$[Name]Notifier {
  late final [Name]UseCase _useCase;

  @override
  Future<[Name]Entity> build() async {
    _useCase = ref.read([name]UseCaseProvider);
    
    // Initial state - can throw or return default
    throw UnimplementedError('Call execute() to load data');
  }

  /// Execute the operation
  Future<void> execute({
    required String param1,
    String? param2,
  }) async {
    // Set loading state
    state = const AsyncValue.loading();

    // Execute use case
    final result = await _useCase(
      param1: param1,
      param2: param2,
    );

    // Update state based on result
    state = result.fold(
      (failure) => AsyncValue.error(
        _mapFailureToException(failure),
        StackTrace.current,
      ),
      (entity) => AsyncValue.data(entity),
    );
  }

  /// Map Failure to Exception for AsyncValue
  Exception _mapFailureToException(Failure failure) {
    if (failure is ValidationFailure) {
      return ValidationException(failure.message, failure.details);
    } else if (failure is AuthFailure) {
      return AuthException(failure.message);
    } else if (failure is NotFoundFailure) {
      return NotFoundException(failure.message);
    } else if (failure is NetworkFailure) {
      return NetworkException(failure.message);
    } else {
      return ServerException(failure.message);
    }
  }
}

/// Custom exceptions for UI
class ValidationException implements Exception {
  final String message;
  final Map<String, String>? details;
  ValidationException(this.message, [this.details]);
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}
```

### 4.2. UI Widget
**File**: `lib/presentation/screens/[feature]/[name]_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../providers/[feature]/[name]_provider.dart';

class [Name]Screen extends HookConsumerWidget {
  const [Name]Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch provider state
    final asyncState = ref.watch([name]NotifierProvider);
    
    // Controllers
    final param1Controller = useTextEditingController();
    
    // Handle async operation
    Future<void> handleSubmit() async {
      final notifier = ref.read([name]NotifierProvider.notifier);
      
      try {
        await notifier.execute(
          param1: param1Controller.text,
        );
        
        // Check if widget is still mounted
        if (!context.mounted) return;
        
        // Success - navigate or show message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Success!')),
        );
      } catch (e) {
        // Error is already in state, will be handled by switch below
        debugPrint('Error: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('[Screen Title]')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input fields
            TextField(
              controller: param1Controller,
              decoration: const InputDecoration(labelText: 'Param 1'),
            ),
            const SizedBox(height: 16),
            
            // Submit button
            ElevatedButton(
              onPressed: asyncState.isLoading ? null : handleSubmit,
              child: asyncState.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Submit'),
            ),
            const SizedBox(height: 24),
            
            // State handling
            Expanded(
              child: switch (asyncState) {
                AsyncData(:final value) => _buildSuccess(value),
                AsyncError(:final error) => _buildError(context, error),
                AsyncLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                _ => const Center(child: Text('Ready')),
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccess([Name]Entity entity) {
    return Column(
      children: [
        Text('ID: ${entity.id}'),
        Text('Field1: ${entity.field1}'),
        if (entity.field2 != null) Text('Field2: ${entity.field2}'),
      ],
    );
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
          // context.go('/login');
        }
      });
    } else if (error is NotFoundException) {
      message = error.message;
    } else if (error is NetworkException) {
      message = error.message;
    } else if (error is ServerException) {
      message = error.message;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          if (details != null) ...[
            const SizedBox(height: 8),
            Text(
              details,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
```

---

## 5. Core Infrastructure

### 5.1. Base Repository
**File**: `lib/data/repositories/base_repository.dart`

Xem section 2.4 ở trên. BaseRepository cung cấp:
- `executeApiCall<T>()` - Wrapper cho tất cả API calls
- Centralized error handling
- Consistent error mapping

**Lưu ý**: Tạo file này **1 lần duy nhất** cho toàn project, tất cả repositories sẽ extend nó.

### 5.2. Exceptions
**File**: `lib/core/error/exceptions.dart`

```dart
/// API Exception thrown by interceptor
class ApiException implements Exception {
  final String message;
  final String code;
  final int statusCode;
  final Map<String, String>? details;

  ApiException({
    required this.message,
    required this.code,
    required this.statusCode,
    this.details,
  });

  @override
  String toString() => 'ApiException($code): $message';
}
```

### 5.3. Failures
**File**: `lib/core/error/failures.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Base failure class - used in Domain & Data layers
/// 
/// Note: Use `abstract class` with @freezed for union types (multiple factory constructors)
@freezed
abstract class Failure with _$Failure {
  const factory Failure.server({
    required String message,
    required String code,
  }) = ServerFailure;

  const factory Failure.network({
    required String message,
    required String code,
  }) = NetworkFailure;

  const factory Failure.validation({
    required String message,
    required String code,
    Map<String, String>? details,
  }) = ValidationFailure;

  const factory Failure.auth({
    required String message,
    required String code,
  }) = AuthFailure;

  const factory Failure.notFound({
    required String message,
    required String code,
  }) = NotFoundFailure;

  const factory Failure.conflict({
    required String message,
    required String code,
  }) = ConflictFailure;

  const factory Failure.rateLimit({
    required String message,
    required String code,
  }) = RateLimitFailure;
}
```

### 5.4. API Response Wrapper
**File**: `lib/core/network/api_response.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

/// Generic API response wrapper
/// 
/// Note: Use `abstract class` with @Freezed for generic types
@Freezed(genericArgumentFactories: true)
abstract class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required bool success,
    required String message,
    T? data,
  }) = _ApiResponse<T>;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$ApiResponseFromJson(json, fromJsonT);
}
```

### 5.5. Dio Interceptor
**File**: `lib/core/network/api_interceptor.dart`

```dart
import 'package:dio/dio.dart';
import '../error/exceptions.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      final data = err.response!.data;
      
      if (data is Map<String, dynamic>) {
        throw ApiException(
          message: data['message'] ?? 'Unknown error',
          code: data['code'] ?? 'UNKNOWN_ERROR',
          statusCode: err.response!.statusCode ?? 500,
          details: data['details'] as Map<String, String>?,
        );
      }
    }
    
    super.onError(err, handler);
  }
}
```

---

## 6. Checklist Implementation

### Data Layer
- [ ] Tạo DTO với `@freezed` và `@JsonSerializable`
- [ ] Tạo Mapper (DTO ↔ Entity)
- [ ] Implement API Service method
- [ ] Tạo BaseRepository (chỉ 1 lần cho toàn project)
- [ ] Implement Repository extends BaseRepository
- [ ] Test repository với mock API service

### Domain Layer
- [ ] Tạo Entity (framework-agnostic, chỉ dùng freezed)
- [ ] Tạo Repository interface
- [ ] Implement Use Case với business logic
- [ ] Đảm bảo không import Flutter/Dio/json_annotation

### Presentation Layer
- [ ] Tạo Riverpod provider với `@riverpod`
- [ ] Implement state management (AsyncNotifier)
- [ ] Tạo UI widget với HookConsumerWidget
- [ ] Handle tất cả states: loading, data, error
- [ ] Check `context.mounted` sau mỗi `await`
- [ ] Map exceptions cho UI-friendly messages

### Error Handling
- [ ] Handle 400 - Validation errors với details
- [ ] Handle 401 - Redirect to login
- [ ] Handle 403 - Show permission denied
- [ ] Handle 404 - Show not found
- [ ] Handle 409 - Show conflict message
- [ ] Handle 429 - Show rate limit message
- [ ] Handle network errors (timeout, no connection)
- [ ] Handle unexpected errors

---

## 7. So sánh: Với và Không có BaseRepository

### ❌ KHÔNG dùng BaseRepository (Lặp code)

```dart
class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, User>> login(...) async {
    try {
      final response = await _apiService.login(...);
      return right(response.data!.toEntity());
    } on ApiException catch (e) {
      return left(_handleApiException(e)); // ← Lặp
    } on DioException catch (e) {
      return left(_handleDioException(e)); // ← Lặp
    }
  }
  
  Failure _handleApiException(ApiException e) { /* 50 lines */ } // ← Lặp
  Failure _handleDioException(DioException e) { /* 20 lines */ } // ← Lặp
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future<Either<Failure, User>> getProfile(...) async {
    try {
      final response = await _apiService.getProfile(...);
      return right(response.data!.toEntity());
    } on ApiException catch (e) {
      return left(_handleApiException(e)); // ← Lặp
    } on DioException catch (e) {
      return left(_handleDioException(e)); // ← Lặp
    }
  }
  
  Failure _handleApiException(ApiException e) { /* 50 lines */ } // ← Lặp
  Failure _handleDioException(DioException e) { /* 20 lines */ } // ← Lặp
}

// Mỗi repository: ~100 lines error handling code
// 10 repositories = 1000 lines lặp lại!
```

### ✅ Dùng BaseRepository (DRY)

```dart
// base_repository.dart - Chỉ 1 lần cho toàn project
abstract class BaseRepository {
  Future<Either<Failure, T>> executeApiCall<T>(
    Future<T> Function() apiCall,
  ) async {
    try {
      return right(await apiCall());
    } on ApiException catch (e) {
      return left(_handleApiException(e));
    } on DioException catch (e) {
      return left(_handleDioException(e));
    }
  }
  
  Failure _handleApiException(ApiException e) { /* 50 lines - 1 lần */ }
  Failure _handleDioException(DioException e) { /* 20 lines - 1 lần */ }
}

// auth_repository_impl.dart - Clean & Simple
class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  @override
  Future<Either<Failure, User>> login(...) async {
    return executeApiCall(() async {
      final response = await _apiService.login(...);
      if (response.success && response.data != null) {
        return response.data!.toEntity();
      }
      throw ApiException(message: 'Login failed', code: 'LOGIN_ERROR');
    });
  }
}

// user_repository_impl.dart - Clean & Simple
class UserRepositoryImpl extends BaseRepository implements UserRepository {
  @override
  Future<Either<Failure, User>> getProfile(...) async {
    return executeApiCall(() async {
      final response = await _apiService.getProfile(...);
      if (response.success && response.data != null) {
        return response.data!.toEntity();
      }
      throw ApiException(message: 'Get profile failed', code: 'PROFILE_ERROR');
    });
  }
}

// Mỗi repository: ~15 lines
// 10 repositories = 150 lines + 70 lines BaseRepository = 220 lines total
// Tiết kiệm: 780 lines! 🎉
```

### 📊 Lợi ích:

| Aspect | Không có Base | Có BaseRepository |
|--------|---------------|-------------------|
| **Code lặp** | ❌ Nhiều | ✅ Không |
| **Maintainability** | ❌ Khó | ✅ Dễ |
| **Consistency** | ❌ Không đồng nhất | ✅ Đồng nhất |
| **Lines of code** | ❌ 1000+ | ✅ 220 |
| **Bug risk** | ❌ Cao | ✅ Thấp |
| **Update error handling** | ❌ Update 10 files | ✅ Update 1 file |

---

## 8. Best Practices

### DO ✅
- Luôn dùng `Either<Failure, T>` cho async operations
- Dùng `fpdart` thay vì `dartz` (actively maintained, null-safe native)
- Dùng `right()` và `left()` (lowercase) thay vì `Right()` và `Left()`
- Check `context.mounted` sau mỗi `await`
- Dùng `switch` expression cho AsyncValue
- Map tất cả error codes từ API spec
- Validate input ở Use Case layer
- Dùng `keepAlive: true` cho persistent state
- Log errors với `debugPrint()`

### DON'T ❌
- Không dùng `dartz` (deprecated, không còn maintain)
- Không import Flutter vào Domain Layer
- Không dùng `print()` (dùng `debugPrint()`)
- Không modify state trong `ref.onDispose()`
- Không dùng `StatelessWidget` (dùng `ConsumerWidget`)
- Không hardcode error messages
- Không bỏ qua error handling
- Không dùng global variables cho resources

---

## 9. Testing Strategy

### Unit Tests
```dart
// Repository test
test('should return entity when API call succeeds', () async {
  // Arrange
  when(mockApiService.method()).thenAnswer((_) async => mockResponse);
  
  // Act
  final result = await repository.method();
  
  // Assert
  expect(result.isRight(), true);
  result.fold(
    (failure) => fail('Should not fail'),
    (entity) => expect(entity, expectedEntity),
  );
});

test('should return ValidationFailure when API returns 400', () async {
  // Arrange
  when(mockApiService.method()).thenThrow(
    ApiException(code: 'VALIDATION_ERROR', message: 'Invalid input'),
  );
  
  // Act
  final result = await repository.method();
  
  // Assert
  expect(result.isLeft(), true);
  result.fold(
    (failure) => expect(failure, isA<ValidationFailure>()),
    (entity) => fail('Should not succeed'),
  );
});
```

**Note**: `fpdart` API tương thích với `dartz`, nên test code không cần thay đổi nhiều.

---

## 10. Common Patterns

### Pagination
```dart
@riverpod
class ItemListNotifier extends _$ItemListNotifier {
  int _currentPage = 0;
  List<ItemEntity> _allItems = [];
  
  @override
  Future<List<ItemEntity>> build() async {
    return _loadPage(0);
  }
  
  Future<void> loadMore() async {
    if (state.isLoading) return;
    
    state = const AsyncValue.loading();
    _currentPage++;
    
    final result = await _useCase(page: _currentPage);
    
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (newItems) {
        _allItems.addAll(newItems);
        return AsyncValue.data(_allItems);
      },
    );
  }
}
```

### Refresh
```dart
Future<void> refresh() async {
  _currentPage = 0;
  _allItems = [];
  ref.invalidateSelf();
}
```

### Optimistic Update
```dart
Future<void> updateItem(ItemEntity item) async {
  // Optimistic update
  final oldState = state.value;
  state = AsyncValue.data(
    state.value!.map((e) => e.id == item.id ? item : e).toList(),
  );
  
  // API call
  final result = await _useCase.update(item);
  
  // Rollback on error
  result.fold(
    (failure) {
      state = AsyncValue.data(oldState!);
      // Show error
    },
    (_) {
      // Success - already updated
    },
  );
}
```
