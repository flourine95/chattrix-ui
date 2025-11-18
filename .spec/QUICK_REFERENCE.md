# 🚀 QUICK START - New Auth Providers

## TL;DR

Đã refactor auth module theo Riverpod 3 best practices. Dưới đây là cách sử dụng nhanh.

---

## 📦 Import

```dart
// Old ❌
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';

// New ✅
import 'package:chattrix_ui/features/auth/presentation/providers/auth_state_provider.dart';
```

---

## 🔑 Provider Names

| Action | Old ❌ | New ✅ |
|--------|--------|--------|
| Watch state | `authNotifierProvider` | `authProvider` |
| Read notifier | `authNotifierProvider.notifier` | `authProvider.notifier` |
| Get user | Custom logic | `currentUserProvider` |
| Check logged in | `isLoggedInUseCaseProvider` | `isLoggedInProvider` |

---

## 💻 Code Examples

### 1. Watch Auth State

```dart
// Old ❌
final authState = ref.watch(authNotifierProvider);
final user = authState.user;
final isLoading = authState.isLoading;
final error = authState.errorMessage;

// New ✅
final authAsync = ref.watch(authProvider);
final user = authAsync.value?.user;
final isLoading = authAsync.isLoading;
final error = authAsync.error;
```

### 2. Display UI Based on State

```dart
// Old ❌
Widget build(BuildContext context, WidgetRef ref) {
  final authState = ref.watch(authNotifierProvider);
  
  if (authState.isLoading) {
    return CircularProgressIndicator();
  }
  
  if (authState.errorMessage != null) {
    return Text(authState.errorMessage!);
  }
  
  return Text(authState.user?.username ?? 'Guest');
}

// New ✅
Widget build(BuildContext context, WidgetRef ref) {
  final authAsync = ref.watch(authProvider);
  
  return authAsync.when(
    data: (state) => Text(state.user?.username ?? 'Guest'),
    loading: () => CircularProgressIndicator(),
    error: (error, stack) => Text(error.toString()),
  );
}
```

### 3. Login

```dart
// Old ❌
final success = await ref
  .read(authNotifierProvider.notifier)
  .login(usernameOrEmail: email, password: password);

if (success) {
  context.go('/home');
} else {
  final error = ref.read(authErrorProvider);
  Toasts.error(context, description: error ?? 'Login failed');
}

// New ✅
try {
  await ref
    .read(authProvider.notifier)
    .login(usernameOrEmail: email, password: password);
  
  // Success
  context.go('/home');
} catch (e) {
  // Error
  Toasts.error(context, description: e.toString());
}
```

### 4. Register

```dart
// Old ❌
final success = await ref.read(authNotifierProvider.notifier).register(
  username: username,
  email: email,
  password: password,
  fullName: fullName,
);

// New ✅
try {
  await ref.read(authProvider.notifier).register(
    username: username,
    email: email,
    password: password,
    fullName: fullName,
  );
  // Success - go to OTP screen
} catch (e) {
  // Handle error
}
```

### 5. Logout

```dart
// Old ❌
await ref.read(authNotifierProvider.notifier).logout();

// New ✅
await ref.read(authProvider.notifier).logout();
```

### 6. Get Current User (Simple)

```dart
// Old ❌
final authState = ref.watch(authNotifierProvider);
final user = authState.user;

// New ✅ (Option 1)
final authAsync = ref.watch(authProvider);
final user = authAsync.value?.user;

// New ✅ (Option 2 - Helper provider)
final user = ref.watch(currentUserProvider);
```

### 7. Check if Logged In

```dart
// Old ❌
final isLoggedIn = await ref.read(isLoggedInUseCaseProvider)();

// New ✅
final isLoggedIn = ref.watch(isLoggedInProvider);
```

### 8. Disable Button During Loading

```dart
// Old ❌
final isLoading = ref.watch(authNotifierProvider).isLoading;

ElevatedButton(
  onPressed: isLoading ? null : () => handleLogin(),
  child: isLoading 
    ? CircularProgressIndicator() 
    : Text('Login'),
);

// New ✅
final authAsync = ref.watch(authProvider);

ElevatedButton(
  onPressed: authAsync.isLoading ? null : () => handleLogin(),
  child: authAsync.isLoading 
    ? CircularProgressIndicator() 
    : Text('Login'),
);
```

