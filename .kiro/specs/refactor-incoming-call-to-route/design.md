# Design Document

## Overview

This design refactors the incoming call handling from an overlay-based widget wrapper approach to a pure route-based approach integrated with GoRouter. The current implementation uses `IncomingCallListener` as a widget wrapper in the MaterialApp builder, which listens to the `IncomingCallProvider` and calls `context.push()` to navigate. This approach has limitations with navigation state management and app lifecycle handling.

The new design will:
1. Remove the `IncomingCallListener` widget wrapper entirely
2. Use GoRouter's redirect mechanism to handle incoming call navigation
3. Integrate app lifecycle monitoring directly into the router logic
4. Maintain all existing functionality (accept, reject, timeout, ringtone)

## Architecture

### Current Architecture (To Be Replaced)

```
MaterialApp.router
  └─ builder: IncomingCallListener (widget wrapper)
      ├─ Listens to: incomingCallProvider
      ├─ Monitors: AppLifecycleState
      └─ Action: context.push('/incoming-call')
```

**Problems:**
- Widget wrapper adds unnecessary layer
- Navigation state can become inconsistent
- Lifecycle monitoring is duplicated
- Harder to test and maintain

### New Architecture (Route-Based)

```
GoRouter
  ├─ refreshListenable: IncomingCallRouterNotifier
  │   ├─ Listens to: incomingCallProvider
  │   └─ Monitors: AppLifecycleState
  │
  └─ redirect: (context, state)
      ├─ Check: currentIncomingCall != null
      ├─ Check: not already on /incoming-call
      ├─ Check: app is in foreground
      └─ Action: return '/incoming-call'
```

**Benefits:**
- Declarative routing - all navigation logic in one place
- GoRouter handles navigation state automatically
- Easier to test redirect logic
- Cleaner separation of concerns
- No widget wrapper overhead

## Components and Interfaces

### 1. IncomingCallRouterNotifier (New)

A `ChangeNotifier` that bridges Riverpod providers with GoRouter's `refreshListenable`.

```dart
class IncomingCallRouterNotifier extends ChangeNotifier with WidgetsBindingObserver {
  final Ref _ref;
  AppLifecycleState? _lastLifecycleState;
  
  IncomingCallRouterNotifier(this._ref) {
    // Listen to incoming call provider changes
    _ref.listen<CallInvitationData?>(
      currentIncomingCallProvider,
      (previous, next) {
        notifyListeners(); // Trigger router refresh
      },
    );
    
    // Monitor app lifecycle
    WidgetsBinding.instance.addObserver(this);
    _lastLifecycleState = WidgetsBinding.instance.lifecycleState;
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _lastLifecycleState = state;
    notifyListeners(); // Trigger router refresh when lifecycle changes
  }
  
  bool get isAppInForeground => 
    _lastLifecycleState == AppLifecycleState.resumed;
  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
```

**Provider:**
```dart
final incomingCallRouterNotifierProvider = Provider<IncomingCallRouterNotifier>((ref) {
  final notifier = IncomingCallRouterNotifier(ref);
  ref.onDispose(() => notifier.dispose());
  return notifier;
});
```

### 2. Modified AppRouter

Update `AppRouter.router()` to use the new notifier and redirect logic.

