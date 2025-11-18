# 🏗️ Clean Architecture - Auth Module

## Tổng quan cấu trúc

Module Auth được tổ chức theo Clean Architecture với các cải tiến best practices 2024-2025:

```
features/auth/
├── domain/              # Business logic & contracts
│   ├── entities/        # Core business models (immutable)
│   ├── repositories/    # Repository interfaces
│   └── datasources/     # Data source interfaces
│
├── data/                # Implementation & external data
│   ├── models/          # Data transfer objects (DTO)
│   ├── repositories/    # Repository implementations
│   └── datasources/     # API & local storage implementations
│
└── presentation/        # UI layer
    ├── pages/           # Screen widgets
    ├── widgets/         # Reusable UI components
    ├── providers/       # Riverpod providers (@riverpod)
    └── state/           # State classes (Freezed)
```

## ✨ Key Features

### 1. Riverpod 3 Code Generation
- ✅ Type-safe providers với `@riverpod` annotation
- ✅ Auto-dispose và dependency injection
- ✅ Compile-time safety
- ✅ Less boilerplate (40% ít code hơn)

### 2. AsyncNotifier Pattern
- ✅ Automatic loading/error state management
- ✅ AsyncValue cho reactive UI
- ✅ Built-in retry mechanism
- ✅ Cleaner error handling

### 3. Streamlined Use Cases
- ✅ Loại bỏ UseCase layer cho operations đơn giản
- ✅ Gọi repository trực tiếp từ providers
- ✅ Giữ UseCases cho complex business logic

### 4. Modern State Management
- ✅ Freezed cho immutable states
- ✅ State hierarchy: Loading → Data/Error
- ✅ Helper providers cho common queries

## 📁 File Structure Chi Tiết

### Domain Layer
```dart
domain/
├── entities/
│   ├── user.dart                    # User entity (Freezed)
│   ├── user.freezed.dart           # Generated
│   ├── auth_tokens.dart            # Token entity (Freezed)
│   └── auth_tokens.freezed.dart    # Generated
│
├── repositories/
│   └── auth_repository.dart        # Repository interface (abstract class)
│
└── datasources/
    ├── auth_remote_datasource.dart  # API interface
    └── auth_local_datasource.dart   # Storage interface
```

**Nguyên tắc Domain Layer:**
- ❌ Không phụ thuộc vào layer khác
- ❌ Không import Flutter/Dio/Storage
- ✅ Pure Dart code only
- ✅ Defines contracts (interfaces)
- ✅ Contains business entities

### Data Layer
```dart
data/
├── models/
│   ├── user_model.dart             # User DTO với JSON serialization
│   ├── user_model.freezed.dart     # Generated
│   ├── user_model.g.dart           # Generated JSON
│   ├── auth_tokens_model.dart      # Token DTO
│   ├── auth_tokens_model.freezed.dart
│   └── auth_tokens_model.g.dart
│
├── repositories/
│   └── auth_repository_impl.dart   # Repository implementation
│
└── datasources/
    ├── auth_remote_datasource_impl.dart  # API implementation (Dio)
    └── auth_local_datasource_impl.dart   # Storage impl (SecureStorage)
```

**Nguyên tắc Data Layer:**
- ✅ Implements domain interfaces
- ✅ Handles external data (API, DB, Storage)
- ✅ Converts Models ↔ Entities
- ✅ Error handling & mapping

### Presentation Layer
```dart
presentation/
├── providers/
│   ├── auth_repository_provider.dart     # @riverpod providers
│   │   ├── secureStorageProvider
│   │   ├── dioProvider
│   │   ├── authRemoteDataSourceProvider
│   │   ├── authLocalDataSourceProvider
│   │   └── authRepositoryProvider
│   │
│   └── auth_state_provider.dart          # @riverpod state management
│       ├── authProvider (AsyncNotifier)
│       ├── currentUserProvider
│       ├── isAuthenticatedProvider
│       └── isLoggedInProvider
│
├── state/
│   ├── auth_state.dart              # Freezed state class
│   └── auth_state.freezed.dart      # Generated
│
├── pages/
│   ├── login_screen.dart            # Login UI
│   ├── login_screen_modern.dart     # New AsyncValue pattern
│   ├── register_screen.dart         # Registration UI
│   ├── otp_verification_screen.dart # Email verification
│   └── forgot_password_screen.dart  # Password reset
│
└── widgets/
    └── social_login_button.dart     # Reusable components
```

**Nguyên tắc Presentation Layer:**
- ✅ Consumes domain through providers
- ✅ Reactive UI với ref.watch()
- ✅ Stateless/HookConsumerWidget
- ✅ No business logic in widgets

## 🔄 Data Flow

