# Design Document

## Overview

This design addresses critical issues in the Chattrix UI call system where:
1. **Call invitations are not delivered to recipients** - The WebSocket signaling is implemented but not properly integrated with the call initiation flow
2. **Multiple users calling simultaneously end up in different channels** - Channel ID generation is not synchronized between caller and callee

### Root Cause Analysis

**Problem 1: Missing WebSocket Integration in Call Initiation**
- The `CallStateProvider.initiateCall()` method creates a call via REST API but does NOT send a WebSocket `call_invitation` message
- The backend expects the client to send WebSocket signaling messages, but the client only uses REST API
- Result: Callee never receives notification of incoming call

**Problem 2: Channel ID Mismatch**
- Caller generates a channel ID locally using `_generateChannelId()`
- When callee accepts, they may generate a different channel ID or use an incorrect one
- The backend stores the channel ID, but it's not reliably communicated to the callee
- Result: Caller and callee join different Agora channels

### Solution Approach

1. **Integrate WebSocket signaling into call flow**: After REST API call creation, immediately send `call_invitation` via WebSocket
2. **Use backend-provided channel ID**: Backend generates and stores channel ID, then includes it in the `call_invitation` message
3. **Ensure callee uses invitation channel ID**: When accepting, callee must extract channel ID from the invitation message, not generate a new one
4. **Add proper error handling**: Validate WebSocket connection before initiating calls

## A
rchitecture

### Current Architecture (Problematic)

```
┌─────────────────────┐
│  CallStateProvider  │
│  (initiateCall)     │
└──────────┬──────────┘
           │
           │ 1. POST /v1/calls/initiate
           ▼
┌─────────────────────┐
│   Backend API       │
│   (creates call)    │
└──────────┬──────────┘
           │
           │ ❌ NO WebSocket message sent
           │ ❌ Callee never notified
           ▼
      (nothing)
```

### Fixed Architecture

```
┌─────────────────────┐
│  CallStateProvider  │
│  (initiateCall)     │
└──────────┬──────────┘
           │
           │ 1. POST /v1/calls/initiate
           ▼
┌─────────────────────┐
│   Backend API       │
│   (creates call +   │
│    generates        │
│    channel ID)      │
└──────────┬──────────┘
           │
           │ 2. Response: {callId, channelId, ...}
           ▼
┌─────────────────────┐
│  CallStateProvider  │
│  (receives response)│
└──────────┬──────────┘
           │
           │ 3. Send WebSocket message
           ▼
┌─────────────────────┐
│ CallSignalingService│
│ (sendCallInvitation)│
└──────────┬──────────┘
           │
           │ 4. WebSocket: call_invitation
           │    {callId, channelId, ...}
           ▼
┌─────────────────────┐
│   Backend API       │
│   (routes to callee)│
└──────────┬──────────┘
           │
           │ 5. WebSocket: call_invitation
           ▼
┌─────────────────────┐
│ IncomingCallListener│
│ (callee side)       │
└──────────┬──────────┘
           │
           │ 6. Display incoming call screen
           │    with channelId from invitation
           ▼
┌─────────────────────┐
│ IncomingCallScreen  │
│ (shows caller info) │
└─────────────────────┘
```

### Layer Responsibilities

**Presentation Layer**
- `CallStateProvider`: Orchestrates call lifecycle, coordinates between repository and signaling service
- `IncomingCallProvider`: Manages incoming call state, listens to signaling service
- `IncomingCallListener`: Widget that displays incoming call UI when invitation arrives
- `CallScreen`: Active call UI with Agora video/audio rendering

**Data Layer**
- `CallRepository`: Handles REST API calls for call CRUD operations
- `CallSignalingService`: Manages WebSocket signaling messages (invitation, accept, reject, end)
- `AgoraService`: Manages Agora RTC engine, channel joining, media controls
- `TokenService`: Fetches and refreshes Agora tokens from backend

**Domain Layer**
- `CallEntity`: Immutable call data model
- `CallRepository` (interface): Abstract repository contract

## Components and Interfaces

### 1. CallStateProvider (Modified)

**Current Issues:**
- Does not send WebSocket invitation after REST API call
- Generates channel ID locally instead of using backend-provided ID
- No validation of WebSocket connection state

**Required Changes:**

