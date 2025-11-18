# 🔄 MIGRATION GUIDE - Auth Module Refactoring
4. Update other features to use new providers
3. Run tests
2. Delete unused UseCase files (optional, keep if needed later)
1. Delete old auth_providers.dart
After migration:

## 🚀 Next Steps

- [AsyncValue Patterns](https://riverpod.dev/docs/concepts/reading#asyncvalue)
- [AsyncNotifier Guide](https://riverpod.dev/docs/providers/notifier_provider)
- [Riverpod Code Generation Docs](https://riverpod.dev/docs/concepts/about_code_generation)

## 📚 Additional Resources

   - Use `AsyncValue.error` or catch exceptions
   - No more `errorMessage` field in state
4. **Error Handling:**

   - `Future<bool>` → `Future<void>` (throws on error)
3. **Method Return Types:**

   - Access via `.value`, `.when()`, `.maybeWhen()`, etc.
   - `AuthState` → `AsyncValue<AuthState>`
2. **State Type Changed:**

   - All UseCase providers removed
   - `authNotifierProvider` → `authProvider`
1. **Provider Names Changed:**

## ⚠️ Breaking Changes

```
return AuthState(data: data); // AsyncValue.guard handles it
);
  (data) => data,
  (failure) => throw _mapToException(failure),
final data = result.fold(
// New - throw and let AsyncValue catch

);
  (data) => state = state.copyWith(data: data),
  (failure) => state = state.copyWith(error: failure),
result.fold(
// Old - manual Either handling everywhere
```dart
### 4. Better Error Handling

```
@Riverpod(keepAlive: true)  // or auto-dispose by default
// New - declarative

bool updateShouldNotify(old, new) => true;
@override
// Old - manual keepAlive management
```dart
### 3. Auto-Dispose

```
final repo = ref.read(authRepositoryProvider); // Generated, always exists
// New - compile-time safety

final repo = ref.read(authRepositoryProvider);
// Old - runtime error if provider not found
```dart
### 2. Type Safety

- ✅ AsyncValue handles states
- ✅ Auto-generated providers
- ❌ No manual loading/error state management
- ❌ No UseCase classes for simple operations
- ❌ No manual Provider declarations
### 1. Less Boilerplate

## 🎯 Key Benefits

```
}
  print(authState.error);
if (authState.hasError) {
final authState = ref.read(authProvider);
// Or check state after

}
  // Error - handle with e.toString()
} catch (e) {
  // Success - state automatically contains user data
  await ref.read(authProvider.notifier).login(...);
try {
```dart
**After:**

```
}
  // Handle error
  final error = ref.read(authErrorProvider);
} else {
  // Handle success
if (success) {
final success = await ref.read(authNotifierProvider.notifier).login(...);
```dart
**Before:**

### Step 5: Update Method Calls

```
final isLoggedIn = ref.watch(isLoggedInProvider);
final user = ref.watch(currentUserProvider);
// Pattern 3: Helper providers

final error = authAsync.error;
final isLoading = authAsync.isLoading;
final user = authAsync.value?.user;
// Pattern 2: Direct access

);
  error: (e, stack) => Text(e.toString()),
  loading: () => CircularProgressIndicator(),
  data: (state) => Text(state.user?.username ?? ''),
authAsync.when(
// Pattern 1: Using when()

final authAsync = ref.watch(authProvider);
```dart
**After:**

```
final error = authState.errorMessage;
final isLoading = authState.isLoading;
final user = authState.user;
final authState = ref.watch(authNotifierProvider);
```dart
**Before:**

### Step 4: Update State Access

| `isLoggedInUseCaseProvider` | `isLoggedInProvider` |
| `loginUseCaseProvider` | ❌ Removed - call repository directly |
| `authStateProvider` | `authProvider` (returns AsyncValue) |
| `authNotifierProvider.notifier` | `authProvider.notifier` |
| `authNotifierProvider` | `authProvider` |
|-----|-----|
| Old | New |

### Step 3: Update Provider References

```
import 'package:chattrix_ui/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_state_provider.dart';
```dart
**After:**

```
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
```dart
**Before:**
### Step 2: Update Imports

```
dart run build_runner build --delete-conflicting-outputs
```bash
### Step 1: Run Code Generation

## 🔧 Migration Steps

```
final isLoggedIn = ref.watch(isLoggedInProvider); // bool
// Check if fully logged in

final isAuth = ref.watch(isAuthenticatedProvider); // bool
// Check if authenticated

final user = ref.watch(currentUserProvider); // User?
// Get current user directly
```dart
**After (New convenience providers):**

### 4. Helper Providers

```
}
  }
    );
      ],
        ),
          },
            }
              }
                Toasts.error(context, description: e.toString());
              if (context.mounted) {
              // Error already in state, handle UI feedback
            } catch (e) {
              }
                context.go('/home');
              if (context.mounted) {
              // Success - state automatically updated
              await ref.read(authProvider.notifier).login(...);
            try {
          onPressed: authAsync.isLoading ? null : () async {
        ElevatedButton(
        ),
          error: (error, stack) => Text(error.toString()),
          loading: () => CircularProgressIndicator(),
          data: (authState) => Text('Welcome ${authState.user?.username ?? ""}'),
        authAsync.when(
      children: [
    return Column(

    final authAsync = ref.watch(authProvider);
  Widget build(BuildContext context, WidgetRef ref) {
class LoginScreen extends HookConsumerWidget {
```dart
**After:**

```
}
  }
    );
      ],
        ),
          },
            }
              // Show error
            } else {
              // Navigate
            if (success) {
            
              .login(...);
              .read(authNotifierProvider.notifier)
            final success = await ref
          onPressed: () async {
        ElevatedButton(
        if (error != null) Text(error),
        if (isLoading) CircularProgressIndicator(),
      children: [
    return Column(

    final error = authState.errorMessage;
    final isLoading = authState.isLoading;
    final authState = ref.watch(authNotifierProvider);
  Widget build(BuildContext context, WidgetRef ref) {
class LoginScreen extends HookConsumerWidget {
```dart
**Before:**

### 3. UI Usage

```
}
  }
    });
      return AuthState(user: user, isAuthenticated: true);
      // Login logic - throw on error
    state = await AsyncValue.guard(() async {
    state = const AsyncValue.loading();
  Future<void> login(...) async {

  }
    return const AuthState();
    // Auto-load on init
  Future<AuthState> build() async {
  @override
class Auth extends _$Auth {
@Riverpod(keepAlive: true)
```dart
**After:**

```
}
  }
    return true;
    state = state.copyWith(isLoading: false, user: user);
    // ... manual error handling
    state = state.copyWith(isLoading: true);
  Future<bool> login(...) async {

  }
    return AuthState();
  AuthState build() {
  @override
class AuthNotifier extends Notifier<AuthState> {
```dart
**Before:**

### 2. Auth State Management

```
// No more UseCase providers needed!

}
  return AuthRepositoryImpl(...);
AuthRepository authRepository(AuthRepositoryRef ref) {
@Riverpod(keepAlive: true)
```dart
**After:**

```
});
  return LoginUseCase(ref.watch(authRepositoryProvider));
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {

});
  return AuthRepositoryImpl(...);
final authRepositoryProvider = Provider<AuthRepository>((ref) {
```dart
**Before:**

### 1. Provider Declarations

## 📝 Thay đổi chi tiết

```
- Auto loading/error with AsyncValue
- ref.watch(authProvider) // AsyncValue<AuthState>
- ref.read(authProvider.notifier).login()
Cách sử dụng:

- Repositories only (no UseCases for simple operations)
Domain Layer:

- auth_state.dart (Freezed state)
- auth_state_provider.dart (@riverpod AsyncNotifier)
- auth_repository_provider.dart (@riverpod providers)
Presentation Layer:
```
### New Architecture (After - Riverpod 3 Best Practices)

```
- Manual error handling
- ref.watch(authStateProvider)
- ref.read(authNotifierProvider.notifier).login()
Cách sử dụng:

- 12 UseCase classes (1 class cho mỗi action)
Domain Layer:

- Manual loading/error state management
- AuthState class thủ công
- auth_providers.dart (Provider + Notifier thủ công)
Presentation Layer:
```
### Old Architecture (Before)

## Tổng quan thay đổi


