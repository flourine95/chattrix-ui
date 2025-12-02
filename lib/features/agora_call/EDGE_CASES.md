# Edge Case Handling Documentation

This document describes how the Agora call integration handles various edge cases to ensure a robust and reliable calling experience.

## Overview

The call system implements comprehensive edge case handling to address:
1. Multiple rapid incoming calls
2. Call events received in wrong order
3. WebSocket disconnection during active call
4. App termination during active call
5. Device rotation during video call

## Implementation Details

### 1. Multiple Rapid Incoming Calls (Requirement 2.5)

**Problem**: Users may receive multiple call invitations in quick succession (e.g., caller repeatedly pressing call button).

**Solution**: 
- Track the timestamp of the last incoming call
- If a new call arrives within 2 seconds of the previous one, automatically reject the previous call
- Keep only the most recent call invitation

**Implementation**:
- `CallStateProvider` tracks `_lastIncomingCallTime` and `_lastIncomingCallId`
- `CallEdgeCaseHandler.areCallsRapid()` determines if calls are within the rapid window
- `CallEdgeCaseHandler.handleRapidIncomingCalls()` rejects the previous call

**Code Location**: `lib/features/agora_call/presentation/providers/call_state_provider.dart` (lines ~425-435)

### 2. Call Events Received in Wrong Order (Requirement 8.3, 8.5)

**Problem**: WebSocket events may arrive out of order due to network conditions (e.g., `call.accepted` arrives before `call.incoming`).

**Solution**:
- Maintain a set of pending call IDs (`_pendingCallIds`)
- Validate all incoming events against current call ID and pending call IDs
- Ignore events for unknown call IDs
- Process events when the corresponding call entity is established

**Implementation**:
- `CallStateProvider` maintains `_pendingCallIds` set
- `CallEdgeCaseHandler.shouldProcessCallEvent()` validates event relevance
- All event handlers (`_handleCallAccepted`, `_handleCallRejected`, etc.) check if the event should be processed

**Code Location**: `lib/features/agora_call/presentation/providers/call_state_provider.dart` (event handlers)

### 3. WebSocket Disconnection During Active Call (Requirement 8.3)

**Problem**: WebSocket connection may drop during an active call, but Agora RTC continues working.

**Solution**:
- Agora RTC operates independently of WebSocket
- Display warning to user when WebSocket disconnects
- Attempt automatic reconnection
- Show success message when reconnected
- Call continues uninterrupted

**Implementation**:
- `CallWebSocketStatusProvider` monitors WebSocket connection status
- `ActiveCallScreen` listens to connection status changes
- `CallErrorHandler.showWebSocketDisconnectionWarning()` displays warning
- `CallErrorHandler.showWebSocketReconnectedMessage()` displays success message

**Code Location**: 
- `lib/features/agora_call/presentation/pages/active_call_screen.dart` (lines ~80-90)
- `lib/features/agora_call/presentation/providers/call_state_provider.dart` (CallWebSocketStatusProvider)

### 4. App Termination During Active Call (Requirement 8.3, 8.5)

**Problem**: User may close the app or system may terminate it while a call is active.

**Solution**:
- Monitor app lifecycle state changes
- When app enters `detached` state (terminating), gracefully end the active call
- Send end request to backend before termination
- Clean up Agora resources

**Implementation**:
- `CallStateProvider.handleAppLifecycleChange()` handles lifecycle events
- `_AppLifecycleObserver` in `ActiveCallScreen` monitors app state
- Calls `endCall()` with reason `'app_terminated'` when app is terminating

**Code Location**:
- `lib/features/agora_call/presentation/providers/call_state_provider.dart` (handleAppLifecycleChange method)
- `lib/features/agora_call/presentation/pages/active_call_screen.dart` (_AppLifecycleObserver class)

### 5. Device Rotation During Video Call (Requirement 8.3, 8.5)

**Problem**: Device rotation may disrupt video rendering or cause layout issues.

**Solution**:
- Monitor orientation changes using `MediaQuery`
- Agora SDK automatically handles video stream rotation
- Video views (RemoteVideoView, LocalVideoPreview) automatically adjust to new orientation
- No manual intervention required

