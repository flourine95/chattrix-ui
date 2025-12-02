# Video Call - Quick Reference

## 🚀 Quick Start (3 bước)

### 1. Add AGORA_APP_ID to .env
```env
AGORA_APP_ID=your_app_id_here
```

### 2. Import
```dart
import 'package:chattrix_ui/features/video_call/video_call.dart';
```

### 3. Navigate to call screen
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => CallScreen(
      calleeId: 123,
      callType: CallType.video, // or CallType.audio
    ),
  ),
);
```

## 📱 Common Use Cases

### Make a video call
```dart
Navigator.push(context, MaterialPageRoute(
  builder: (_) => CallScreen(calleeId: userId, callType: CallType.video),
));
```

### Make an audio call
```dart
Navigator.push(context, MaterialPageRoute(
  builder: (_) => CallScreen(calleeId: userId, callType: CallType.audio),
));
```

### Handle incoming call (from WebSocket)
```dart
void onWebSocketMessage(Map<String, dynamic> message) {
  if (message['type'] == 'call.incoming') {
    final invitation = CallInvitation.fromJson(message['payload']);
    
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => CallScreen(
        invitation: invitation,
        callType: invitation.callType,
      ),
    ));
  }
}
```

### Access call state
```dart
final callState = ref.watch(callControllerProvider);

print('Status: ${callState.status}');
print('Is muted: ${callState.isMuted}');
print('Camera on: ${callState.isCameraOn}');
print('Remote UID: ${callState.remoteUid}');
```

### Control call programmatically
```dart
final controller = ref.read(callControllerProvider.notifier);

// Initiate
await controller.initiateCall(123, CallType.video);

// Accept
await controller.acceptCall(invitation);

// Reject
await controller.rejectCall(callId, RejectReason.declined);

// End
await controller.endCall();

// Toggle mic
await controller.toggleMicrophone();

// Toggle camera
await controller.toggleCamera();

// Toggle speaker
await controller.toggleSpeaker();

// Switch camera
await controller.switchCamera();
```

## 🔌 WebSocket Events

```dart
switch (message['type']) {
  case 'call.incoming':
    final invitation = CallInvitation.fromJson(payload);
    // Show incoming call screen
    break;
    
  case 'call.accepted':
    // Call was accepted
    break;
    
  case 'call.rejected':
    final reject = CallReject.fromJson(payload);
    // Handle rejection
    break;
    
  case 'call.ended':
    final end = CallEnd.fromJson(payload);
    // Handle call end
    break;
    
  case 'call.timeout':
    // Handle timeout
    break;
}
```

## 🎨 UI Features

CallScreen includes:
- ✅ Full screen remote video
- ✅ Small local video overlay (top-right)
- ✅ Bottom controls (mute, camera, end, switch, speaker)
- ✅ Incoming call overlay (accept/reject)
- ✅ Status text
- ✅ Auto permission requests

## 📦 Models

### CallType
```dart
enum CallType { audio, video }
```

### CallStatus
```dart
enum CallStatus {
  ringing,
  connecting,
  connected,
  rejected,
  ended,
  initiating,
}
```

### RejectReason
```dart
enum RejectReason { busy, declined, unavailable }
```

### CallState
```dart
class CallState {
  final CallStateStatus status;
  final CallConnection? connection;
  final CallInvitation? invitation;
  final String? error;
  final bool isMuted;
  final bool isCameraOn;
  final bool isSpeakerOn;
  final int? remoteUid;
}
```

## 🐛 Troubleshooting

### Issue: Can't join channel
**Fix**: Check AGORA_APP_ID and backend token

### Issue: No video/audio
**Fix**: Check permissions are granted

### Issue: IDE shows errors
**Fix**: Run `flutter clean && flutter pub get`

## 📚 Full Docs

- `README.md` - Complete documentation
- `SETUP_GUIDE.md` - Setup instructions
- `STATUS.md` - Current status & changes
- `example/call_example.dart` - Code examples

## 💡 Tips

1. Test on real devices (not emulator)
2. Need 2 devices for full testing
3. Ensure backend implements all API endpoints
4. Use logger for debugging (not print)
5. Check WebSocket connection before calling

---

**Status**: ✅ Ready to use | No errors | Full documentation available

