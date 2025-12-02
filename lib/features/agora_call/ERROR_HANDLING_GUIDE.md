# Error Handling and Recovery Guide

This document describes the comprehensive error handling and recovery mechanisms implemented for the Agora call integration feature.

## Overview

The error handling system addresses all requirements from Requirement 8 (Error Handling):
- **8.1**: API errors with user-friendly messages
- **8.2**: Agora SDK errors with notification and cleanup
- **8.3**: WebSocket disconnection with reconnection attempt
- **8.4**: Quality warnings without terminating call
- **8.5**: Auto-reject incoming calls when user is busy

## Components

### 1. CallErrorHandler Utility

**Location**: `lib/features/agora_call/presentation/utils/call_error_handler.dart`

A centralized utility class for handling all call-related errors and providing user-friendly messages.

#### Key Methods:

- **`getErrorMessage(CallFailure)`**: Converts domain failures to user-friendly messages
- **`showErrorDialog()`**: Displays error dialogs with appropriate messaging
- **`showErrorSnackBar()`**: Shows error snackbars with optional retry action
- **`showQualityWarning()`**: Displays quality warnings without terminating calls
- **`showNetworkQualityWarning()`**: Shows network degradation warnings
- **`showWebSocketDisconnectionWarning()`**: Notifies users of WebSocket disconnection
- **`showWebSocketReconnectedMessage()`**: Confirms successful reconnection
- **`showAgoraErrorDialog()`**: Handles critical Agora SDK errors with cleanup
- **`showPermissionDeniedDialog()`**: Guides users to enable permissions
- **`showUserBusyNotification()`**: Notifies users of missed calls when busy

### 2. Enhanced Call State Provider

**Location**: `lib/features/agora_call/presentation/providers/call_state_provider.dart`

#### New Providers:

**QualityWarningProvider**
- Tracks current quality warnings
- Automatically clears warnings after 5 seconds
- Used by UI to display quality banners

**CallWebSocketStatusProvider**
- Monitors WebSocket connection status
- Enables UI to react to connection changes
- Supports reconnection notifications

#### Enhanced Error Handling:

**Auto-Reject When Busy (Requirement 8.5)**
```dart
void _handleIncomingCall(dynamic data) {
  // Check if user is already in a call
  final currentCall = state.value;
  if (currentCall != null && 
      (currentCall.status == CallStatus.ringing || 
       currentCall.status == CallStatus.connecting ||
       currentCall.status == CallStatus.connected)) {
    // Auto-reject the incoming call
    rejectCall(callId: invitation.callId, reason: 'busy');
    return;
  }
  // ... handle incoming call
}
```

**Quality Warning Handling (Requirement 8.4)**
```dart
void _handleQualityWarning(dynamic data) {
  // Update quality warning provider
  ref.read(qualityWarningProvider.notifier).setWarning(message);
  
  // Auto-clear after 5 seconds
  Future.delayed(const Duration(seconds: 5), () {
    ref.read(qualityWarningProvider.notifier).clearWarning();
  });
}
```

**Agora Error Handling (Requirement 8.2)**
```dart
Future<void> _joinAgoraChannel(CallConnectionEntity connection) async {
  try {
    await agoraService.joinChannel(...);
  } catch (e) {
    // Create Agora error failure
    final failure = CallFailure.agoraError(e.toString());
    state = AsyncValue.error(failure, StackTrace.current);
    
    // Attempt cleanup and end call
    await endCall(connection.callEntity.id, reason: 'connection_failed');
  }
}
```

### 3. Enhanced Agora Engine Service

**Location**: `lib/features/agora_call/data/services/agora_engine_service.dart`

Provides more specific error messages for common Agora SDK errors:

```dart
Future<void> joinChannel(...) async {
  try {
    await _engine!.joinChannel(...);
  } catch (e) {
    final errorMessage = e.toString();
    if (errorMessage.contains('token')) {
      throw Exception('Invalid call token. Please try again.');
    } else if (errorMessage.contains('network')) {
      throw Exception('Network error. Please check your connection.');
    } else if (errorMessage.contains('permission')) {
      throw Exception('Permission denied. Please enable camera and microphone.');
    }
    // ... more specific error handling
  }
}
```

### 4. Enhanced Active Call Screen

