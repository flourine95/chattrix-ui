# Design Document

## Overview

This document outlines the design for implementing audio and video calling functionality in the Chattrix UI application. The feature integrates the Agora RTC Engine SDK with the Chattrix backend API to provide real-time voice and video communication between users.

The implementation follows Clean Architecture principles with clear separation between Domain, Data, and Presentation layers. The feature will be implemented as a new module (`agora_call`) separate from the existing call feature to avoid conflicts.

### Key Technologies

- **Agora RTC Engine SDK** (v6.3.2): Real-time audio/video streaming
- **Riverpod v3**: State management with code generation
- **Dio**: HTTP client for REST API calls
- **WebSocket**: Real-time signaling for call events
- **Flutter Hooks**: Lifecycle management in UI components
- **Dartz**: Functional error handling with Either type
- **Freezed**: Immutable data classes

## Architecture

### Layer Structure

```
lib/features/agora_call/
├── domain/              # Business entities and contracts (framework-agnostic)
│   ├── entities/        # Core business objects
│   ├── repositories/    # Repository interfaces
│   └── failures/        # Domain-specific failures
├── data/                # Implementation details
│   ├── models/          # DTOs with JSON serialization
│   ├── datasources/     # API and local data sources
│   ├── repositories/    # Repository implementations
│   └── services/        # Agora SDK wrapper and utilities
└── presentation/        # UI layer
    ├── providers/       # Riverpod state management
    ├── pages/           # Screen widgets
    └── widgets/         # Reusable UI components
```

### Data Flow

```
User Action (UI)
    ↓
Provider (Riverpod)
    ↓
Repository (Domain Interface)
    ↓
Repository Implementation (Data Layer)
    ↓
Data Source (API/Local/Agora SDK)
    ↓
Backend API / Agora Cloud
```

### WebSocket Event Flow

```
Backend WebSocket
    ↓
ChatWebSocketService (rawMessageStream)
    ↓
CallEventListener (filters call.* events)
    ↓
CallStateNotifier (updates call state)
    ↓
UI (reacts to state changes)
```

## Components and Interfaces

### Domain Layer

#### Entities

**CallEntity** - Core call information (framework-agnostic)
```dart
@freezed
class CallEntity with _$CallEntity {
  const factory CallEntity({
    required String id,
    required String channelId,
    required CallStatus status,
    required CallType callType,
    required int callerId,
    required String callerName,
    String? callerAvatar,
    required int calleeId,
    required String calleeName,
    String? calleeAvatar,
    required DateTime createdAt,
    int? durationSeconds,
  }) = _CallEntity;
}

enum CallStatus {
  initiating,
  ringing,
  connecting,
  connected,
  rejected,
  ended,
}

enum CallType {
  audio,
  video,
}
```

**CallConnectionEntity** - Connection credentials
```dart
@freezed
class CallConnectionEntity with _$CallEntity {
  const factory CallConnectionEntity({
    required CallEntity call,
    required String token,  // Agora token
  }) = _CallConnectionEntity;
}
```

**CallInvitationEntity** - Incoming call invitation
```dart
@freezed
class CallInvitationEntity with _$CallInvitationEntity {
  const factory CallInvitationEntity({
    required String callId,
    required String channelId,
    required int callerId,
    required String callerName,
    String? callerAvatar,
    required CallType callType,
  }) = _CallInvitationEntity;
}
```

#### Failures

```dart
@freezed
class CallFailure with _$CallFailure {
  const factory CallFailure.serverError(String message) = ServerError;
  const factory CallFailure.networkError() = NetworkError;
  const factory CallFailure.userBusy() = UserBusy;
  const factory CallFailure.callNotFound() = CallNotFound;
  const factory CallFailure.permissionDenied(String permission) = PermissionDenied;
  const factory CallFailure.agoraError(String message) = AgoraError;
  const factory CallFailure.unauthorized() = Unauthorized;
}
```

#### Repository Interface