---

## 🎨 Complete Screen Example

```dart
import 'package:chattrix_ui/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final authAsync = ref.watch(authProvider);

    return Scaffold(
      body: Column(
        children: [
          // Show error if exists
          if (authAsync.hasError)
            Text('Error: ${authAsync.error}'),
          
          // Email field
          TextField(controller: emailController),
          
          // Password field
          TextField(controller: passwordController, obscureText: true),
          
          // Login button
          ElevatedButton(
            onPressed: authAsync.isLoading 
              ? null 
              : () => _handleLogin(context, ref, emailController, passwordController),
            child: authAsync.isLoading 
              ? CircularProgressIndicator()
              : Text('Login'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogin(
    BuildContext context,
    WidgetRef ref,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    try {
      await ref.read(authProvider.notifier).login(
        usernameOrEmail: emailController.text,
        password: passwordController.text,
      );
      
      if (context.mounted) {
        // Success - navigate
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (e) {
      if (context.mounted) {
        // Show error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
}
```

---

## 🛡️ Route Guard Example

```dart
// Check if user is logged in for protected routes

@riverpod
class AppRouter extends _$AppRouter {
  @override
  GoRouter build() {
    return GoRouter(
      redirect: (context, state) {
        final isLoggedIn = ref.read(isLoggedInProvider);
        final isLoginRoute = state.matchedLocation == '/login';
        
        if (!isLoggedIn && !isLoginRoute) {
          return '/login';
        }
        
        if (isLoggedIn && isLoginRoute) {
          return '/home';
        }
        
        return null;
      },
      routes: [...],
    );
  }
}
```

---

## ⚡ Helper Providers

```dart
// Get current user (null if not logged in)
final user = ref.watch(currentUserProvider);

// Check if authenticated (has tokens)
final isAuth = ref.watch(isAuthenticatedProvider);

// Check if fully logged in (authenticated + has user data)
final isLoggedIn = ref.watch(isLoggedInProvider);
```

---

## 🧪 Testing

```dart
test('login should update state', () async {
  final container = ProviderContainer(
    overrides: [
      authRepositoryProvider.overrideWithValue(mockRepository),
    ],
  );
  
  // Login
  await container.read(authProvider.notifier).login(
    usernameOrEmail: 'test@example.com',
    password: 'password',
  );
  
  // Verify
  final authState = container.read(authProvider);
  expect(authState.hasValue, true);
  expect(authState.value?.user, isNotNull);
});
```

---

## ❓ FAQ

### Q: Làm sao để refresh user data?
```dart
await ref.read(authProvider.notifier).refreshUser();
```

### Q: Làm sao để logout tất cả devices?
```dart
await ref.read(authProvider.notifier).logoutAll();
```

### Q: Làm sao để handle forgot password?
```dart
await ref.read(authProvider.notifier).forgotPassword(email: email);
```

### Q: Làm sao để verify email?
```dart
await ref.read(authProvider.notifier).verifyEmail(
  email: email,
  otp: otp,
);
```

### Q: Làm sao để change password?
```dart
await ref.read(authProvider.notifier).changePassword(
  currentPassword: currentPassword,
  newPassword: newPassword,
);
```

---

## 🔧 Troubleshooting

### "Target of URI hasn't been generated"
```bash
# Run code generation
dart run build_runner build --delete-conflicting-outputs
```

### "Undefined name 'authProvider'"
```dart
// Make sure you imported
import 'package:chattrix_ui/features/auth/presentation/providers/auth_state_provider.dart';
```

### "The method doesn't override an inherited method"
```bash
# Clean and rebuild
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

---

## 📚 More Info

- **Complete docs:** See `lib/features/auth/README.md`
- **Migration guide:** See `MIGRATION_GUIDE.md`
- **Full example:** See `lib/features/auth/presentation/pages/login_screen_modern.dart`

---

## 🎯 Quick Checklist for Migration

```
1. ✅ Import new provider file
2. ✅ Replace authNotifierProvider → authProvider
3. ✅ Use .when() or .value for AsyncValue
4. ✅ Use try-catch instead of checking return bool
5. ✅ Test login/logout flow
6. ✅ Verify error handling works
```

**Done!** 🎉

