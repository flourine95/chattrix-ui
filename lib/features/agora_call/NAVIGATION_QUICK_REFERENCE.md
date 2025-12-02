# Navigation Integration - Quick Reference

## Call Screen Routes

```dart
'/agora-call/outgoing'  // Outgoing call screen
'/agora-call/incoming'  // Incoming call screen
'/agora-call/active'    // Active call screen
```

## Programmatic Navigation

```dart
// Get navigation service
final navService = ref.read(callNavigationServiceProvider(context));

// Navigate to screens
navService.navigateToOutgoingCall();
navService.navigateToIncomingCall();
navService.navigateToActiveCall();
navService.navigateBackFromCall();

// Check current screen
if (navService.isOnCallScreen()) {
  // On a call screen
}

final screenType = navService.getCurrentCallScreen();
// Returns: CallScreenType.outgoing, .incoming, .active, or null
```

## Deep Links

```dart
// Incoming call
chattrix://call/incoming?callId=xxx

// Active call
chattrix://call/active?callId=xxx

// Handle deep link
navService.handleDeepLink(Uri.parse('chattrix://call/incoming'));
```

## Automatic Navigation

Navigation happens automatically based on call state:

| Call Status | Navigation Target |
|------------|-------------------|
| INITIATING | `/agora-call/outgoing` |
| RINGING (caller) | `/agora-call/outgoing` |
| RINGING (callee) | `/agora-call/incoming` |
| CONNECTING | `/agora-call/active` |
| CONNECTED | `/agora-call/active` |
| ENDED | Pop back to previous screen |
| REJECTED | Pop back to previous screen |

## App Lifecycle

```dart
// Lifecycle observer is initialized in main.dart
ref.watch(callLifecycleObserverProvider);

// Behavior:
// - App backgrounded: Video disabled (audio continues)
// - App foregrounded: Verify connection (user can re-enable video)
```

## Navigation Guards

The router prevents unwanted navigation:

```dart
// Never redirect away from call screens
if (currentLocation.startsWith('/agora-call/')) {
  return null; // Block redirect
}

// Auto-reject incoming calls when busy
if (currentCall != null && currentCall.status.isActive) {
  rejectCall(callId: newCallId, reason: 'busy');
}
```

## Common Patterns

### Initiate Call Flow
```dart
// 1. Request permissions
final hasPermissions = await PermissionService.requestCallPermissions(callType);

// 2. Initiate call
await ref.read(callStateProvider.notifier).initiateCall(
  calleeId: userId,
  callType: CallType.video,
);

// 3. Navigation happens automatically to /agora-call/outgoing
```

### Accept Call Flow
```dart
// 1. User on /agora-call/incoming screen
// 2. Tap accept button
await ref.read(callStateProvider.notifier).acceptCall(callId);

// 3. Navigation happens automatically to /agora-call/active
```

### End Call Flow
```dart
// 1. User on /agora-call/active screen
// 2. Tap end button
await ref.read(callStateProvider.notifier).endCall(callId);

// 3. Screen listens to state change and calls context.pop()
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Stuck on call screen | Check call state is cleared (null) |
| Incoming call not showing | Check app is in foreground |
| Navigation loops | Verify redirect guards are in place |
| Deep link not working | Check platform configuration |

## Platform Configuration

### Android (`AndroidManifest.xml`)
```xml
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW"/>
    <category android:name="android.intent.category.DEFAULT"/>
    <category android:name="android.intent.category.BROWSABLE"/>
    <data android:scheme="chattrix" android:host="call"/>
</intent-filter>
```

### iOS (`Info.plist`)
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>chattrix</string>
        </array>
    </dict>
</array>

<key>UIBackgroundModes</key>
<array>
    <string>audio</string>
    <string>voip</string>
</array>
```

## Key Files

- `app_router.dart` - Router configuration
- `agora_call_router_notifier.dart` - Router notifier
- `call_navigation_service.dart` - Navigation service
- `call_lifecycle_observer.dart` - Lifecycle observer
- `main.dart` - Initialization
