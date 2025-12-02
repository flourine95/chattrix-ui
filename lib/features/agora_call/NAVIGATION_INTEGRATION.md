# Agora Call Navigation Integration

This document describes how the Agora call feature is integrated with the app's navigation system.

## Overview

The call feature is fully integrated with the app's `go_router` navigation system, providing:
- Automatic navigation to call screens based on call state
- Deep linking support for incoming calls
- App lifecycle management during calls
- Proper navigation stack management

## Requirements Coverage

- **Requirement 1.5**: Display calling screen when initiating call ✅
- **Requirement 2.2**: Display incoming call screen when call invitation received ✅
- **Requirement 3.4**: Transition to active call screen when call is accepted ✅
- **Requirement 6.4**: Return to previous screen when call ends ✅

## Architecture

### 1. Router Configuration (`app_router.dart`)

The router defines three call-related routes:

```dart
// Outgoing call screen - shown when user initiates a call
GoRoute(
  path: '/agora-call/outgoing',
  name: 'agora-outgoing-call',
  builder: (context, state) => const OutgoingCallScreen(),
)

// Incoming call screen - shown when receiving a call
GoRoute(
  path: '/agora-call/incoming',
  name: 'agora-incoming-call',
  builder: (context, state) => const IncomingCallScreen(),
)

// Active call screen - shown during an active call
GoRoute(
  path: '/agora-call/active',
  name: 'agora-active-call',
  builder: (context, state) => const ActiveCallScreen(),
)
```

### 2. Automatic Navigation via Router Redirect

The router includes redirect logic that automatically navigates to the incoming call screen when:
1. There's an incoming call (status is RINGING)
2. User is not already on a call screen
3. App is in foreground

```dart
// In app_router.dart
redirect: (context, state) async {
  // ... auth redirect logic ...
  
  // Handle Agora incoming call redirect
  final agoraCallRedirect = _handleAgoraIncomingCallRedirect(ref, state, agoraCallNotifier);
  if (agoraCallRedirect != null) {
    return agoraCallRedirect;
  }
  
  return null;
}
```

**Important**: The redirect logic prevents navigation away from call screens to avoid interrupting active calls.

### 3. Router Notifier (`agora_call_router_notifier.dart`)

The `AgoraCallRouterNotifier` bridges Riverpod providers with GoRouter's `refreshListenable`:

```dart
class AgoraCallRouterNotifier extends ChangeNotifier with WidgetsBindingObserver {
  // Listens to call state changes
  // Monitors app lifecycle (foreground/background)
  // Triggers router refresh when either changes
}
```

This enables automatic navigation when:
- Call state changes (incoming call, call accepted, call ended)
- App lifecycle changes (backgrounded, foregrounded)

### 4. Navigation Service (`call_navigation_service.dart`)

Provides programmatic navigation methods:

```dart
final navService = ref.read(callNavigationServiceProvider(context));

// Navigate to specific call screens
navService.navigateToOutgoingCall();
navService.navigateToIncomingCall();
navService.navigateToActiveCall();
navService.navigateBackFromCall();

// Handle deep links
navService.handleDeepLink(uri);

// Check current screen
if (navService.isOnCallScreen()) {
  // User is on a call screen
}
```

### 5. Lifecycle Observer (`call_lifecycle_observer.dart`)

Handles app backgrounding/foregrounding during calls:

```dart
class CallLifecycleObserver with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app paused (backgrounded)
    // Handle app resumed (foregrounded)
    // Manage media resources during transitions
  }
}
```

**Behavior**:
- **App Backgrounded**: Disables video for video calls to save battery
- **App Foregrounded**: Verifies Agora connection is still active
- **Audio Calls**: Continue running in background (iOS background modes enabled)

## Deep Linking

### Configuration

**Android** (`AndroidManifest.xml`):
```xml
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW"/>
    <category android:name="android.intent.category.DEFAULT"/>
    <category android:name="android.intent.category.BROWSABLE"/>
    <data android:scheme="chattrix" android:host="call"/>
</intent-filter>
```

**iOS** (`Info.plist`):
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
```

### Supported Deep Links

1. **Incoming Call**: `chattrix://call/incoming?callId=xxx`
   - Opens incoming call screen if there's an active incoming call

2. **Active Call**: `chattrix://call/active?callId=xxx`
   - Opens active call screen if there's an active call

### Usage

Deep links are handled automatically by the `CallNavigationService`:

```dart
// In your deep link handler
final uri = Uri.parse('chattrix://call/incoming?callId=123');
navService.handleDeepLink(uri);
```

## Navigation Flow

### Initiating a Call