```dart
static GoRouter router(WidgetRef ref) {
  final incomingCallNotifier = ref.watch(incomingCallRouterNotifierProvider);
  
  return GoRouter(
    initialLocation: '/',
    refreshListenable: Listenable.merge([
      ref.watch(authNotifierWrapperProvider),
      incomingCallNotifier, // Add incoming call notifier
    ]),
    redirect: (context, state) async {
      // Existing auth redirect logic...
      final authRedirect = await _handleAuthRedirect(ref, state);
      if (authRedirect != null) return authRedirect;
      
      // New incoming call redirect logic
      final incomingCallRedirect = _handleIncomingCallRedirect(ref, state, incomingCallNotifier);
      if (incomingCallRedirect != null) return incomingCallRedirect;
      
      return null;
    },
    routes: [
      // ... existing routes
    ],
  );
}

static String? _handleIncomingCallRedirect(
  WidgetRef ref,
  GoRouterState state,
  IncomingCallRouterNotifier notifier,
) {
  final currentInvitation = ref.read(currentIncomingCallProvider);
  final currentLocation = state.matchedLocation;
  
  // Only redirect if:
  // 1. There's an incoming call
  // 2. Not already on the incoming call screen
  // 3. App is in foreground
  if (currentInvitation != null &&
      currentLocation != '/incoming-call' &&
      notifier.isAppInForeground) {
    return '/incoming-call';
  }
  
  return null;
}
```

### 3. Modified IncomingCallScreen

Update the screen to clear the invitation when navigating away.

```dart
class IncomingCallScreen extends HookConsumerWidget {
  const IncomingCallScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get invitation from provider instead of constructor parameter
    final invitation = ref.watch(currentIncomingCallProvider);
    
    // If no invitation, navigate back (shouldn't happen, but safety check)
    if (invitation == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go('/');
      });
      return const SizedBox.shrink();
    }
    
    // Clear invitation when screen is disposed
    useEffect(() {
      return () {
        ref.read(incomingCallProvider.notifier).clearInvitation();
      };
    }, []);
    
    // ... rest of the implementation (ringtone, timeout, UI)
  }
  
  void _handleReject(BuildContext context, WidgetRef ref, String callId) {
    ref.read(ringtoneServiceProvider).stopRingtone();
    ref.read(callProvider.notifier).rejectCall(callId, reason: 'declined');
    ref.read(incomingCallProvider.notifier).clearInvitation();
    
    if (context.mounted) {
      context.go('/'); // Navigate to home instead of pop
    }
  }
  
  Future<void> _handleAccept(BuildContext context, WidgetRef ref, CallInvitationData invitation) async {
    await ref.read(ringtoneServiceProvider).stopRingtone();
    ref.read(callStatusProvider.notifier).setConnectingToCall();
    
    final callType = invitation.callType == 'VIDEO' ? CallType.video : CallType.audio;
    
    await ref.read(callProvider.notifier).acceptCall(
      callId: invitation.callId,
      channelId: invitation.channelId,
      remoteUserId: invitation.callerId,
      callType: callType,
    );
    
    ref.read(incomingCallProvider.notifier).clearInvitation();
    
    if (context.mounted) {
      context.go('/call/${invitation.callId}', extra: {
        'remoteUserId': invitation.callerId,
        'callType': invitation.callType == 'VIDEO' ? 'video' : 'audio',
      });
    }
  }
}
```

### 4. Modified AppRouter Route Definition

Update the incoming-call route to not require `extra` parameter.

```dart
GoRoute(
  path: '/incoming-call',
  name: 'incoming-call',
  builder: (context, state) {
    return const IncomingCallScreen(); // No extra parameter needed
  },
),
```

### 5. Modified main.dart

Remove `IncomingCallListener` from the builder.

```dart
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Chattrix',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      builder: (context, child) => ToastOverlay(
        child: child ?? const SizedBox.shrink(),
      ), // IncomingCallListener removed!
      routerConfig: AppRouter.router(ref),
    );
  }
}
```

## Data Models

No changes to existing data models. The following models remain unchanged:
- `CallInvitationData` - Contains caller information and call details
- `CallEntity` - Represents an active call
- All WebSocket message models

## Co
rrectness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system-essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*


Property 1: Incoming call triggers navigation
*For any* incoming call invitation received while the app is in foreground, the router redirect logic should return the incoming call route path
**Validates: Requirements 1.1, 1.2**

Property 2: Background-to-foreground transition shows pending call
*For any* pending call invitation when the app transitions from background to foreground, the router redirect logic should return the incoming call route path
**Validates: Requirements 1.3**