```dart
abstract class AgoraCallRepository {
  Future<Either<CallFailure, CallConnectionEntity>> initiateCall({
    required int calleeId,
    required CallType callType,
  });
  
  Future<Either<CallFailure, CallConnectionEntity>> acceptCall({
    required String callId,
  });
  
  Future<Either<CallFailure, CallEntity>> rejectCall({
    required String callId,
    required String reason,
  });
  
  Future<Either<CallFailure, CallEntity>> endCall({
    required String callId,
    String reason = 'hangup',
  });
}
```

### Data Layer

#### Models

**CallModel** - DTO with JSON serialization
```dart
@freezed
class CallModel with _$CallModel {
  const factory CallModel({
    required String id,
    required String channelId,
    required String status,
    required String callType,
    required int callerId,
    required String callerName,
    String? callerAvatar,
    required int calleeId,
    required String calleeName,
    String? calleeAvatar,
    required String createdAt,
    int? durationSeconds,
  }) = _CallModel;
  
  factory CallModel.fromJson(Map<String, dynamic> json) => _$CallModelFromJson(json);
}

extension CallModelX on CallModel {
  CallEntity toEntity() {
    return CallEntity(
      id: id,
      channelId: channelId,
      status: _parseStatus(status),
      callType: _parseCallType(callType),
      callerId: callerId,
      callerName: callerName,
      callerAvatar: callerAvatar,
      calleeId: calleeId,
      calleeName: calleeName,
      calleeAvatar: calleeAvatar,
      createdAt: DateTime.parse(createdAt),
      durationSeconds: durationSeconds,
    );
  }
}
```

#### Data Sources

**AgoraCallRemoteDataSource** - API communication
```dart
class AgoraCallRemoteDataSource {
  final Dio _dio;
  
  Future<CallConnectionModel> initiateCall({
    required int calleeId,
    required String callType,
  });
  
  Future<CallConnectionModel> acceptCall(String callId);
  
  Future<CallModel> rejectCall({
    required String callId,
    required String reason,
  });
  
  Future<CallModel> endCall({
    required String callId,
    required String reason,
  });
}
```

**AgoraEngineService** - Agora SDK wrapper
```dart
class AgoraEngineService {
  RtcEngine? _engine;
  
  Future<void> initialize(String appId);
  
  Future<void> joinChannel({
    required String token,
    required String channelId,
    required int uid,
    required bool isVideo,
  });
  
  Future<void> leaveChannel();
  
  Future<void> muteLocalAudio(bool mute);
  
  Future<void> muteLocalVideo(bool mute);
  
  Future<void> switchCamera();
  
  void registerEventHandlers({
    required Function(RtcConnection, int, int) onUserJoined,
    required Function(RtcConnection, int, UserOfflineReasonType) onUserOffline,
    required Function(RtcConnection, NetworkQuality, NetworkQuality) onNetworkQuality,
    required Function(RtcConnection, ErrorCodeType, String) onError,
  });
  
  Future<void> dispose();
}
```

#### Repository Implementation

```dart
class AgoraCallRepositoryImpl implements AgoraCallRepository {
  final AgoraCallRemoteDataSource _remoteDataSource;
  
  @override
  Future<Either<CallFailure, CallConnectionEntity>> initiateCall({
    required int calleeId,
    required CallType callType,
  }) async {
    try {
      final result = await _remoteDataSource.initiateCall(
        calleeId: calleeId,
        callType: callType.name.toUpperCase(),
      );
      return Right(result.toEntity());
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(CallFailure.serverError(e.toString()));
    }
  }
  
  // Similar implementations for other methods...
}
```

### Presentation Layer

#### Providers