```dart
@Riverpod(keepAlive: true)
class Call extends _$Call {
  CallSignalingService? _signalingService;
  
  @override
  Future<CallEntity?> build() async {
    // Inject signaling service
    _signalingService = ref.read(callSignalingServiceProvider);
    return null;
  }

  Future<void> initiateCall({
    required String remoteUserId,
    required CallType callType,
    String? callerId,
    String? callerName,
    String? conversationId,
  }) async {
    // 1. Validate WebSocket connection
    if (_signalingService == null || !_signalingService!.isConnected) {
      throw WebSocketNotConnectedException();
    }

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(callRepositoryProvider);

      // 2. Create call via REST API (backend generates channel ID)
      final result = await repository.createCall(
        callId: _generateCallId(),
        channelId: '', // Backend will generate this
        remoteUserId: remoteUserId,
        callType: callType,
        callerId: callerId,
        callerName: callerName,
      );

      return result.fold(
        (failure) => throw _mapFailureToException(failure),
        (call) {
          // 3. Send WebSocket invitation with backend-provided channel ID
          _signalingService!.sendCallInvitation(
            callId: call.callId,
            channelId: call.channelId, // Use backend-provided channel ID
            callerId: call.callerId,
            callerName: call.callerName ?? 'Unknown',
            recipientId: remoteUserId,
            callType: callType,
          );

          // 4. Return call entity
          return call;
        },
      );
    });
  }
}
```

### 2. CallSignalingService (Modified)

**Current Issues:**
- Exists but not injected into CallStateProvider
- Message format may not match backend expectations

**Required Changes:**

```dart
class CallSignalingService {
  final ChatWebSocketService _webSocketService;

  // Add connection state getter
  bool get isConnected => _webSocketService.isConnected;

  // Ensure message format matches backend expectations
  void sendCallInvitation({
    required String callId,
    required String channelId,
    required String callerId,
    required String callerName,
    required String recipientId,
    required CallType callType,
  }) {
    if (!isConnected) {
      throw WebSocketNotConnectedException();
    }

    final payload = {
      'type': 'call.invitation',
      'payload': {
        'callId': callId,
        'channelId': channelId,
        'callerId': callerId,
        'callerName': callerName,
        'recipientId': recipientId,
        'callType': callType == CallType.video ? 'VIDEO' : 'AUDIO',
        'timestamp': DateTime.now().toIso8601String(),
      },
    };

    _webSocketService.sendGenericMessage(payload);
  }
}
```

### 3. IncomingCallProvider (New)

**Purpose:** Manages incoming call state by listening to CallSignalingService

```dart
@riverpod
class IncomingCall extends _$IncomingCall {
  StreamSubscription<CallInvitation>? _invitationSubscription;

  @override
  CallInvitation? build() {
    final signalingService = ref.watch(callSignalingServiceProvider);

    // Listen to invitation stream
    _invitationSubscription = signalingService.callInvitationStream.listen((invitation) {
      state = invitation;
    });

    ref.onDispose(() {
      _invitationSubscription?.cancel();
    });

    return null;
  }

  void clearInvitation() {
    state = null;
  }
}

@riverpod
CallInvitation? currentIncomingCall(Ref ref) {
  return ref.watch(incomingCallProvider);
}
```

### 4. IncomingCallListener (Modified)

**Current Issues:**
- Listens to provider but provider is not connected to signaling service

**Required Changes:**

```dart
class _IncomingCallListenerState extends ConsumerState<IncomingCallListener> {
  @override
  Widget build(BuildContext context) {
    // Listen to incoming call provider (which now listens to signaling service)
    ref.listen<CallInvitation?>(currentIncomingCallProvider, (previous, next) {
      if (next != null && previous?.callId != next.callId) {
        if (_isAppInForeground()) {
          // Navigate with invitation data including channelId
          context.push('/incoming-call', extra: next);
        } else {
          // Show notification if app is in background
          _showCallNotification(next);
        }
      }
    });

    return widget.child;
  }
}
```

### 5. IncomingCallScreen (Modified)

**Current Issues:**
- May not properly extract channel ID from invitation
- Accept logic may generate new channel ID instead of using invitation's

**Required Changes:**