### Login Flow Example
```
1. User taps Login Button
   ↓
2. LoginScreen calls:
   ref.read(authProvider.notifier).login(email, password)
   ↓
3. AuthNotifier (AsyncNotifier):
   - Sets state = AsyncValue.loading()
   - Calls authRepository.login()
   ↓
4. AuthRepositoryImpl:
   - Calls remoteDataSource.login() → API
   - Calls localDataSource.saveTokens() → Storage
   - Maps AuthTokensModel → AuthTokens
   - Returns Either<Failure, AuthTokens>
   ↓
5. AuthNotifier:
   - Calls authRepository.getCurrentUser()
   - Updates state with user data
   - State becomes AsyncValue.data(AuthState(user: user))
   ↓
6. LoginScreen (watching authProvider):
   - Rebuilds automatically
   - Shows success/error based on AsyncValue
   - Navigates on success
```

### State Updates Flow
```
AsyncValue.loading()
    ↓
AsyncValue.data(AuthState)    ← Success
    or
AsyncValue.error(Exception)    ← Failure
    ↓
UI automatically rebuilds
```

## 💡 Usage Examples

### 1. Login
```dart
// In UI
class LoginScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authProvider);
    
    return authAsync.when(
      data: (state) => Text('Logged in: ${state.user?.username}'),
      loading: () => CircularProgressIndicator(),
      error: (e, stack) => Text('Error: $e'),
    );
  }
  
  Future<void> _handleLogin() async {
    try {
      await ref.read(authProvider.notifier).login(
        usernameOrEmail: 'user@example.com',
        password: 'password',
      );
      // Success
    } catch (e) {
      // Error
    }
  }
}
```

### 2. Check Auth Status
```dart
// Simple boolean check
final isLoggedIn = ref.watch(isLoggedInProvider);

if (isLoggedIn) {
  return HomeScreen();
} else {
  return LoginScreen();
}
```

### 3. Get Current User
```dart
// Get user directly
final user = ref.watch(currentUserProvider);

if (user != null) {
  return Text('Hello ${user.username}');
}
```

### 4. Logout
```dart
// In UI
await ref.read(authProvider.notifier).logout();
// State automatically updates to unauthenticated
```

## 🛠️ Development Workflow

### 1. Make Changes
Edit provider/state files with `@riverpod` annotations

### 2. Generate Code
```bash
# Watch mode (recommended during development)
dart run build_runner watch --delete-conflicting-outputs

# One-time build
dart run build_runner build --delete-conflicting-outputs
```

### 3. Generated Files
- `*.g.dart` - JSON serialization
- `*.freezed.dart` - Freezed classes
- `*_provider.g.dart` - Riverpod providers

## 📦 Dependencies

### Production
```yaml
dependencies:
  # State Management
  hooks_riverpod: ^3.0.3
  flutter_hooks: ^0.21.3+1
  riverpod_annotation: ^3.0.3
  
  # Immutability & Serialization
  freezed_annotation: ^3.0.0
  json_annotation: ^4.9.0
  
  # Functional Programming
  dartz: ^0.10.1
  
  # Network & Storage
  dio: ^5.9.0
  flutter_secure_storage: ^10.0.0-beta.4
```

### Development
```yaml
dev_dependencies:
  # Code Generation
  riverpod_generator: ^3.0.3
  build_runner: ^2.7.1
  riverpod_lint: ^3.0.3
  freezed: ^3.2.3
  json_serializable: ^6.7.1
  custom_lint: ^0.8.0
```

## ✅ Best Practices

### DO ✅
- Use `@riverpod` annotation cho tất cả providers
- Use `AsyncNotifier` cho state có side effects
- Use `Freezed` cho all data classes
- Use `AsyncValue.guard()` cho error handling
- Keep domain layer pure (no external dependencies)
- Use const constructors khi có thể
- Dispose controllers trong widgets

### DON'T ❌
- Don't use manual Provider declarations
- Don't create UseCases cho simple CRUD operations
- Don't put business logic in widgets
- Don't ignore AsyncValue states
- Don't mutate state directly
- Don't forget to run build_runner after changes

## 🧪 Testing

### Unit Tests
```dart
test('login should update state with user data', () async {
  final container = ProviderContainer(
    overrides: [
      authRepositoryProvider.overrideWithValue(mockRepository),
    ],
  );
  
  await container.read(authProvider.notifier).login(...);
  
  final state = container.read(authProvider);
  expect(state.hasValue, true);
  expect(state.value?.user, isNotNull);
});
```

### Widget Tests
```dart
testWidgets('shows loading indicator during login', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      child: LoginScreen(),
    ),
  );
  
  // Tap login
  await tester.tap(find.byType(PrimaryButton));
  await tester.pump();
  
  // Verify loading state
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});
```

## 🔐 Security Notes

- ✅ Tokens stored in FlutterSecureStorage (encrypted)
- ✅ Auto token refresh via interceptor
- ✅ HTTPS only in production
- ✅ No sensitive data in logs
- ✅ Proper session management

## 📚 Further Reading

- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Riverpod Documentation](https://riverpod.dev)
- [Freezed Package](https://pub.dev/packages/freezed)
- [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage)

## 🤝 Contributing

When adding new features:
1. Create entities in domain layer first
2. Define repository interfaces
3. Implement in data layer
4. Create providers with @riverpod
5. Build UI with AsyncValue pattern
6. Run build_runner
7. Write tests

---

**Last Updated:** November 2024
**Architecture Version:** 2.0 (Riverpod 3)