**Location**: `lib/features/agora_call/presentation/pages/active_call_screen.dart`

#### Network Quality Monitoring (Requirement 8.4)

```dart
onNetworkQuality: (connection, localUid, txQuality, rxQuality) {
  final worstQuality = txQuality.index > rxQuality.index ? txQuality : rxQuality;
  
  // Show warning if quality degrades significantly
  if (previousQuality != QualityType.qualityUnknown &&
      worstQuality.index > QualityType.qualityGood.index &&
      previousQuality.index <= QualityType.qualityGood.index) {
    CallErrorHandler.showNetworkQualityWarning(context);
  }
}
```

#### Agora Error Handling (Requirement 8.2)

```dart
void _handleAgoraError(BuildContext context, WidgetRef ref, ErrorCodeType err, String msg) {
  final criticalErrors = [
    ErrorCodeType.errInvalidToken,
    ErrorCodeType.errTokenExpired,
    ErrorCodeType.errConnectionLost,
    ErrorCodeType.errConnectionInterrupted,
  ];

  if (criticalErrors.contains(err)) {
    // Show error dialog and end call
    CallErrorHandler.showAgoraErrorDialog(context, msg, onEndCall: () async {
      final call = ref.read(callStateProvider).value;
      if (call != null) {
        await ref.read(callStateProvider.notifier).endCall(call.id, reason: 'agora_error');
      }
      if (context.mounted) {
        context.pop();
      }
    });
  } else {
    // Non-critical errors - show warning but continue call
    CallErrorHandler.showQualityWarning(context, 'Connection issue: $msg');
  }
}
```

#### WebSocket Reconnection Monitoring (Requirement 8.3)

```dart
// Listen to WebSocket connection status
ref.listen<bool>(callWebSocketStatusProvider, (previous, next) {
  if (previous == true && next == false && context.mounted) {
    // WebSocket disconnected
    CallErrorHandler.showWebSocketDisconnectionWarning(context);
  } else if (previous == false && next == true && context.mounted) {
    // WebSocket reconnected
    CallErrorHandler.showWebSocketReconnectedMessage(context);
  }
});
```

#### Quality Warning Display (Requirement 8.4)

```dart
// Listen to quality warnings
ref.listen<String?>(qualityWarningProvider, (previous, next) {
  if (next != null && context.mounted) {
    CallErrorHandler.showQualityWarning(context, next);
  }
});
```

### 5. Enhanced Call Screens

**Incoming Call Screen** and **Outgoing Call Screen** now use `CallErrorHandler` for consistent error messaging:

```dart
error: (error, stack) {
  if (error is CallFailure) {
    CallErrorHandler.showErrorDialog(context, error, onDismiss: () {
      if (context.mounted) {
        context.pop();
      }
    });
  } else {
    _showErrorDialog(context, error);
  }
}
```

### 6. Enhanced Call Initiation Helper

**Location**: `lib/features/agora_call/presentation/utils/call_initiation_helper.dart`

Uses `CallErrorHandler` for user-friendly error messages:

```dart
catch (e) {
  if (e is CallFailure) {
    CallErrorHandler.showErrorSnackBar(context, e);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to start call: ${e.toString()}'))
    );
  }
}
```

## Error Flow Diagrams

### API Error Flow

```
API Call → Exception → Repository catches → Maps to CallFailure
  ↓
CallFailure returned via Either<CallFailure, T>
  ↓
Provider receives failure → Updates state to error
  ↓
UI listens to state → Detects CallFailure
  ↓
CallErrorHandler.showErrorDialog() → User sees friendly message
```

### Agora SDK Error Flow

```
Agora SDK Error → AgoraEngineService catches → Throws specific exception
  ↓
Provider catches → Creates CallFailure.agoraError
  ↓
Attempts cleanup: endCall() + leaveChannel()
  ↓
UI detects error state → Shows error dialog
  ↓
User acknowledges → Call ends → Navigate back
```

### WebSocket Disconnection Flow

```
WebSocket disconnects → ChatWebSocketService detects
  ↓
Automatic reconnection attempt (5 second delay)
  ↓
CallWebSocketStatusProvider updates (false)
  ↓
ActiveCallScreen listens → Shows "Connection lost. Reconnecting..."
  ↓
WebSocket reconnects → CallWebSocketStatusProvider updates (true)
  ↓
ActiveCallScreen shows "Connection restored"
  ↓
Note: Agora RTC continues independently during WebSocket reconnection
```