**callStateProvider** - Main call state management
```dart
@riverpod
class CallState extends _$CallState {
  @override
  AsyncValue<CallEntity?> build() {
    _listenToCallEvents();
    return const AsyncValue.data(null);
  }
  
  Future<void> initiateCall({
    required int calleeId,
    required CallType callType,
  }) async {
    // Implementation
  }
  
  Future<void> acceptCall(String callId) async {
    // Implementation
  }
  
  Future<void> rejectCall({
    required String callId,
    required String reason,
  }) async {
    // Implementation
  }
  
  Future<void> endCall(String callId) async {
    // Implementation
  }
  
  void _listenToCallEvents() {
    // Listen to WebSocket events
  }
}
```

**agoraEngineProvider** - Agora engine instance
```dart
@riverpod
AgoraEngineService agoraEngine(AgoraEngineRef ref) {
  final service = AgoraEngineService();
  ref.onDispose(() => service.dispose());
  return service;
}
```

**callControlsProvider** - UI controls state
```dart
@riverpod
class CallControls extends _$CallControls {
  @override
  CallControlsState build() {
    return const CallControlsState(
      isMuted: false,
      isVideoEnabled: true,
      isSpeakerOn: true,
    );
  }
  
  void toggleMute();
  void toggleVideo();
  void toggleSpeaker();
  void switchCamera();
}
```

#### Pages

**OutgoingCallScreen** - Displayed when initiating a call
- Shows callee information
- Displays "Calling..." or "Ringing..." status
- Provides cancel button
- Listens for call.accepted, call.rejected, call.timeout events

**IncomingCallScreen** - Displayed when receiving a call
- Shows caller information
- Plays ringtone
- Provides accept/reject buttons
- Auto-dismisses on timeout

**ActiveCallScreen** - Displayed during an active call
- Shows remote video (for video calls)
- Shows local video preview (for video calls)
- Displays call duration timer
- Provides call controls (mute, video, speaker, camera switch, end)
- Shows network quality indicator
- Handles call.ended event

## Data Models

### API Request/Response Models

**InitiateCallRequest**
```json
{
  "calleeId": 123,
  "callType": "AUDIO" | "VIDEO"
}
```

**CallConnectionResponse**
```json
{
  "success": true,
  "message": "Call initiated successfully",
  "data": {
    "id": "uuid",
    "channelId": "channel_123",
    "status": "RINGING",
    "callType": "VIDEO",
    "callerId": 1,
    "callerName": "John Doe",
    "callerAvatar": "https://...",
    "calleeId": 2,
    "calleeName": "Jane Smith",
    "calleeAvatar": "https://...",
    "createdAt": "2024-01-01T00:00:00Z",
    "durationSeconds": null,
    "token": "agora_token_here"
  }
}
```

**RejectCallRequest**
```json
{
  "reason": "busy" | "declined" | "unavailable"
}
```

**EndCallRequest**
```json
{
  "reason": "hangup" | "network error" | "device error" | "timeout"
}
```

### WebSocket Event Models

**call.incoming**
```json
{
  "type": "call.incoming",
  "data": {
    "callId": "uuid",
    "channelId": "channel_123",
    "callerId": 1,
    "callerName": "John Doe",
    "callerAvatar": "https://...",
    "callType": "VIDEO"
  }
}
```

**call.accepted**
```json
{
  "type": "call.accepted",
  "data": {
    "callId": "uuid",
    "acceptedBy": 2
  }
}
```

**call.rejected**
```json
{
  "type": "call.rejected",
  "data": {
    "callId": "uuid",
    "rejectedBy": 2,
    "reason": "busy"
  }
}
```

**call.ended**
```json
{
  "type": "call.ended",
  "data": {
    "callId": "uuid",
    "endedBy": 1,
    "durationSeconds": 120
  }
}
```

**call.timeout**
```json
{
  "type": "call.timeout",
  "data": {
    "callId": "uuid",
    "reason": "no_answer"
  }
}
```

**call.quality_warning**
```json
{
  "type": "call.quality_warning",
  "data": {
    "callId": "uuid",
    "userId": 1,
    "message": "Poor network quality"
  }
}
```

## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system—essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*


### Property Reflection

