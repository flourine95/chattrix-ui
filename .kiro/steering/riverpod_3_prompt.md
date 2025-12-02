---
inclusion: fileMatch
fileMatchPattern: ['**/*.dart']
---

# Riverpod 3 Code Generation Standards

## Stack
- **Flutter** with **Riverpod 3.x** (hooks_riverpod, flutter_hooks)
- **Code Generation**: `@riverpod` annotation with `riverpod_generator`
- **Build**: `dart run build_runner build --delete-conflicting-outputs`

## Core Rules

### 1. Provider Signatures
**ALWAYS use `Ref` (never `CustomRef`, `LoginRef`, etc.)**

```dart
// ✅ Function provider
@riverpod
Future<User> login(Ref ref, String username) async {
  return await ApiService.login(username);
}

// ✅ Notifier class
@riverpod
class WebSocket extends _$WebSocket {
  @override
  bool build() => false;
}
```

### 2. Lifecycle Management
**NEVER modify state in `ref.onDispose()` - only cleanup resources**

```dart
// ✅ Cleanup only in onDispose
@override
bool build() {
  ref.onDispose(() {
    _channel?.sink.close();
    _messageController.close();
    // ❌ NEVER: state = false; (throws UnmountedRefException)
  });
  return false;
}

// ✅ Check ref.mounted before state changes
void disconnect() {
  _channel?.sink.close();
  if (ref.mounted) state = false;
}
```

### 3. Provider Persistence
**Use `keepAlive: true` for providers that must survive navigation/disposal**

```dart
// ✅ User state persists across screens
@Riverpod(keepAlive: true)
class CurrentUser extends _$CurrentUser {
  @override
  User? build() => null;
  void setUser(User user) => state = user;
}

// ✅ WebSocket stays connected
@Riverpod(keepAlive: true)
class WebSocket extends _$WebSocket {
  @override
  bool build() => false;
}
```

**Without `keepAlive`, providers auto-dispose when no longer watched**

### 4. Context Safety After Async
**ALWAYS check `context.mounted` after `await` before using context**

```dart
// ✅ Safe async operation
Future<void> login() async {
  try {
    final user = await ref.read(loginProvider(username).future);
    if (!context.mounted) return;
    context.go('/home');
  } catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(...);
  }
}
```

**Prevents crashes when widget is disposed during async operations**

### 5. Function Declaration Order
**Define all functions BEFORE using them in `useEffect` or callbacks**

```dart
// ✅ Function defined first
Widget build(BuildContext context, WidgetRef ref) {
  Future<void> endCall([bool showMessage = true]) async { }
  
  useEffect(() {
    final sub = wsNotifier.messageStream.listen((msg) => endCall(false));
    return sub.cancel;
  }, []);
}
```

**Prevents `referenced_before_declaration` errors**

### 6. Widget Base Classes
**Use `ConsumerWidget` or `HookConsumerWidget` (never `StatelessWidget`/`StatefulWidget`)**

```dart
// ✅ For Riverpod only
class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    return Scaffold(...);
  }
}

// ✅ For Riverpod + Hooks
class LoginScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final async = ref.watch(loginProvider(username));
    return Scaffold(...);
  }
}
```

### 7. Safe Provider Access
**Wrap provider method calls in try-catch to handle disposal gracefully**

```dart
// ✅ Safe disposal handling
void logout() {
  try {
    wsNotifier.disconnect();
  } catch (e) {
    debugPrint('Error disconnecting: $e');
  }
  ref.read(currentUserProvider.notifier).clearUser();
  context.go('/');
}
```

### 8. Resource Management
**Initialize resources in `build()`, cleanup in `ref.onDispose()`**

```dart
// ✅ Proper resource lifecycle
@riverpod
class WebSocket extends _$WebSocket {
  late StreamController<Map<String, dynamic>> _messageController;

  @override
  bool build() {
    _messageController = StreamController.broadcast();
    ref.onDispose(() => _messageController.close());
    return false;
  }

  Stream<Map<String, dynamic>> get messageStream => _messageController.stream;
}
```

**Never use global variables for resources that need cleanup**

### 9. Error Handling
**Check `context.mounted` in both success and error paths**

```dart
// ✅ Complete error handling
Future<void> initiateCall(User targetUser) async {
  try {
    final response = await ref.read(
      initiateCallProvider(currentUser.id, targetUser.id).future,
    );
    if (!context.mounted) return;
    context.push('/waiting', extra: {...});
  } catch (e) {
    debugPrint('Failed to initiate call: $e');
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed: $e')),
    );
  }
}
```

### 10. Provider Pattern Selection

**Function providers** - Simple async operations (fetch data once)
```dart
@riverpod
Future<List<User>> allUsers(Ref ref) async {
  return await ApiService.getAllUsers();
}
```

**Notifier classes** - Stateful providers (mutable state, multiple methods)
```dart
@riverpod
class CurrentUser extends _$CurrentUser {
  @override
  User? build() => null;
  void setUser(User user) => state = user;
  void clearUser() => state = null;
}
```

**AsyncNotifier classes** - Async initialization + state mutations
```dart
@riverpod
class UserList extends _$UserList {
  @override
  Future<List<User>> build() async => await ApiService.getAllUsers();
  
  Future<void> addUser(User user) async {
    state = AsyncValue.data([...state.value!, user]);
  }
}
```

## Code Generation

**Build commands:**
```bash
# Generate once
dart run build_runner build --delete-conflicting-outputs

# Watch mode
dart run build_runner watch --delete-conflicting-outputs
```

## Common Errors

| Error | Cause | Fix |
|-------|-------|-----|
| `UnmountedRefException` | Modifying state after disposal | Check `if (ref.mounted)` before state changes |
| `referenced_before_declaration` | Function used before defined | Define functions before `useEffect` |
| State lost on navigation | Missing `keepAlive` | Add `@Riverpod(keepAlive: true)` |
| Context crash after await | No mounted check | Add `if (!context.mounted) return;` |
| WebSocket disconnects | Auto-disposal | Use `keepAlive: true` |

## Quick Checklist

- Use `Ref ref` (not `CustomRef`)
- Add `keepAlive: true` for persistent state
- Check `context.mounted` after every `await`
- Only cleanup in `ref.onDispose()`, never modify state
- Define functions before callbacks
- Use `ConsumerWidget` or `HookConsumerWidget`
- Wrap provider calls in try-catch
- Run `build_runner` after changes
