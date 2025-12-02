# Agora Call Integration Guide

This guide shows how to integrate Agora call functionality into your screens.

## Quick Start

### 1. Add Call Buttons to Chat Screen

The easiest way to add call functionality is to use the `CallButton` widget:

```dart
import 'package:chattrix_ui/features/agora_call/presentation/widgets/widgets.dart';
import 'package:chattrix_ui/features/agora_call/domain/entities/call_entity.dart';

// In your AppBar actions:
actions: [
  // Audio call button
  CallButton(
    calleeId: remoteUserId,
    calleeName: remoteName,
    callType: CallType.audio,
    tooltip: 'Audio call',
  ),
  
  // Video call button
  CallButton(
    calleeId: remoteUserId,
    calleeName: remoteName,
    callType: CallType.video,
    tooltip: 'Video call',
  ),
  
  // Or show dialog to select call type
  CallButton(
    calleeId: remoteUserId,
    calleeName: remoteName,
    // callType: null, // Shows dialog
  ),
]
```

### 2. Manual Call Initiation

For more control, use the `CallInitiationHelper`:

```dart
import 'package:chattrix_ui/features/agora_call/presentation/utils/call_initiation_helper.dart';
import 'package:chattrix_ui/features/agora_call/domain/entities/call_entity.dart';

// Show dialog to select call type
await CallInitiationHelper.initiateCallWithDialog(
  context: context,
  ref: ref,
  calleeId: remoteUserId,
  calleeName: remoteName,
);

// Or initiate directly with known call type
await CallInitiationHelper.initiateCall(
  context: context,
  ref: ref,
  calleeId: remoteUserId,
  calleeName: remoteName,
  callType: CallType.video,
);
```

## Features

### Automatic Permission Handling

The call initiation flow automatically:
- Requests microphone permission for audio calls
- Requests camera + microphone permissions for video calls
- Shows appropriate error messages if permissions are denied
- Offers to open app settings if permissions are permanently denied

### Automatic Navigation

After initiating a call:
1. Loading indicator is shown
2. Call is initiated via backend API
3. Agora channel is joined with credentials
4. User is navigated to `OutgoingCallScreen`
5. When callee accepts, navigates to `ActiveCallScreen`

### Error Handling

All errors are handled gracefully:
- Network errors
- Permission errors
- API errors
- Agora SDK errors

## Routes

The following routes are available:

- `/agora-call/outgoing` - Outgoing call screen (calling...)
- `/agora-call/incoming` - Incoming call screen (accept/reject)
- `/agora-call/active` - Active call screen (in call)

## Example: Adding to Chat Screen

```dart
// In ChatViewPage AppBar
AppBar(
  title: Text(userName),
  actions: [
    // Audio call
    CallButton(
      calleeId: otherUserId,
      calleeName: userName,
      callType: CallType.audio,
    ),
    
    // Video call
    CallButton(
      calleeId: otherUserId,
      calleeName: userName,
      callType: CallType.video,
    ),
  ],
)
```

## Example: Adding to Contact List

```dart
// In contact list item
ListTile(
  title: Text(contact.name),
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      CallButton(
        calleeId: contact.id,
        calleeName: contact.name,
        callType: CallType.audio,
        iconSize: 18,
      ),
      CallButton(
        calleeId: contact.id,
        calleeName: contact.name,
        callType: CallType.video,
        iconSize: 18,
      ),
    ],
  ),
)
```

## Requirements

Make sure the following are configured:

1. **Environment Variables**: `AGORA_APP_ID` in `.env` file
2. **Permissions**: 
   - Android: `AndroidManifest.xml` has camera and microphone permissions
   - iOS: `Info.plist` has usage descriptions
3. **Backend**: Call API endpoints are implemented and accessible

## Testing

To test the call functionality:

1. Ensure two users are logged in on different devices
2. Navigate to a chat screen
3. Tap the call button
4. Select call type (if dialog is shown)
5. Grant permissions when prompted
6. Wait for the other user to accept
7. Test call controls (mute, video, camera switch, end)