After reviewing all testable properties from the prework analysis, the following redundancies and consolidations have been identified:

**Redundancies to eliminate:**
- Properties 1.1 and 1.2 can be combined into a single property testing call initiation for both audio and video types
- Properties 3.3 and 1.4 are essentially the same (joining Agora channel with credentials) - can be consolidated
- Properties 3.5 and 4.3 both test ringtone stopping - can be combined into one property
- Properties 5.3, 5.4, and 5.5 are all UI structure tests that can be verified together as examples rather than separate properties

**Properties to consolidate:**
- Call initiation properties (1.1, 1.2) → Single property for initiating calls with any call type
- Agora channel joining properties (1.4, 3.3) → Single property for joining with credentials
- Ringtone stopping properties (3.5, 4.3) → Single property for ringtone lifecycle
- UI control properties (5.3, 5.4, 5.5) → Single example test for control availability

This reflection ensures each property provides unique validation value without logical redundancy.

### Correctness Properties

Property 1: Call initiation sends correct request
*For any* call type (AUDIO or VIDEO) and any callee ID, when initiating a call, the system should send an API request with the correct call type and callee ID
**Validates: Requirements 1.1, 1.2**

Property 2: Successful initiate response contains credentials
*For any* successful call initiation response, the response should contain a non-null call ID, channel ID, and Agora token
**Validates: Requirements 1.3**

Property 3: Agora channel join uses provided credentials
*For any* call connection credentials received, the system should invoke the Agora SDK join method with the exact token and channel ID from the credentials
**Validates: Requirements 1.4, 3.3**

Property 4: Call invitation parsing extracts all fields
*For any* call.incoming WebSocket event, the system should successfully extract all required fields (callId, channelId, callerId, callerName, callType) from the payload
**Validates: Requirements 2.1**

Property 5: Ringtone lifecycle follows call state
*For any* incoming call, the ringtone should start when the invitation is received and stop when the user accepts, rejects, or the call times out
**Validates: Requirements 2.4, 3.5, 4.3**

Property 6: Accept request includes call ID
*For any* call acceptance action, the system should send an API request containing the exact call ID from the invitation
**Validates: Requirements 3.1**

Property 7: Reject request includes call ID and reason
*For any* call rejection action, the system should send an API request containing both the call ID and a rejection reason
**Validates: Requirements 4.1**

Property 8: Rejection prevents Agora connection
*For any* rejected call, the system should not invoke the Agora SDK join method
**Validates: Requirements 4.4**

Property 9: End call triggers cleanup sequence
*For any* call end action, the system should execute the cleanup sequence: send end API request, leave Agora channel, and release media resources
**Validates: Requirements 6.1, 6.2, 6.3**

Property 10: WebSocket events trigger correct state transitions
*For any* call-related WebSocket event (accepted, rejected, ended, timeout), the system should transition to the appropriate call state
**Validates: Requirements 7.1, 7.2, 7.3, 7.4**

Property 11: Quality warnings don't terminate calls
*For any* call.quality_warning event during an active call, the call state should remain CONNECTED
**Validates: Requirements 8.4**

Property 12: Agora errors trigger user notification and cleanup
*For any* Agora SDK error during channel join, the system should both notify the user and send an end request to the backend
**Validates: Requirements 8.2**

Property 13: Authentication token included in all API requests
*For any* call-related API request (initiate, accept, reject, end), the request headers should include a valid JWT authentication token
**Validates: Requirements 10.1**

Property 14: Agora tokens are call-specific
*For any* two different calls, the Agora tokens used should be different
**Validates: Requirements 10.2**

Property 15: Call end clears sensitive data
*For any* call that ends, all call-related tokens should be cleared from memory
**Validates: Requirements 10.3**

Property 16: Secure protocols for all network communication
*For any* network request made by the call system, the URL scheme should be HTTPS for API calls or WSS for WebSocket connections
**Validates: Requirements 10.5**

## Error Handling

### Error Categories

