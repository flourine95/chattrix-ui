# Call Notifier Toast Migration

## Summary
Successfully migrated `call_notifier.dart` from the old toast system to be compatible with the new `AppToast` system.

## Changes Made

### 1. Removed Old Toast Dependencies
- ❌ Removed: `import 'package:chattrix_ui/core/toast/toast_controller.dart';`
- ❌ Removed: `import 'package:chattrix_ui/core/toast/toast_type.dart';`
- ❌ Removed: All 9 occurrences of `ref.read(toastControllerProvider).show(title: message, type: ToastType.error)`

### 2. Architecture Decision: State-Based Error Handling
Instead of showing toasts directly from the notifier (which doesn't have access to `BuildContext`), we now rely on **state-based error handling**:

```dart
// ❌ OLD: Notifier shows toast directly
ref.read(toastControllerProvider).show(title: message, type: ToastType.error);
state = CallState.error(message: message);

// ✅ NEW: Notifier only updates state
state = CallState.error(message: message);
// UI layer watches state and shows toast
```

### 3. Error Locations Updated
All error handling locations now only set error state:

1. **initiateCall()** - 3 error locations:
   - Backend API failure
   - Agora initialization error
   - Unexpected error

2. **acceptCall()** - 3 error locations:
   - Backend API failure
   - Agora join error
   - Unexpected error

3. **joinCall()** - 3 error locations:
   - Backend API failure
   - Agora join error
   - Unexpected error

## UI Layer Implementation Guide

### How to Show Toasts for Call Errors

Call screens should watch the `callNotifierProvider` state and show toasts when errors occur:

```dart
class CallScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callState = ref.watch(callNotifierProvider);
    
    // Listen for error states and show toast
    ref.listen<CallState>(
      callNotifierProvider,
      (previous, next) {
        next.whenOrNull(
          error: (message) {
            if (context.mounted) {
              AppToast.error(
                context,
                title: 'Call Error',
                description: message,
              );
            }
          },
        );
      },
    );
    
    return Scaffold(
      // ... UI code
    );
  }
}
```

### Example: Initiating a Call with Error Handling

```dart
Future<void> _initiateCall() async {
  final notifier = ref.read(callNotifierProvider.notifier);
  
  await notifier.initiateCall(
    conversationId,
    CallType.video,
    conversationName: 'John Doe',
  );
  
  // No need to manually show toast here
  // The ref.listen above will automatically show toast if state becomes error
}
```

### Error Messages from Notifier

The notifier provides user-friendly error messages:

| Error Type | Message |
|------------|---------|
| Backend API failure | From `_getFailureMessage(failure)` |
| Agora connection error | "Failed to join call. Please check your connection and try again." |
| Unexpected error (initiate) | "Failed to start call. Please try again." |
| Unexpected error (accept) | "Failed to accept call. Please try again." |
| Unexpected error (join) | "Failed to join call. Please try again." |

## Benefits of This Approach

### ✅ Advantages
1. **Separation of Concerns**: Notifier handles business logic, UI handles presentation
2. **Context Safety**: No need to pass `BuildContext` to notifier methods
3. **Consistent Error Handling**: All errors flow through state, making them testable
4. **Reactive UI**: UI automatically responds to state changes
5. **Clean Architecture**: Follows Riverpod best practices

### 🎯 Best Practices
- Always use `ref.listen` to react to state changes
- Check `context.mounted` before showing toasts
- Use descriptive error messages from the state
- Handle all error states in the UI layer

## Testing

### Unit Tests
```dart
test('should set error state when call initiation fails', () async {
  // Arrange
  when(mockUseCase.call(any)).thenAnswer((_) async => left(ServerFailure(...)));
  
  // Act
  await notifier.initiateCall(1, CallType.video);
  
  // Assert
  expect(notifier.state, isA<CallStateError>());
  notifier.state.whenOrNull(
    error: (message) => expect(message, contains('Failed')),
  );
});
```

### Widget Tests
```dart
testWidgets('should show toast when call fails', (tester) async {
  // Arrange
  final container = ProviderContainer(
    overrides: [
      callNotifierProvider.overrideWith(() => MockCallNotifier()),
    ],
  );
  
  // Act
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(home: CallScreen()),
    ),
  );
  
  // Trigger error state
  container.read(callNotifierProvider.notifier).state = 
    CallState.error(message: 'Test error');
  await tester.pump();
  
  // Assert
  expect(find.text('Test error'), findsOneWidget);
});
```

## Migration Checklist

- [x] Remove old toast imports
- [x] Remove all `toastControllerProvider` calls (9 occurrences)
- [x] Verify all error states are properly set
- [x] Run diagnostics - all pass ✅
- [ ] Update call screens to use `ref.listen` for error handling
- [ ] Test error scenarios in UI
- [ ] Update integration tests

## Files Modified
- `lib/features/call/presentation/state/call_notifier.dart`

## Related Documentation
- `lib/core/toast/README.md` - New toast system overview
- `lib/core/toast/QUICK_REFERENCE.md` - AppToast API reference
- `lib/features/auth/AUTH_TOAST_UPDATE.md` - Similar migration for auth screens