1. User taps call button in chat
2. `CallInitiationHelper.initiateCall()` is called
3. Call state provider sends API request
4. On success, call state updates to INITIATING
5. Router redirect logic navigates to `/agora-call/outgoing`
6. OutgoingCallScreen is displayed

### Receiving a Call

1. WebSocket receives `call.incoming` event
2. Call state provider updates state to RINGING
3. Router notifier triggers refresh
4. Router redirect logic navigates to `/agora-call/incoming`
5. IncomingCallScreen is displayed with ringtone

### Accepting a Call

1. User taps accept button
2. Call state provider sends accept API request
3. On success, joins Agora channel
4. Call state updates to CONNECTED
5. Router redirect logic navigates to `/agora-call/active`
6. ActiveCallScreen is displayed

### Ending a Call

1. User taps end button
2. Call state provider:
   - Leaves Agora channel
   - Sends end API request
   - Clears call state
3. Call state becomes null
4. ActiveCallScreen listens to state change
5. Screen calls `context.pop()` to navigate back

## Navigation Stack Management

### Preventing Unwanted Navigation

The router redirect logic includes guards to prevent navigation away from call screens:

```dart
// Never redirect away from call screens
if (currentLocation.startsWith('/agora-call/')) {
  return null; // Block redirect
}
```

This ensures:
- User can't be kicked out of a call by auth changes
- Incoming calls don't interrupt active calls
- Navigation stack remains clean

### Handling Multiple Calls

When a new call arrives while already in a call:
1. Call state provider auto-rejects the new call with reason "busy"
2. No navigation occurs
3. User remains on current call screen

## App Lifecycle Handling

### Backgrounding During Call

**Audio Calls**:
- Continue running in background
- iOS: Enabled via `UIBackgroundModes` (audio, voip)
- Android: Would need foreground service in production

**Video Calls**:
- Local video is disabled to save battery
- Audio continues
- Remote video continues to be received
- User can re-enable video when foregrounding

### Foregrounding During Call

1. Lifecycle observer detects app resumed
2. Verifies call is still active
3. Verifies Agora connection
4. User can re-enable video if desired

### App Termination During Call

- Agora SDK handles cleanup automatically
- Backend receives disconnect event
- Other party is notified call ended

## Testing

### Manual Testing Checklist

- [ ] Initiate audio call - navigates to outgoing screen
- [ ] Initiate video call - navigates to outgoing screen
- [ ] Receive incoming call - navigates to incoming screen
- [ ] Accept call - navigates to active screen
- [ ] Reject call - returns to previous screen
- [ ] End call - returns to previous screen
- [ ] Background app during audio call - call continues
- [ ] Background app during video call - video pauses
- [ ] Foreground app during call - returns to active screen
- [ ] Deep link to incoming call - opens incoming screen
- [ ] Deep link to active call - opens active screen
- [ ] Receive call while in call - auto-rejects new call
- [ ] Auth changes during call - stays on call screen

### Integration Testing

```dart
testWidgets('Navigation flow for complete call lifecycle', (tester) async {
  // 1. Start at home screen
  // 2. Initiate call
  // 3. Verify navigation to outgoing screen
  // 4. Simulate call accepted
  // 5. Verify navigation to active screen
  // 6. End call
  // 7. Verify navigation back to home
});
```

## Troubleshooting

### Issue: User stuck on call screen after call ends

**Cause**: Call state not properly cleared
**Solution**: Ensure `endCall()` sets state to null

### Issue: Incoming call doesn't show screen

**Cause**: App in background or redirect logic blocked
**Solution**: Check `isAppInForeground` in router notifier

### Issue: Navigation loops or flickers

**Cause**: Multiple redirects triggering simultaneously
**Solution**: Ensure redirect guards are in place

### Issue: Deep link doesn't work

**Cause**: Platform configuration missing or incorrect
**Solution**: Verify AndroidManifest.xml and Info.plist

## Future Enhancements

1. **Push Notifications**: Integrate with FCM for incoming call notifications
2. **CallKit (iOS)**: Native call UI integration
3. **Foreground Service (Android)**: Keep call running in background
4. **Picture-in-Picture**: Minimize call to small window
5. **Call History**: Navigate to previous calls from history

## Related Files

- `lib/core/router/app_router.dart` - Main router configuration
- `lib/core/router/agora_call_router_notifier.dart` - Router notifier
- `lib/features/agora_call/presentation/services/call_navigation_service.dart` - Navigation service
- `lib/features/agora_call/presentation/services/call_lifecycle_observer.dart` - Lifecycle observer
- `lib/main.dart` - App initialization
- `android/app/src/main/AndroidManifest.xml` - Android deep linking config
- `ios/Runner/Info.plist` - iOS deep linking config