**Network Errors**
- No internet connection
- Request timeout
- Server unreachable
- WebSocket disconnection

**API Errors**
- 400 Bad Request (invalid parameters, user busy)
- 401 Unauthorized (invalid/expired token)
- 404 Not Found (call not found)
- 500 Server Error

**Agora SDK Errors**
- Failed to initialize engine
- Failed to join channel
- Invalid token
- Network quality degradation
- Device permission denied

**Business Logic Errors**
- User already in a call
- Call already ended
- Invalid call state transition

### Error Handling Strategy

**Network Errors**
```dart
// Wrap all API calls with try-catch
try {
  final result = await _remoteDataSource.initiateCall(...);
  return Right(result.toEntity());
} on DioException catch (e) {
  if (e.type == DioExceptionType.connectionTimeout) {
    return Left(CallFailure.networkError());
  }
  // Handle other cases...
}
```

**API Errors**
```dart
// Map HTTP status codes to domain failures
CallFailure _handleDioError(DioException e) {
  if (e.response?.statusCode == 400) {
    final message = e.response?.data['message'] ?? 'Bad request';
    if (message.contains('busy')) {
      return CallFailure.userBusy();
    }
    return CallFailure.serverError(message);
  }
  if (e.response?.statusCode == 401) {
    return CallFailure.unauthorized();
  }
  if (e.response?.statusCode == 404) {
    return CallFailure.callNotFound();
  }
  return CallFailure.serverError('Unknown error');
}
```

**Agora SDK Errors**
```dart
// Register error handler with Agora engine
_engine.registerEventHandler(
  RtcEngineEventHandler(
    onError: (err, msg) {
      // Notify user
      _showError('Connection error: $msg');
      // Cleanup and end call
      endCall(currentCallId);
    },
  ),
);
```

**User Notifications**
- Display toast messages for transient errors
- Show dialog for critical errors requiring user action
- Display in-call banner for quality warnings
- Auto-dismiss notifications after timeout

**Cleanup on Errors**
- Always leave Agora channel on errors
- Always release media resources
- Always send end request to backend (if call was initiated)
- Always clear call state

## Testing Strategy

### Unit Testing

Unit tests will verify specific examples and edge cases for individual components:

**Repository Tests**
- Test successful API responses are correctly mapped to entities
- Test error responses are correctly mapped to failures
- Test network errors are handled gracefully

**Model Tests**
- Test JSON deserialization for all API response models
- Test entity conversion from models
- Test enum parsing (CallStatus, CallType)

**Service Tests**
- Test Agora engine initialization
- Test channel join with valid credentials
- Test media control methods (mute, video toggle, camera switch)

**Provider Tests**
- Test state transitions for call lifecycle
- Test WebSocket event handling
- Test error state management

**Edge Cases**
- Empty or null fields in API responses
- Malformed WebSocket messages
- Rapid successive call invitations
- Call events received in wrong order
- WebSocket disconnection during active call

### Property-Based Testing

Property-based tests will verify universal properties across all inputs using the **fast_check** equivalent for Dart. Since Dart doesn't have a mature PBT library, we'll use **test** package with custom generators.

**Configuration**
- Each property test will run a minimum of 100 iterations
- Use custom generators for entities (CallEntity, CallType, etc.)
- Use faker package for generating realistic test data

**Property Test Implementation Pattern**
```dart
test('Property: Call initiation sends correct request', () async {
  // Run 100 iterations with random data
  for (int i = 0; i < 100; i++) {
    final calleeId = faker.randomGenerator.integer(1000, min: 1);
    final callType = faker.randomGenerator.boolean() 
        ? CallType.audio 
        : CallType.video;
    
    // Test the property
    final result = await repository.initiateCall(
      calleeId: calleeId,
      callType: callType,
    );
    
    // Verify the request was made with correct parameters
    verify(mockDataSource.initiateCall(
      calleeId: calleeId,
      callType: callType.name.toUpperCase(),
    )).called(1);
  }
});
```

