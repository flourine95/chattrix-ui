# WebSocket Call Signaling Models

This directory contains Freezed models for WebSocket call signaling messages.

## Message Structure

All WebSocket messages from the server follow this structure:

```json
{
  "type": "message_type",
  "data": { /* message-specific data */ },
  "timestamp": "2025-11-23T15:00:00Z"
}
```

## Message Types

### Server → Client Messages

1. **call_invitation** - Incoming call invitation
   - Data: `CallInvitationData`
   - Contains: callId, channelId, callerId, callerName, callerAvatar, callType

2. **call_accepted** - Call was accepted by callee
   - Data: `CallAcceptedData`
   - Contains: callId, acceptedBy

3. **call_rejected** - Call was rejected by callee
   - Data: `CallRejectedData`
   - Contains: callId, rejectedBy, reason

4. **call_ended** - Call was ended by either participant
   - Data: `CallEndedData`
   - Contains: callId, endedBy, durationSeconds

5. **call_timeout** - Call timed out (not answered within 60 seconds)
   - Data: `CallTimeoutData`
   - Contains: callId

6. **call_quality_warning** - Network quality degraded
   - Data: `CallQualityWarningData`
   - Contains: callId, quality

## Usage

```dart
import 'package:chattrix_ui/features/call/data/models/websocket/websocket_models.dart';

// Parse incoming WebSocket message
void handleMessage(Map<String, dynamic> json) {
  final type = json['type'] as String;
  
  switch (type) {
    case 'call_invitation':
      final message = CallInvitationMessage.fromJson(json);
      // Handle invitation: message.data contains CallInvitationData
      break;
      
    case 'call_accepted':
      final message = CallAcceptedMessage.fromJson(json);
      // Handle acceptance: message.data contains CallAcceptedData
      break;
      
    // ... other cases
  }
}
```

## Code Generation

After modifying any model, run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

This generates:
- `.freezed.dart` files (immutable classes)
- `.g.dart` files (JSON serialization)

## API Integration

These models match the backend API structure defined in:
- `chattrix-api/src/main/java/com/chattrix/api/websocket/dto/`
- `chattrix-api/FLUTTER_INTEGRATION_GUIDE.md`
