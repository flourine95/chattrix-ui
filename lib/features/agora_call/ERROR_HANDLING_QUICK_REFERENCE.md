# Error Handling Quick Reference

Quick reference guide for developers working with call error handling.

## When to Use What

### Displaying Errors to Users

```dart
// For CallFailure objects - Use CallErrorHandler
if (error is CallFailure) {
  CallErrorHandler.showErrorDialog(context, error);
  // OR
  CallErrorHandler.showErrorSnackBar(context, error);
}

// For generic errors - Use standard Flutter widgets
else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error: ${error.toString()}'))
  );
}
```

### Quality Warnings (Don't Terminate Call)

```dart
// Show quality warning banner
CallErrorHandler.showQualityWarning(context, 'Poor network quality');

// OR use the provider for automatic display
ref.read(qualityWarningProvider.notifier).setWarning('Custom warning');
```

### Network Quality Degradation

```dart
// In Agora event handler
onNetworkQuality: (connection, localUid, txQuality, rxQuality) {
  if (qualityIsPoor) {
    CallErrorHandler.showNetworkQualityWarning(context);
  }
}
```

### WebSocket Connection Status

```dart
// Listen to connection status
ref.listen<bool>(callWebSocketStatusProvider, (previous, next) {
  if (previous == true && next == false) {
    CallErrorHandler.showWebSocketDisconnectionWarning(context);
  } else if (previous == false && next == true) {
    CallErrorHandler.showWebSocketReconnectedMessage(context);
  }
});
```

### Agora SDK Errors

```dart
// For critical errors that require ending the call
CallErrorHandler.showAgoraErrorDialog(
  context,
  errorMessage,
  onEndCall: () async {
    await ref.read(callStateProvider.notifier).endCall(callId, reason: 'agora_error');
    if (context.mounted) context.pop();
  },
);

// For non-critical errors (show warning, continue call)
CallErrorHandler.showQualityWarning(context, 'Connection issue: $message');
```

### Permission Errors

```dart
CallErrorHandler.showPermissionDeniedDialog(
  context,
  'camera and microphone',
  onOpenSettings: () async {
    await permissionService.openSettings();
  },
);
```

### User Busy Notifications

```dart
CallErrorHandler.showUserBusyNotification(context, callerName);
```

## Error Message Mapping

```dart
// Get user-friendly message from CallFailure
final message = CallErrorHandler.getErrorMessage(failure);
```

## Common Patterns

### Pattern 1: API Call with Error Handling

```dart
try {
  await ref.read(callStateProvider.notifier).initiateCall(
    calleeId: calleeId,
    callType: callType,
  );
  // Success - navigate
  if (context.mounted) {
    context.push('/agora-call/outgoing');
  }
} catch (e) {
  if (e is CallFailure) {
    CallErrorHandler.showErrorSnackBar(context, e);
  } else {
    // Handle unexpected errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Unexpected error: ${e.toString()}'))
    );
  }
}
```

### Pattern 2: Listening to Call State Errors

```dart
ref.listen<AsyncValue<CallEntity?>>(callStateProvider, (previous, next) {
  next.when(
    data: (call) {
      // Handle success
    },
    loading: () {
      // Show loading
    },
    error: (error, stack) {
      if (error is CallFailure) {
        CallErrorHandler.showErrorDialog(context, error);
      }
    },
  );
});
```

### Pattern 3: Agora Event Handler

```dart
agoraService.registerEventHandlers(
  onError: (err, msg) {
    final criticalErrors = [
      ErrorCodeType.errInvalidToken,
      ErrorCodeType.errTokenExpired,
      ErrorCodeType.errConnectionLost,
    ];
    
    if (criticalErrors.contains(err)) {
      // End call
      CallErrorHandler.showAgoraErrorDialog(context, msg, onEndCall: ...);
    } else {
      // Show warning, continue call
      CallErrorHandler.showQualityWarning(context, msg);
    }
  },
);
```

### Pattern 4: Auto-Reject When Busy

```dart
// In CallStateProvider._handleIncomingCall()
final currentCall = state.value;
if (currentCall != null && 
    (currentCall.status == CallStatus.ringing || 
     currentCall.status == CallStatus.connecting ||
     currentCall.status == CallStatus.connected)) {
  // User is busy - auto-reject
  rejectCall(callId: invitation.callId, reason: 'busy');
  return;
}
```

## Critical vs Non-Critical Errors

### Critical Errors (End Call)
- Invalid/expired Agora token
- Connection lost
- Connection interrupted
- Authentication failures
- Permission permanently denied

### Non-Critical Errors (Show Warning, Continue)
- Temporary network quality issues
- Minor connection hiccups
- Quality degradation warnings
- WebSocket disconnection (Agora continues)

## Best Practices

1. ✅ **Always use CallErrorHandler** for user-facing errors
2. ✅ **Never show raw exceptions** to users
3. ✅ **Provide retry options** for network errors
4. ✅ **Guide to settings** for permission errors
5. ✅ **Clean up resources** before ending calls
6. ✅ **Log technical details** for debugging
7. ✅ **Don't terminate calls** for quality warnings
8. ✅ **Auto-clear warnings** after 5 seconds

## Testing Checklist

- [ ] Network error → User-friendly message
- [ ] User busy → Auto-reject + notification
- [ ] Invalid token → Error dialog + cleanup
- [ ] Quality warning → Banner (no termination)
- [ ] WebSocket disconnect → Warning + auto-reconnect
- [ ] Permission denied → Settings guidance
- [ ] Critical Agora error → Dialog + end call
- [ ] Non-critical error → Warning + continue

## Import Statement

```dart
import 'package:chattrix_ui/features/agora_call/presentation/utils/call_error_handler.dart';
```

## Related Files

- `call_error_handler.dart` - Main utility class
- `call_state_provider.dart` - State management with error handling
- `ERROR_HANDLING_GUIDE.md` - Comprehensive documentation
- `TASK_19_SUMMARY.md` - Implementation summary