**Property Tests to Implement**
- Each correctness property listed above will have a corresponding property-based test
- Tests will be tagged with comments referencing the design property number
- Tests will generate random valid inputs and verify the property holds

### Integration Testing

Integration tests will verify end-to-end flows:

**Call Initiation Flow**
- User initiates call → API request → Agora join → UI update

**Call Reception Flow**
- WebSocket event → Parse invitation → Show UI → Play ringtone

**Call Acceptance Flow**
- User accepts → API request → Agora join → UI transition

**Call End Flow**
- User ends → API request → Agora leave → Resource cleanup → UI dismiss

### Widget Testing

Widget tests will verify UI components:

**Screen Tests**
- OutgoingCallScreen renders correctly
- IncomingCallScreen shows caller info
- ActiveCallScreen displays controls

**Widget Tests**
- Call controls respond to user input
- Video views display correctly
- Network quality indicator updates

**Navigation Tests**
- Correct screen transitions
- Back button handling
- Screen dismissal on call end

### Manual Testing Checklist

Since automated testing has limitations for real-time communication:

**Audio Call Testing**
- Initiate audio call and verify connection
- Accept incoming audio call
- Test microphone mute/unmute
- Test speaker toggle
- Verify call duration timer
- End call from both sides

**Video Call Testing**
- Initiate video call and verify video streams
- Accept incoming video call
- Test camera enable/disable
- Test camera switching
- Test video quality in different network conditions
- End call from both sides

**Error Scenarios**
- Reject incoming call
- Call timeout (no answer)
- Network disconnection during call
- Permission denied for camera/microphone
- User busy (already in call)

**Edge Cases**
- Multiple rapid call attempts
- WebSocket reconnection during call
- App backgrounding during call
- Incoming call while in another call

## Implementation Notes

### Agora SDK Integration

**Initialization**
```dart
// Initialize once at app startup
final engine = await RtcEngine.create(agoraAppId);
await engine.enableAudio();
await engine.enableVideo(); // For video calls
await engine.setChannelProfile(ChannelProfile.Communication);
```

**Joining Channel**
```dart
// Use token from backend
await engine.joinChannel(
  token: agoraToken,
  channelName: channelId,
  uid: userId,
  options: ChannelMediaOptions(
    channelProfile: ChannelProfile.Communication,
    clientRoleType: ClientRoleType.Broadcaster,
  ),
);
```

**Event Handlers**
```dart
engine.registerEventHandler(
  RtcEngineEventHandler(
    onJoinChannelSuccess: (connection, elapsed) {
      // Update UI to connected state
    },
    onUserJoined: (connection, remoteUid, elapsed) {
      // Show remote video view
    },
    onUserOffline: (connection, remoteUid, reason) {
      // Handle remote user leaving
    },
    onNetworkQuality: (connection, txQuality, rxQuality) {
      // Update network quality indicator
    },
  ),
);
```

### WebSocket Event Handling

**Listening to Call Events**
```dart
// In CallStateNotifier
void _listenToCallEvents() {
  final wsService = ref.read(chatWebSocketServiceProvider);
  
  wsService.rawMessageStream.listen((message) {
    final type = message['type'] as String?;
    
    switch (type) {
      case 'call.incoming':
        _handleIncomingCall(message['data']);
        break;
      case 'call.accepted':
        _handleCallAccepted(message['data']);
        break;
      case 'call.rejected':
        _handleCallRejected(message['data']);
        break;
      case 'call.ended':
        _handleCallEnded(message['data']);
        break;
      case 'call.timeout':
        _handleCallTimeout(message['data']);
        break;
      case 'call.quality_warning':
        _handleQualityWarning(message['data']);
        break;
    }
  });
}
```

### Permission Handling