```dart
class IncomingCallScreen extends HookConsumerWidget {
  final CallInvitation invitation;

  const IncomingCallScreen({super.key, required this.invitation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> acceptCall() async {
      // Use channel ID from invitation, NOT generated locally
      await ref.read(callProvider.notifier).acceptCall(
        callId: invitation.callId,
        channelId: invitation.channelId, // Critical: use invitation's channel ID
        remoteUserId: invitation.callerId,
        callType: invitation.callType,
      );

      // Navigate to call screen
      context.go('/call/${invitation.callId}');
    }

    Future<void> rejectCall() async {
      // Send rejection via signaling service
      ref.read(callSignalingServiceProvider).sendCallResponse(
        callId: invitation.callId,
        response: CallResponseType.rejected,
      );

      // Clear invitation and go back
      ref.read(incomingCallProvider.notifier).clearInvitation();
      context.pop();
    }

    return Scaffold(
      body: Column(
        children: [
          Text('${invitation.callerName} is calling...'),
          Text(invitation.callType == CallType.video ? 'Video Call' : 'Audio Call'),
          Row(
            children: [
              ElevatedButton(
                onPressed: acceptCall,
                child: Text('Accept'),
              ),
              ElevatedButton(
                onPressed: rejectCall,
                child: Text('Reject'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

### 6. Backend API Changes (Jakarta EE)

**Required Endpoint Modifications:**

```java
@Path("/v1/calls")
public class CallResource {
    
    @POST
    @Path("/initiate")
    @Secured
    public Response initiateCall(@Valid CallInitiateRequest request, @Context UserPrincipal principal) {
        // 1. Generate unique channel ID on backend
        String channelId = generateChannelId(principal.getUserId(), request.getCalleeId());
        
        // 2. Create call record in database
        Call call = callService.createCall(
            request.getCalleeId(),
            request.getCallType(),
            channelId,
            principal.getUserId()
        );
        
        // 3. Send WebSocket invitation to callee
        webSocketService.sendToUser(request.getCalleeId(), new WebSocketMessage(
            "call_invitation",
            Map.of(
                "callId", call.getId(),
                "channelId", channelId,
                "callerId", principal.getUserId(),
                "callerName", principal.getName(),
                "callType", request.getCallType()
            )
        ));
        
        // 4. Return call data with channel ID
        return Response.status(201).entity(ApiResponse.success(
            "Call initiated",
            CallMapper.toDTO(call)
        )).build();
    }
    
    private String generateChannelId(String callerId, String calleeId) {
        // Ensure deterministic channel ID for same pair of users
        long timestamp = System.currentTimeMillis();
        return String.format("channel_%d_%s_%s", timestamp, callerId, calleeId);
    }
}
```

## Data Models

### CallEntity (Domain)

```dart
@freezed
class CallEntity with _$CallEntity {
  const factory CallEntity({
    required String callId,
    required String channelId, // Critical: must be consistent between caller/callee
    required String callerId,
    required String calleeId,
    required CallType callType,
    required CallStatus status,
    String? callerName,
    String? callerAvatar,
    String? calleeName,
    String? calleeAvatar,
    DateTime? startTime,
    DateTime? endTime,
    @Default(false) bool isLocalAudioMuted,
    @Default(false) bool isLocalVideoMuted,
    @Default(CameraFacing.front) CameraFacing cameraFacing,
    int? localUid,
    int? remoteUid,
  }) = _CallEntity;
}

enum CallType { audio, video }
enum CallStatus { ringing, active, ended, rejected, timeout }
enum CameraFacing { front, rear }
```

### CallInvitation (Signaling)

```dart
class CallInvitation {
  final String callId;
  final String channelId; // Must match backend-generated ID
  final String callerId;
  final String callerName;
  final String? callerAvatar;
  final CallType callType;
  final DateTime timestamp;

  CallInvitation({
    required this.callId,
    required this.channelId,
    required this.callerId,
    required this.callerName,
    this.callerAvatar,
    required this.callType,
    required this.timestamp,
  });