### Quality Warning Flow

```
Network quality degrades → Agora SDK onNetworkQuality callback
  ↓
ActiveCallScreen detects quality drop
  ↓
CallErrorHandler.showNetworkQualityWarning()
  ↓
User sees orange banner: "Poor network quality detected"
  ↓
Call continues (NOT terminated)
```

OR

```
Backend sends call.quality_warning event → WebSocket receives
  ↓
CallStateProvider._handleQualityWarning()
  ↓
QualityWarningProvider updated with message
  ↓
ActiveCallScreen listens → Shows quality warning banner
  ↓
Auto-clears after 5 seconds
```

### Auto-Reject When Busy Flow

```
User in active call (status: ringing/connecting/connected)
  ↓
New call.incoming event received
  ↓
CallStateProvider._handleIncomingCall() checks current call
  ↓
Detects user is busy → Calls rejectCall(reason: 'busy')
  ↓
Backend receives rejection → Notifies caller
  ↓
No UI shown to busy user (silent rejection)
```

## User-Friendly Error Messages

The `CallErrorHandler.getErrorMessage()` method maps technical failures to user-friendly messages:

| CallFailure Type | User-Friendly Message |
|------------------|----------------------|
| `serverError` (timeout) | "The request timed out. Please check your connection and try again." |
| `serverError` (maintenance) | "The service is currently under maintenance. Please try again later." |
| `serverError` (generic) | "Unable to complete the call. Please try again." |
| `networkError` | "No internet connection. Please check your network and try again." |
| `userBusy` | "The user is currently on another call. Please try again later." |
| `callNotFound` | "This call is no longer available." |
| `permissionDenied` (camera) | "Camera permission is required for video calls. Please enable it in settings." |
| `permissionDenied` (microphone) | "Microphone permission is required for calls. Please enable it in settings." |
| `agoraError` (token) | "Call authentication failed. Please try again." |
| `agoraError` (network) | "Network connection issue. Please check your internet and try again." |
| `agoraError` (channel) | "Unable to connect to the call. Please try again." |
| `unauthorized` | "Your session has expired. Please log in again." |

## Testing Error Scenarios

### Manual Testing Checklist

1. **API Errors (8.1)**
   - [ ] Initiate call with no internet → See network error message
   - [ ] Call user who is busy → See "user is busy" message
   - [ ] Call with expired token → See "session expired" message

2. **Agora SDK Errors (8.2)**
   - [ ] Join channel with invalid token → See error dialog and call ends
   - [ ] Lose network during call → See connection error and cleanup
   - [ ] Deny camera permission → See permission error

3. **WebSocket Disconnection (8.3)**
   - [ ] Disconnect WiFi during call → See "Connection lost. Reconnecting..."
   - [ ] Reconnect WiFi → See "Connection restored"
   - [ ] Verify Agora call continues during WebSocket reconnection

4. **Quality Warnings (8.4)**
   - [ ] Simulate poor network → See quality warning banner
   - [ ] Verify call continues (not terminated)
   - [ ] Warning auto-clears after 5 seconds

5. **Auto-Reject When Busy (8.5)**
   - [ ] Be in active call → Receive another call → Verify silent rejection
   - [ ] Caller sees "user is busy" message

## Best Practices

1. **Always use CallErrorHandler** for displaying errors to users
2. **Never show raw exception messages** to users
3. **Provide retry options** when appropriate (network errors)
4. **Guide users to settings** for permission errors
5. **Clean up resources** before ending calls on errors
6. **Log errors** for debugging while showing friendly messages to users
7. **Don't terminate calls** for non-critical errors (quality warnings)
8. **Auto-clear transient warnings** to avoid cluttering the UI

## Future Enhancements

1. **Retry Logic**: Automatic retry for transient network errors
2. **Error Analytics**: Track error rates and types for monitoring
3. **Offline Queue**: Queue call attempts when offline
4. **Better Recovery**: Attempt to rejoin Agora channel on network recovery
5. **User Feedback**: Allow users to report call quality issues