Property 3: Call actions clear state and navigate
*For any* incoming call, when a user accepts or rejects the call, the invitation provider state should be cleared and navigation should occur using context.go (not context.pop)
**Validates: Requirements 1.4, 5.2, 5.3**

Property 4: Sequential calls maintain independent state
*For any* sequence of incoming calls, each call's invitation data should be independent and not affected by previous calls' state
**Validates: Requirements 1.5**

Property 5: Navigation stack includes incoming call route
*For any* incoming call screen display, the route should be part of the normal navigation stack (verifiable through router state)
**Validates: Requirements 3.2**

Property 6: State cleanup on navigation away
*For any* navigation away from the incoming call screen (timeout, rejection, or manual navigation), the incoming call provider state should be cleared to null
**Validates: Requirements 3.3, 3.4, 4.5**

Property 7: Background calls don't trigger navigation
*For any* incoming call received while the app is in background state, the router redirect logic should return null (no navigation)
**Validates: Requirements 4.2**

Property 8: Lifecycle changes trigger router refresh
*For any* app lifecycle state change, the IncomingCallRouterNotifier should call notifyListeners to trigger router refresh
**Validates: Requirements 4.4**

Property 9: Incoming call screen displays complete caller information
*For any* incoming call invitation, the rendered screen should contain the caller name, avatar (or initials), and call type indicator
**Validates: Requirements 5.1**

Property 10: Ringtone lifecycle management
*For any* incoming call screen, the ringtone should be stopped when the screen is disposed or when accept/reject actions are triggered
**Validates: Requirements 5.5**

## Error Handling

### Navigation Errors

**Scenario:** Router redirect is called but context is not mounted
- **Handling:** Always check `context.mounted` before calling navigation methods
- **Recovery:** Log error and allow natural navigation flow to continue

**Scenario:** Incoming call provider returns null when screen expects data
- **Handling:** IncomingCallScreen checks for null invitation and navigates to home
- **Recovery:** User returns to home screen, no crash

### State Synchronization Errors

**Scenario:** Multiple rapid lifecycle changes cause race conditions
- **Handling:** Use `notifyListeners()` which is debounced by Flutter framework
- **Recovery:** Router will use the latest state on next refresh

**Scenario:** Call invitation arrives while router is redirecting
- **Handling:** GoRouter queues redirects and processes them sequentially
- **Recovery:** Next redirect cycle will pick up the new invitation

### Cleanup Errors

**Scenario:** Screen is disposed before ringtone can be stopped
- **Handling:** Use try-catch in useEffect cleanup and dispose methods
- **Recovery:** Log warning, ringtone service has its own timeout mechanism

## Testing Strategy

### Unit Testing

**IncomingCallRouterNotifier Tests:**
- Test that constructor sets up provider listener
- Test that lifecycle observer is registered
- Test that `isAppInForeground` returns correct value for each lifecycle state
- Test that dispose removes lifecycle observer

**Router Redirect Logic Tests:**
- Test redirect returns `/incoming-call` when invitation exists and app is foreground
- Test redirect returns null when no invitation
- Test redirect returns null when already on `/incoming-call`
- Test redirect returns null when app is in background
- Test auth redirect takes precedence over incoming call redirect

**IncomingCallScreen Tests:**
- Test screen navigates home when invitation is null
- Test screen clears invitation on dispose
- Test accept button calls correct methods and navigates
- Test reject button calls correct methods and navigates
- Test timeout triggers auto-reject after 60 seconds

### Property-Based Testing

This refactoring is primarily architectural and involves UI navigation, which is difficult to test with property-based testing. However, we can use property-based testing for the redirect logic:

**Property Test Library:** Use `flutter_test` with custom generators