**Implementation**:
- `ActiveCallScreen` tracks `currentOrientation` from `MediaQuery`
- `useEffect` hook monitors orientation changes
- Logs rotation events for debugging
- Agora SDK handles video stream adjustments internally

**Code Location**: `lib/features/agora_call/presentation/pages/active_call_screen.dart` (lines ~95-105)

## Additional Edge Cases Handled

### User Already in Call (Requirement 8.5)

**Problem**: User receives a new call invitation while already in an active call.

**Solution**:
- Check current call status when receiving invitation
- Auto-reject new call with reason `'busy'`
- Display notification to caller that user is busy

**Implementation**: `CallStateProvider._handleIncomingCall()` checks current call status

### Unknown Call Events

**Problem**: Receiving events for calls that don't exist in the system.

**Solution**:
- Validate call ID against current and pending calls
- Log and ignore events for unknown calls
- Prevent state corruption

**Implementation**: All event handlers validate call ID before processing

### App Backgrounding/Foregrounding

**Problem**: App may be backgrounded during a call (e.g., user switches apps).

**Solution**:
- Agora continues running in background
- Log lifecycle changes for debugging
- Resume UI when app returns to foreground
- Verify call is still active when foregrounded

**Implementation**: `CallStateProvider.handleAppLifecycleChange()` handles `paused` and `resumed` states

## Testing

Comprehensive unit tests verify edge case handling logic:

**Test File**: `test/features/agora_call/presentation/utils/call_edge_case_handler_test.dart`

**Test Coverage**:
- Rapid call detection (within/outside window)
- Event validation (current/pending/unknown calls)
- Callback invocation for all edge case handlers
- Logging functions don't throw exceptions

**Run Tests**:
```bash
flutter test test/features/agora_call/presentation/utils/call_edge_case_handler_test.dart
```

## Debugging

All edge case handling includes detailed logging:

**Log Format**: `CallEdgeCaseHandler: [Edge Case Type] Details`

**Examples**:
```
CallEdgeCaseHandler: [Rapid Incoming Calls] Rejecting previous call call-123 in favor of new call call-456
CallEdgeCaseHandler: [User Busy] Auto-rejecting incoming call call-789 - user already in call call-456
CallEdgeCaseHandler: [WebSocket Disconnection] WebSocket disconnected during active call call-456 - Agora continues, attempting reconnection
CallEdgeCaseHandler: [App Termination] App terminating during active call call-456 - ending call gracefully
CallEdgeCaseHandler: [Device Rotation] Device rotated to landscape during video call call-456 - views will adjust automatically
```

## Future Enhancements

Potential improvements for edge case handling:

1. **Retry Logic**: Implement exponential backoff for failed API calls
2. **Call Recovery**: Attempt to recover call state after WebSocket reconnection
3. **Offline Mode**: Queue call events when offline and process when reconnected
4. **Network Quality Adaptation**: Automatically switch to audio-only when video quality is poor
5. **Background Call Notifications**: Show persistent notification when call is active in background

## Related Files

- `lib/features/agora_call/presentation/providers/call_state_provider.dart` - Main call state management
- `lib/features/agora_call/presentation/pages/active_call_screen.dart` - Active call UI with lifecycle handling
- `lib/features/agora_call/presentation/utils/call_edge_case_handler.dart` - Edge case utility functions
- `lib/features/agora_call/presentation/utils/call_error_handler.dart` - Error display utilities
- `test/features/agora_call/presentation/utils/call_edge_case_handler_test.dart` - Edge case tests

## Requirements Validation

This implementation satisfies the following requirements:

- **Requirement 2.5**: Handle multiple rapid incoming calls (keep most recent, reject others) ✓
- **Requirement 8.3**: Handle WebSocket disconnection during active call (Agora continues) ✓
- **Requirement 8.5**: Handle call events received in wrong order ✓
- **Requirement 8.5**: Handle app termination during active call ✓
- **Requirement 8.5**: Handle device rotation during video call ✓