**Request Permissions Before Call**
```dart
Future<bool> _requestPermissions(CallType callType) async {
  final permissions = [Permission.microphone];
  if (callType == CallType.video) {
    permissions.add(Permission.camera);
  }
  
  final statuses = await permissions.request();
  return statuses.values.every((status) => status.isGranted);
}
```

### Resource Management

**Cleanup on Dispose**
```dart
@override
void dispose() {
  _agoraEngine.leaveChannel();
  _agoraEngine.release();
  _ringtoneService.stop();
  super.dispose();
}
```

### State Management Best Practices

**Use AsyncValue for API Calls**
```dart
Future<void> initiateCall({
  required int calleeId,
  required CallType callType,
}) async {
  state = const AsyncValue.loading();
  
  final result = await ref.read(agoraCallRepositoryProvider).initiateCall(
    calleeId: calleeId,
    callType: callType,
  );
  
  result.fold(
    (failure) => state = AsyncValue.error(failure, StackTrace.current),
    (connection) {
      state = AsyncValue.data(connection.call);
      _joinAgoraChannel(connection);
    },
  );
}
```

**Handle State Transitions**
```dart
void _updateCallStatus(CallStatus newStatus) {
  state.whenData((call) {
    if (call != null) {
      state = AsyncValue.data(call.copyWith(status: newStatus));
    }
  });
}
```

### UI/UX Considerations

**Loading States**
- Show loading indicator during API calls
- Display "Connecting..." when joining Agora channel
- Show "Ringing..." when waiting for callee to answer

**Error States**
- Display user-friendly error messages
- Provide retry option for network errors
- Auto-dismiss error messages after timeout

**Call Quality Indicators**
- Green: Excellent quality
- Yellow: Good quality with minor issues
- Red: Poor quality, may disconnect

**Ringtone Management**
- Use custom ringtone from assets
- Respect device volume settings
- Stop ringtone on app backgrounding

### Performance Considerations

**Memory Management**
- Release Agora engine when not in use
- Dispose video renderers properly
- Clear large objects from memory after call ends

**Battery Optimization**
- Disable video when not needed
- Reduce frame rate for poor network conditions
- Use audio-only mode when possible

**Network Optimization**
- Agora SDK handles adaptive bitrate automatically
- Monitor network quality and warn users
- Gracefully degrade video quality before dropping call

## Dependencies

### External Packages
- `agora_rtc_engine: ^6.3.2` - Real-time communication SDK
- `permission_handler: ^12.0.1` - Device permission management
- `audioplayers: ^6.5.1` - Ringtone playback

### Internal Dependencies
- `lib/core/network/dio_client.dart` - HTTP client
- `lib/features/chat/data/services/chat_websocket_service.dart` - WebSocket service
- `lib/core/services/token_cache_service.dart` - JWT token management

### Environment Variables
- `AGORA_APP_ID` - Agora application ID (from .env file)

## Security Considerations

**Token Security**
- Never log or persist Agora tokens
- Clear tokens from memory after use
- Use short-lived tokens (backend should set appropriate TTL)

**API Security**
- Include JWT in all API requests
- Handle 401 errors by refreshing token
- Validate call ownership (user can only end their own calls)

**WebSocket Security**
- Use WSS (secure WebSocket) protocol
- Authenticate WebSocket connection with JWT
- Validate message sources

**Privacy**
- Don't record calls without user consent
- Don't persist call content
- Clear call history based on user preferences

## Deployment Considerations

**Agora Configuration**
- Ensure backend is configured with correct Agora App ID and Certificate
- Verify token generation on backend is working correctly
- Test in different network conditions

**Platform-Specific**
- iOS: Add camera and microphone usage descriptions to Info.plist
- Android: Add camera and microphone permissions to AndroidManifest.xml
- Web: Request permissions through browser APIs

**Monitoring**
- Log call initiation/end events for analytics
- Monitor call success rate
- Track average call duration
- Alert on high error rates

**Rollout Strategy**
- Deploy to staging environment first
- Test with small group of users
- Monitor error rates and user feedback
- Gradually roll out to all users