**Property 1 Test: Incoming call triggers navigation**
```dart
@Property(trials: 100)
void incomingCallTriggersNavigation(
  @ForAll() CallInvitationData invitation,
  @ForAll() AppLifecycleState lifecycleState,
) {
  // Given: App is in foreground
  if (lifecycleState != AppLifecycleState.resumed) return;
  
  // When: Invitation is set
  providerContainer.read(incomingCallProvider.notifier).state = invitation;
  
  // Then: Redirect should return incoming call route
  final redirect = _handleIncomingCallRedirect(...);
  expect(redirect, equals('/incoming-call'));
}
```

**Property 3 Test: Call actions clear state**
```dart
@Property(trials: 100)
void callActionsClearState(
  @ForAll() CallInvitationData invitation,
  @ForAll() bool isAccept, // true = accept, false = reject
) {
  // Given: Invitation exists
  providerContainer.read(incomingCallProvider.notifier).state = invitation;
  
  // When: User accepts or rejects
  if (isAccept) {
    _handleAccept(context, ref, invitation);
  } else {
    _handleReject(context, ref, invitation.callId);
  }
  
  // Then: State should be cleared
  final state = providerContainer.read(incomingCallProvider);
  expect(state, isNull);
}
```

**Property 7 Test: Background calls don't navigate**
```dart
@Property(trials: 100)
void backgroundCallsDontNavigate(
  @ForAll() CallInvitationData invitation,
  @ForAll() AppLifecycleState backgroundState,
) {
  // Given: App is NOT in foreground
  if (backgroundState == AppLifecycleState.resumed) return;
  
  // When: Invitation is set
  providerContainer.read(incomingCallProvider.notifier).state = invitation;
  
  // Then: Redirect should return null
  final redirect = _handleIncomingCallRedirect(...);
  expect(redirect, isNull);
}
```

### Integration Testing

**Full Flow Tests:**
1. Simulate incoming call → verify navigation to incoming call screen
2. Accept call → verify navigation to call screen and state cleanup
3. Reject call → verify navigation to home and state cleanup
4. Timeout → verify auto-reject and navigation
5. Background call → verify no navigation, then foreground → verify navigation

### Manual Testing

**Scenarios to test manually:**
1. Receive call while on different screens (chat, contacts, profile)
2. Receive call while app is in background, then bring to foreground
3. Receive multiple calls in quick succession
4. Press back button on incoming call screen
5. Accept call and verify smooth transition
6. Let call timeout and verify auto-reject
7. Kill and restart app - verify no stale call screens

## Implementation Notes

### Migration Steps

1. Create `IncomingCallRouterNotifier` and provider
2. Update `AppRouter` to use the notifier in `refreshListenable`
3. Add `_handleIncomingCallRedirect` method to `AppRouter`
4. Update `IncomingCallScreen` to read invitation from provider
5. Update incoming-call route to not require `extra` parameter
6. Remove `IncomingCallListener` from `main.dart` builder
7. Delete `incoming_call_listener.dart` file
8. Test thoroughly

### Backward Compatibility

This is a breaking change in terms of internal architecture, but the user-facing behavior should remain identical. No API changes are required.

### Performance Considerations

- **Router refresh frequency:** The notifier will trigger router refresh on every incoming call state change and lifecycle change. This is acceptable as GoRouter's redirect is efficient and only runs when needed.
- **Memory:** Removing the widget wrapper actually reduces memory overhead slightly.
- **Navigation performance:** Route-based navigation is more efficient than overlay-based as it's handled by the router's optimized navigation stack.

## Dependencies

- `go_router` - Already in use, no version change needed
- `hooks_riverpod` - Already in use for providers
- `flutter_hooks` - Already in use for lifecycle management
- No new dependencies required

## Future Enhancements

1. **Deep linking:** With route-based approach, we could support deep links to incoming call screen (though this may not be desirable)
2. **Navigation analytics:** Easier to track navigation events with route-based approach
3. **State restoration:** Could implement state restoration for incoming calls if needed
4. **Multiple simultaneous calls:** Architecture now supports showing call waiting UI more easily