  factory CallInvitation.fromJson(Map<String, dynamic> json) {
    return CallInvitation(
      callId: json['callId'] as String,
      channelId: json['channelId'] as String, // Parse from WebSocket message
      callerId: json['callerId'] as String,
      callerName: json['callerName'] as String,
      callerAvatar: json['callerAvatar'] as String?,
      callType: json['callType'] == 'VIDEO' ? CallType.video : CallType.audio,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}
```

### WebSocket Message Format

**Client → Server: Call Invitation**
```json
{
  "type": "call.invitation",
  "payload": {
    "callId": "call_1234567890_abc123",
    "channelId": "channel_1234567890_user1_user2",
    "callerId": "user1",
    "callerName": "John Doe",
    "recipientId": "user2",
    "callType": "VIDEO",
    "timestamp": "2024-01-15T10:30:00Z"
  }
}
```

**Server → Client: Call Invitation**
```json
{
  "type": "call_invitation",
  "data": {
    "callId": "call_1234567890_abc123",
    "channelId": "channel_1234567890_user1_user2",
    "callerId": "user1",
    "callerName": "John Doe",
    "callerAvatar": "https://...",
    "callType": "VIDEO"
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

**Client → Server: Call Accept**
```json
{
  "type": "call.accept",
  "payload": {
    "callId": "call_1234567890_abc123"
  }
}
```

**Server → Client: Call Accepted**
```json
{
  "type": "call_accepted",
  "data": {
    "callId": "call_1234567890_abc123",
    "acceptedBy": "user2"
  },
  "timestamp": "2024-01-15T10:30:05Z"
}
```

**Client → Server: Call Reject**
```json
{
  "type": "call.reject",
  "payload": {
    "callId": "call_1234567890_abc123",
    "reason": "busy"
  }
}
```

**Client → Server: Call End**
```json
{
  "type": "call.end",
  "payload": {
    "callId": "call_1234567890_abc123",
    "durationSeconds": 120
  }
}
```

## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system—essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*

### Pr
operty Reflection

Before defining properties, let's identify and eliminate redundancy:

**Redundancy Analysis:**
- Properties 1.1 and 8.3 both test WebSocket message sending - can be combined
- Properties 3.4 and 6.3 both test channel ID consistency - can be combined
- Properties 4.1, 5.1, and 9.1 all test WebSocket message sending for different actions - can be generalized
- Properties 10.1, 10.2, 10.3, 10.4 all test logging - can be combined into one comprehensive logging property

**Consolidated Properties:**
After reflection, we'll focus on unique, high-value properties that provide distinct validation.

### Core Correctness Properties

Property 1: WebSocket invitation delivery
*For any* call initiation with valid parameters, the Call System should send a call_invitation WebSocket message containing the call ID, channel ID, caller information, and call type
**Validates: Requirements 1.1, 8.3**

Property 2: Call invitation parsing completeness
*For any* valid call_invitation WebSocket message, the Call System should successfully parse and extract all required fields (callId, channelId, callerId, callerName, callType) into a CallInvitation object
**Validates: Requirements 1.3**

Property 3: Caller information display
*For any* received call_invitation message, the incoming call UI should display the caller's name, avatar (if present), and call type from the invitation data
**Validates: Requirements 2.1**

Property 4: Busy call rejection
*For any* incoming call invitation received while a call is already active, the Call System should automatically send a call.reject message with reason "busy" without user interaction
**Validates: Requirements 2.3**

Property 5: Channel ID format validation
*For any* backend-generated channel ID, it should match the format pattern `channel_{timestamp}_{userId1}_{userId2}` where timestamp is numeric and userIds are non-empty strings
**Validates: Requirements 3.1**

Property 6: Channel ID consistency across participants
*For any* call acceptance, the channel ID used to join the Agora channel should exactly match the channel ID from the received call_invitation message
**Validates: Requirements 3.4, 4.4, 6.3**

Property 7: Accept message transmission
*For any* call acceptance action, the Call System should send a call.accept WebSocket message containing the correct call ID
**Validates: Requirements 4.1**

Property 8: Reject message transmission with reason
*For any* call rejection action, the Call System should send a call.reject WebSocket message containing the call ID and a rejection reason
**Validates: Requirements 5.1**

Property 9: No Agora join on rejection
*For any* call rejection, the Call System should not attempt to join an Agora channel or request an Agora token
**Validates: Requirements 5.5**

Property 10: End call message transmission
*For any* active call termination, the Call System should send a call.end WebSocket message containing the call ID and call duration
**Validates: Requirements 9.1**

Property 11: WebSocket message filtering
*For any* WebSocket message received, the Call System should process only messages with call-related types (call_invitation, call_accepted, call_rejected, call_ended, call_timeout) and ignore all other message types
**Validates: Requirements 8.4**

Property 12: Agora independence from WebSocket
*For any* active call, if the WebSocket connection is lost, the Agora RTC connection should remain active and media streaming should continue uninterrupted
**Validates: Requirements 7.4**

Property 13: Incoming call prioritization
*For any* scenario where a user is initiating a call and simultaneously receives an incoming call invitation, the Call System should cancel the outgoing call and prioritize displaying the incoming call
**Validates: Requirements 11.4**

Property 14: Comprehensive logging
*For any* call signaling operation (send invitation, receive message, join channel, error), the Call System should log the operation with relevant details (IDs, types, error messages) using the CallLogger utility
**Validates: Requirements 10.1, 10.2, 10.3, 10.4**

Property 15: Error handling with Failure type
*For any* failed asynchronous call operation (WebSocket send failure, API error, token request failure), the Call System should return an Either<Failure, T> with appropriate Failure details rather than throwing unhandled exceptions
**Validates: Requirements 15.1, 15.2, 15.4**

## Error Handling

### Error Categories

**1. WebSocket Connection Errors**
- **Cause**: WebSocket not connected when initiating call
- **Handling**: Throw `WebSocketNotConnectedException`, display error dialog, prevent call initiation
- **Recovery**: Prompt user to check connection, retry after reconnection

**2. Channel ID Mismatch Errors**
- **Cause**: Callee uses different channel ID than caller
- **Handling**: Log error with both channel IDs, prevent Agora join, display "Call connection failed"
- **Recovery**: End call, notify both participants

**3. Token Request Failures**
- **Cause**: Backend API error when requesting Agora token
- **Handling**: Return `Failure.server`, display error message, don't join channel
- **Recovery**: Retry token request up to 3 times, then end call

**4. Message Parsing Errors**
- **Cause**: Malformed WebSocket message
- **Handling**: Log error with raw message, ignore message, don't crash
- **Recovery**: Continue listening for valid messages

**5. Agora Join Failures**
- **Cause**: Invalid token, network issues, Agora SDK errors
- **Handling**: Return `Failure.channelJoin`, display error with retry option
- **Recovery**: Allow user to retry, or end call

**6. Race Condition Errors**
- **Cause**: Both users call each other simultaneously
- **Handling**: Backend rejects second call, client receives `call_rejected` with reason "already_in_call"
- **Recovery**: Display notification, allow user to accept incoming call

### Error Handling Flow

```dart
// Example: Call initiation with error handling
Future<void> initiateCall({...}) async {
  try {
    // 1. Validate WebSocket connection
    if (!_signalingService.isConnected) {
      state = AsyncValue.error(
        WebSocketNotConnectedException('Cannot initiate call: WebSocket not connected'),
        StackTrace.current,
      );
      return;
    }

    // 2. Create call via API
    final result = await repository.createCall(...);
    
    await result.fold(
      (failure) async {
        // Handle API failure
        CallLogger.logError('Failed to create call', error: failure);
        state = AsyncValue.error(_mapFailureToException(failure), StackTrace.current);
      },
      (call) async {
        try {
          // 3. Send WebSocket invitation
          _signalingService.sendCallInvitation(...);
          
          // 4. Update state
          state = AsyncValue.data(call);
          
          CallLogger.logInfo('Call initiated successfully: ${call.callId}');
        } catch (e, st) {
          // Handle WebSocket send failure
          CallLogger.logError('Failed to send call invitation', error: e, stackTrace: st);
          
          // Cleanup: end the call on backend
          await repository.endCall(call.callId);
          
          state = AsyncValue.error(e, st);
        }
      },
    );
  } catch (e, st) {
    CallLogger.logError('Unexpected error during call initiation', error: e, stackTrace: st);
    state = AsyncValue.error(e, st);
  }
}
```

### Failure Types

```dart
sealed class Failure {
  const Failure();
  
  // WebSocket failures
  const factory Failure.webSocketNotConnected(String message) = WebSocketNotConnectedFailure;
  const factory Failure.webSocketSendFailed(String message) = WebSocketSendFailure;
  
  // API failures
  const factory Failure.server(String message, String? errorCode) = ServerFailure;
  const factory Failure.network(String message) = NetworkFailure;
  const factory Failure.unauthorized(String message, String? errorCode) = UnauthorizedFailure;
  
  // Call-specific failures
  const factory Failure.channelIdMismatch(String expected, String actual) = ChannelIdMismatchFailure;
  const factory Failure.callNotFound(String callId) = CallNotFoundFailure;
  const factory Failure.callAlreadyActive(String callId) = CallAlreadyActiveFailure;
  
  // Agora failures
  const factory Failure.tokenExpired(String message) = TokenExpiredFailure;
  const factory Failure.channelJoin(String message) = ChannelJoinFailure;
  const factory Failure.agoraEngine(String message, int? code) = AgoraEngineFailure;
}
```

## Testing Strategy

### Unit Testing

**Focus Areas:**
1. **Message Parsing**: Test CallInvitation.fromJson() with various valid and invalid inputs
2. **Channel ID Generation**: Test format validation and uniqueness
3. **State Transitions**: Test CallStateProvider state changes for each action
4. **Error Mapping**: Test Failure to Exception mapping

**Example Unit Tests:**
```dart
group('CallInvitation parsing', () {
  test('should parse valid invitation message', () {
    final json = {
      'callId': 'call_123',
      'channelId': 'channel_456',
      'callerId': 'user1',
      'callerName': 'John',
      'callType': 'VIDEO',
      'timestamp': '2024-01-15T10:30:00Z',
    };
    
    final invitation = CallInvitation.fromJson(json);
    
    expect(invitation.callId, 'call_123');
    expect(invitation.channelId, 'channel_456');
    expect(invitation.callType, CallType.video);
  });
  
  test('should throw on missing required fields', () {
    final json = {'callId': 'call_123'}; // Missing other fields
    
    expect(() => CallInvitation.fromJson(json), throwsA(isA<TypeError>()));
  });
});

group('Channel ID validation', () {
  test('should match expected format', () {
    final channelId = 'channel_1234567890_user1_user2';
    final regex = RegExp(r'^channel_\d+_\w+_\w+$');
    
    expect(regex.hasMatch(channelId), isTrue);
  });
});
```

### Property-Based Testing

**Framework**: Use `dart_check` or `fast_check` for property-based testing

**Property Test Configuration:**
- Minimum 100 iterations per property
- Use custom generators for CallInvitation, CallEntity, channel IDs
- Tag each test with property number from design doc

**Example Property Tests:**

```dart
import 'package:dart_check/dart_check.dart';

group('Property 1: WebSocket invitation delivery', () {
  propertyTest(
    'should send WebSocket message for any valid call initiation',
    forAll: (
      arbitrary.string.map((s) => 'user_$s'), // calleeId
      arbitrary.element([CallType.audio, CallType.video]), // callType
    ),
    property: (calleeId, callType) async {
      // **Feature: fix-call-signaling-and-channel-sync, Property 1: WebSocket invitation delivery**
      
      final mockSignaling = MockCallSignalingService();
      final provider = CallStateProvider(signalingService: mockSignaling);
      
      await provider.initiateCall(
        remoteUserId: calleeId,
        callType: callType,
        callerId: 'test_caller',
        callerName: 'Test Caller',
      );
      
      // Verify sendCallInvitation was called
      verify(mockSignaling.sendCallInvitation(
        callId: any,
        channelId: any,
        callerId: 'test_caller',
        callerName: 'Test Caller',
        recipientId: calleeId,
        callType: callType,
      )).called(1);
    },
    minSuccessfulTests: 100,
  );
});

group('Property 6: Channel ID consistency', () {
  propertyTest(
    'should use invitation channel ID when accepting call',
    forAll: (
      arbitrary.string.map((s) => 'channel_$s'), // channelId
      arbitrary.string.map((s) => 'call_$s'), // callId
    ),
    property: (channelId, callId) async {
      // **Feature: fix-call-signaling-and-channel-sync, Property 6: Channel ID consistency across participants**
      
      final invitation = CallInvitation(
        callId: callId,
        channelId: channelId,
        callerId: 'caller1',
        callerName: 'Caller',
        callType: CallType.video,
        timestamp: DateTime.now(),
      );
      
      final mockRepository = MockCallRepository();
      final provider = CallStateProvider(repository: mockRepository);
      
      await provider.acceptCall(
        callId: invitation.callId,
        channelId: invitation.channelId,
        remoteUserId: invitation.callerId,
        callType: invitation.callType,
      );
      
      // Verify joinCall was called with invitation's channel ID
      verify(mockRepository.joinCall(
        callId: callId,
        channelId: channelId, // Must match invitation
        remoteUserId: any,
        callType: any,
      )).called(1);
    },
    minSuccessfulTests: 100,
  );
});

group('Property 11: WebSocket message filtering', () {
  propertyTest(
    'should process only call-related messages',
    forAll: (
      arbitrary.element([
        'call_invitation',
        'call_accepted',
        'call_rejected',
        'call_ended',
        'call_timeout',
        'chat.message', // Non-call message
        'user.status', // Non-call message
        'random_type', // Non-call message
      ]),
    ),
    property: (messageType) {
      // **Feature: fix-call-signaling-and-channel-sync, Property 11: WebSocket message filtering**
      
      final service = CallSignalingService(webSocketService: mockWebSocket);
      final message = {'type': messageType, 'payload': {}};
      
      final isCallMessage = [
        'call_invitation',
        'call_accepted',
        'call_rejected',
        'call_ended',
        'call_timeout',
      ].contains(messageType);
      
      service.handleIncomingMessage(message);
      
      // Verify processing based on message type
      if (isCallMessage) {
        // Should be processed (stream should emit)
        expect(service.hasProcessedMessage, isTrue);
      } else {
        // Should be ignored
        expect(service.hasProcessedMessage, isFalse);
      }
    },
    minSuccessfulTests: 100,
  );
});
```

### Integration Testing

**Scenarios to Test:**
1. **Full call flow**: Initiate → Invite → Accept → Join → End
2. **Rejection flow**: Initiate → Invite → Reject
3. **Timeout flow**: Initiate → Invite → Timeout (no response)
4. **Race condition**: Both users call simultaneously
5. **WebSocket reconnection**: Disconnect during call, reconnect, verify signaling resumes
6. **Token refresh**: Long call that requires token renewal

**Example Integration Test:**
```dart
testWidgets('Full call flow with channel synchronization', (tester) async {
  // Setup
  final mockBackend = MockBackendAPI();
  final mockWebSocket = MockWebSocketService();
  final mockAgora = MockAgoraService();
  
  // 1. Caller initiates call
  await tester.tap(find.byKey(Key('call_button')));
  await tester.pumpAndSettle();
  
  // Verify REST API called
  verify(mockBackend.createCall(any)).called(1);
  
  // Verify WebSocket invitation sent
  verify(mockWebSocket.sendMessage(argThat(
    predicate((msg) => msg['type'] == 'call.invitation'),
  ))).called(1);
  
  // 2. Simulate callee receiving invitation
  final channelId = 'channel_123_user1_user2';
  mockWebSocket.simulateMessage({
    'type': 'call_invitation',
    'data': {
      'callId': 'call_123',
      'channelId': channelId,
      'callerId': 'user1',
      'callerName': 'John',
      'callType': 'VIDEO',
    },
  });
  
  await tester.pumpAndSettle();
  
  // Verify incoming call screen displayed
  expect(find.text('John is calling...'), findsOneWidget);
  
  // 3. Callee accepts
  await tester.tap(find.text('Accept'));
  await tester.pumpAndSettle();
  
  // Verify WebSocket accept sent
  verify(mockWebSocket.sendMessage(argThat(
    predicate((msg) => msg['type'] == 'call.accept'),
  ))).called(1);
  
  // Verify Agora join with correct channel ID
  verify(mockAgora.joinChannel(
    channelId: channelId, // Must match invitation
    token: any,
    uid: any,
  )).called(1);
  
  // 4. Simulate caller receiving acceptance
  mockWebSocket.simulateMessage({
    'type': 'call_accepted',
    'data': {'callId': 'call_123', 'acceptedBy': 'user2'},
  });
  
  await tester.pumpAndSettle();
  
  // Verify caller also joins with same channel ID
  verify(mockAgora.joinChannel(
    channelId: channelId, // Must match
    token: any,
    uid: any,
  )).called(2); // Both participants joined
});
```

### Manual Testing Checklist

- [ ] Initiate video call, verify callee receives invitation within 1 second
- [ ] Initiate audio call, verify callee receives invitation within 1 second
- [ ] Accept call, verify both users see each other's video/hear audio
- [ ] Reject call, verify caller sees rejection notification
- [ ] End call from caller side, verify callee's call ends
- [ ] End call from callee side, verify caller's call ends
- [ ] Receive call while in another call, verify auto-rejection with "busy"
- [ ] Initiate call without internet, verify error message
- [ ] Lose internet during call, verify Agora continues, WebSocket reconnects
- [ ] Both users call each other simultaneously, verify only one call succeeds
- [ ] Let call ring for 60 seconds, verify timeout on both sides
- [ ] Check logs for all operations (initiate, accept, reject, end, errors)

## Performance Considerations

### Latency Targets

- **Call invitation delivery**: < 500ms from initiation to callee notification
- **Accept response**: < 300ms from accept tap to Agora join
- **WebSocket message processing**: < 50ms per message
- **UI state updates**: < 16ms (60 FPS) for smooth animations

### Optimization Strategies

1. **Parallel Operations**: Request Agora token while displaying waiting screen
2. **Preload Resources**: Initialize Agora engine on app start, not on first call
3. **Message Batching**: If multiple signaling messages arrive, process in batch
4. **Lazy Loading**: Load call history only when user navigates to history screen
5. **Connection Pooling**: Reuse WebSocket connection, don't create new for each call

### Resource Management

```dart
// Proper cleanup on call end
Future<void> _cleanupCall() async {
  // 1. Leave Agora channel
  await _agoraService.leaveChannel();
  
  // 2. Release Agora resources
  await _agoraService.dispose();
  
  // 3. Cancel timers
  _callTimeout?.cancel();
  _tokenRefreshTimer?.cancel();
  
  // 4. Clear state
  state = AsyncValue.data(null);
  
  // 5. Log cleanup
  CallLogger.logInfo('Call cleanup completed');
}
```

## Security Considerations

### Token Security

- **Never log full tokens**: Only log first 20 characters
- **Token expiration**: Tokens expire after 1 hour, must refresh
- **Token validation**: Backend validates token before issuing
- **Secure storage**: Store tokens in memory only, not persistent storage

### WebSocket Security

- **Authentication**: WebSocket connection requires valid JWT
- **Message validation**: Validate all incoming messages before processing
- **Rate limiting**: Backend limits signaling messages per user
- **Encryption**: Use WSS (WebSocket Secure) for all connections

### Privacy

- **Call metadata**: Store minimal call metadata (duration, participants, timestamp)
- **No recording**: Client does not record audio/video by default
- **Consent**: Display indicator when call is active
- **Data retention**: Delete call history after 30 days

## Deployment Considerations

### Backend Changes Required

1. **Channel ID generation**: Backend must generate and return channel ID in `/v1/calls/initiate` response
2. **WebSocket routing**: Backend must route `call_invitation` messages to correct user
3. **Race condition handling**: Backend must detect and handle simultaneous calls
4. **Timeout management**: Backend must implement 60-second call timeout

### Client Changes Required

1. **Inject CallSignalingService**: Add to CallStateProvider dependencies
2. **Send WebSocket invitation**: After REST API call creation
3. **Use backend channel ID**: Extract from API response, don't generate locally
4. **Update IncomingCallProvider**: Listen to signaling service stream
5. **Fix IncomingCallScreen**: Use invitation's channel ID for acceptance

### Migration Strategy

1. **Phase 1**: Deploy backend changes (channel ID generation, WebSocket routing)
2. **Phase 2**: Deploy client changes (WebSocket integration, channel ID usage)
3. **Phase 3**: Monitor logs for channel ID mismatches, fix any edge cases
4. **Phase 4**: Enable race condition detection on backend
5. **Phase 5**: Full rollout to all users

### Rollback Plan

If issues occur:
1. **Immediate**: Disable call feature via feature flag
2. **Short-term**: Revert client to previous version
3. **Investigation**: Analyze logs to identify root cause
4. **Fix**: Apply hotfix for specific issue
5. **Gradual rollout**: Re-enable for 10% → 50% → 100% of users

## Monitoring and Observability

### Metrics to Track

- **Call initiation success rate**: % of calls that successfully send invitation
- **Call acceptance rate**: % of invitations that are accepted
- **Channel join success rate**: % of acceptances that successfully join Agora
- **WebSocket message delivery time**: P50, P95, P99 latencies
- **Call duration**: Average and distribution
- **Error rates**: By error type (WebSocket, token, Agora, etc.)

### Logging Strategy

```dart
// Structured logging with context
CallLogger.logInfo('Call initiated', context: {
  'callId': callId,
  'channelId': channelId,
  'calleeId': calleeId,
  'callType': callType.toString(),
});

CallLogger.logError('Channel join failed', context: {
  'callId': callId,
  'channelId': channelId,
  'errorCode': errorCode,
  'errorMessage': errorMessage,
}, stackTrace: stackTrace);
```

### Alerts

- **High error rate**: > 5% of calls failing
- **High latency**: P95 invitation delivery > 2 seconds
- **WebSocket disconnections**: > 10% of users experiencing disconnections
- **Channel ID mismatches**: Any occurrence (should be zero)

## Conclusion

This design provides a comprehensive solution to fix the call signaling and channel synchronization issues in Chattrix UI. The key changes are:

1. **Integrate WebSocket signaling** into the call initiation flow
2. **Use backend-generated channel IDs** to ensure consistency
3. **Properly connect IncomingCallProvider** to CallSignalingService
4. **Add robust error handling** for all failure scenarios
5. **Implement comprehensive testing** with unit, property, and integration tests

By following this design, we ensure that:
- Call invitations are reliably delivered to recipients
- Caller and callee always join the same Agora channel
- Race conditions are handled gracefully
- Errors are properly logged and displayed to users
- The system is testable, maintainable, and scalable
