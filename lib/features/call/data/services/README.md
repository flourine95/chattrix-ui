# Call Signaling Integration

This directory contains the WebSocket signaling services for the Agora video/audio call feature.

## Components

### 1. CallSignalingService
Handles sending and receiving call signaling messages over WebSocket:
- **Call Invitations**: Sent when initiating a call
- **Call Responses**: Sent when accepting/rejecting a call
- **Call Ended Notifications**: Sent when a call ends

### 2. CallInvitationManager
Manages incoming call invitations with automatic timeout handling:
- Listens to incoming invitations
- Starts a 30-second timeout timer for each invitation
- Automatically rejects invitations that timeout
- Provides streams for invitations and timeouts

### 3. CallSignalingProvider
Riverpod providers for dependency injection of signaling services.

## Integration with ChatWebSocketService

The call signaling is integrated with the existing `ChatWebSocketService`:

1. **Extended Message Types**: Added call-related message types to `ChatWebSocketResponse`:
   - `call.invitation`
   - `call.response`
   - `call.ended`

2. **Raw Message Stream**: Added `rawMessageStream` to expose all incoming WebSocket messages for custom handlers

3. **Generic Send Method**: Added `sendGenericMessage()` to allow sending custom message types

## Message Formats

### Call Invitation
```json
{
  "type": "call.invitation",
  "payload": {
    "callId": "uuid",
    "channelId": "string",
    "callerId": "string",
    "callerName": "string",
    "recipientId": "string",
    "callType": "audio|video",
    "timestamp": "iso8601"
  }
}
```

### Call Response
```json
{
  "type": "call.response",
  "payload": {
    "callId": "uuid",
    "response": "accepted|rejected",
    "timestamp": "iso8601"
  }
}
```

### Call Ended
```json
{
  "type": "call.ended",
  "payload": {
    "callId": "uuid",
    "endedBy": "string",
    "timestamp": "iso8601"
  }
}
```

## Usage in CallRepositoryImpl

The `CallRepositoryImpl` integrates with signaling services:

1. **Sending Invitations**: When `createCall()` is called, an invitation is sent via WebSocket
2. **Receiving Invitations**: Exposed through `incomingInvitationStream` getter
3. **Handling Timeouts**: Exposed through `invitationTimeoutStream` getter
4. **Ending Calls**: Sends call ended notification when `endCall()` is called
5. **Remote End**: Listens to call ended notifications and ends local call if remote participant ends

## Next Steps for Integration

To complete the integration, the presentation layer needs to:

1. **Provide WebSocket Service**: Wire up the `ChatWebSocketService` in the provider
2. **Listen to Invitations**: Subscribe to `incomingInvitationStream` to show incoming call UI
3. **Handle Timeouts**: Subscribe to `invitationTimeoutStream` to dismiss timed-out invitations
4. **Accept/Reject**: Call `CallInvitationManager.acceptInvitation()` or `rejectInvitation()`
5. **Show Notifications**: Display system notifications for background invitations

## Testing

The signaling services can be tested by:
1. Mocking the `ChatWebSocketService`
2. Verifying message formats match the specification
3. Testing timeout behavior with timers
4. Verifying invitation acceptance/rejection flows
