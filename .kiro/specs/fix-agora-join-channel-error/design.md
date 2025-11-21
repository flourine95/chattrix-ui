# Design Document - Fix Agora Join Channel Error (-17)

## Overview

This document outlines the design for fixing the Agora "errJoinChannelRejected" (error code -17) that occurs when attempting to join a channel. Based on analysis of the logs and code, the root cause is a **channel profile mismatch** between token generation and channel join.

## Root Cause Analysis

### The Problem

**Log Evidence:**
```
I/spdlog: [2025-11-21 01:34:47.806] api name RtcEngine_joinChannel_cdbb747 
params "{"token":"0069***","channelId":"channel_1763663687663_xyz012","uid":993377736,
"options":{"clientRoleType":1,"channelProfile":0}}"

I/spdlog: [2025-11-21 01:34:47.808] result 0 outdata {"result":-17}
[CallLogger] Agora error event Error code: ErrorCodeType.errJoinChannelRejected
```

**Analysis:**
1. ✅ Token is successfully fetched (UID: 993377736)
2. ✅ Authentication works (JWT token is valid)
3. ❌ Join channel fails with error -17

**Root Cause:**
The Agora SDK is rejecting the join request because of a **channel profile mismatch**:

- **Backend token generation** (AgoraTokenService.java):
  ```java
  // No channel profile specified in buildTokenWithUid()
  // Defaults to ChannelProfileType.CHANNEL_PROFILE_COMMUNICATION (0)
  ```

- **Flutter join channel** (agora_service.dart):
  ```dart
  // Initialize with Communication profile
  RtcEngineContext(
    appId: appId,
    channelProfile: ChannelProfileType.channelProfileCommunication
  )
  
  // But then override in ChannelMediaOptions
  ChannelMediaOptions(
    channelProfile: ChannelProfileType.channelProfileCommunication,  // Redundant!
    clientRoleType: ClientRoleType.clientRoleBroadcaster,
  )
  ```

The issue is that **ChannelMediaOptions.channelProfile should NOT be set** when joining. The channel profile is already set during engine initialization and should not be changed per-channel.

### Secondary Issues

1. **Redundant channel profile setting**: Setting it in both `RtcEngineContext` and `ChannelMediaOptions`
2. **Missing validation**: No check if App ID matches between frontend and backend
3. **Insufficient logging**: Not logging the actual channel profile being used
4. **No error recovery**: When join fails, no retry or fallback mechanism

## Architecture

### Current Flow (Broken)

```
┌─────────────────────────────────────────────────────────────┐
│                    Flutter App                               │
│                                                              │
│  1. Initialize Engine                                       │
│     channelProfile = Communication (0)                      │
│                                                              │
│  2. Fetch Token from Backend                                │
│     ✅ Token generated with default profile                 │
│                                                              │
│  3. Join Channel                                            │
│     ❌ Set channelProfile AGAIN in ChannelMediaOptions      │
│     ❌ This causes mismatch → Error -17                     │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### Fixed Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    Flutter App                               │
│                                                              │
│  1. Initialize Engine                                       │
│     channelProfile = Communication (0)                      │
│     ✅ Set once, never change                               │
│                                                              │
│  2. Fetch Token from Backend                                │
│     ✅ Token generated with default profile                 │
│                                                              │
│  3. Join Channel                                            │
│     ✅ DON'T set channelProfile in ChannelMediaOptions      │
│     ✅ Only set clientRoleType = Broadcaster                │
│     ✅ Success!                                              │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## Components and Interfaces

### 1. AgoraService (Updated)

**File:** `lib/features/call/data/services/agora_service.dart`

**Key Changes:**

```dart
class AgoraService {
  // ... existing code ...

  /// Initialize the Agora RTC Engine with app ID from environment
  Future<void> initialize(String appId) async {
    if (_isInitialized) {
      return;
    }

    try {
      // Validate App ID
      if (appId.isEmpty) {
        throw Exception('AGORA_APP_ID is empty');
      }

      _logger?.logInfo('Initializing Agora with App ID: ${appId.substring(0, 8)}...');

      // Create RTC engine
      _engine = createAgoraRtcEngine();

      // Initialize the engine with Communication profile
      // ✅ Set channel profile ONCE here, never change it
      await _engine!.initialize(
        RtcEngineContext(
          appId: appId,
          channelProfile: ChannelProfileType.channelProfileCommunication,
        ),
      );

      // Register event handlers
      _registerEventHandlers();

      _isInitialized = true;
      _logger?.logInfo('Agora engine initialized successfully');
    } catch (e) {
      _logger?.logError('Failed to initialize Agora engine: $e');
      _eventController.add(
        ErrorEvent(
          errorCode: ErrorCodeType.errFailed,
          message: 'Failed to initialize Agora engine: $e',
        ),
      );
      rethrow;
    }
  }

  /// Join a channel with token authentication
  Future<void> joinChannel({
    required String token,
    required String channelId,
    required int uid,
    required bool isVideo,
  }) async {
    if (!_isInitialized || _engine == null) {
      throw Exception('Agora engine not initialized');
    }

    try {
      _localUid = uid;

      _logger?.logInfo('Joining channel: $channelId with UID: $uid, isVideo: $isVideo');
      _logger?.logDebug('Token (first 20 chars): ${token.substring(0, 20)}...');

      // Enable audio
      await _engine!.enableAudio();

      // Enable video if needed
      if (isVideo) {
        await _engine!.enableVideo();
        await _engine!.startPreview();
      } else {
        await _engine!.disableVideo();
      }

      // Join the channel
      // ✅ FIX: Remove channelProfile from ChannelMediaOptions
      // The profile is already set during initialization
      await _engine!.joinChannel(
        token: token,
        channelId: channelId,
        uid: uid,
        options: const ChannelMediaOptions(
          // ❌ REMOVED: channelProfile (causes mismatch)
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ),
      );

      _logger?.logInfo('Join channel request sent successfully');
    } catch (e) {
      _logger?.logError('Failed to join channel: $e');
      _eventController.add(
        ErrorEvent(
          errorCode: ErrorCodeType.errJoinChannelRejected,
          message: 'Failed to join channel: $e',
        ),
      );
      rethrow;
    }
  }

  // ... rest of the code remains the same ...
}
```

### 2. CallLogger (Enhanced)

**File:** `lib/features/call/data/services/call_logger.dart`

**Add methods for better debugging:**

```dart
class CallLogger {
  static void logInfo(String message) {
    print('[CallLogger] ℹ️ $message');
  }

  static void logDebug(String message) {
    print('[CallLogger] 🔍 $message');
  }

  static void logError(String message, {Object? error, StackTrace? stackTrace}) {
    print('[CallLogger] ❌ $message');
    if (error != null) {
      print('[CallLogger] Error details: $error');
    }
    if (stackTrace != null) {
      print('[CallLogger] Stack trace: $stackTrace');
    }
  }

  static void logWarning(String message) {
    print('[CallLogger] ⚠️ $message');
  }

  static void logSuccess(String message) {
    print('[CallLogger] ✅ $message');
  }

  // ... existing methods ...
}
```

### 3. Environment Validation

**File:** `lib/core/config/env_validator.dart` (New)

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvValidator {
  /// Validate that all required environment variables are present
  static void validate() {
    final appId = dotenv.env['AGORA_APP_ID'];

    if (appId == null || appId.isEmpty) {
      throw Exception(
        'AGORA_APP_ID is not set in .env file. '
        'Please add: AGORA_APP_ID=your_app_id',
      );
    }

    if (appId.length != 32) {
      throw Exception(
        'AGORA_APP_ID appears to be invalid (should be 32 characters). '
        'Current length: ${appId.length}',
      );
    }

    print('[EnvValidator] ✅ AGORA_APP_ID validated: ${appId.substring(0, 8)}...');
  }

  /// Get the Agora App ID
  static String getAgoraAppId() {
    final appId = dotenv.env['AGORA_APP_ID'];
    if (appId == null || appId.isEmpty) {
      throw Exception('AGORA_APP_ID not found');
    }
    return appId;
  }
}
```

### 4. Error Messages (Updated)

**File:** `lib/core/errors/failures.dart`

**Ensure user-friendly messages:**

```dart
extension FailureMessage on Failure {
  String get userMessage {
    return when(
      network: (message) => 'Network error. Please check your connection.',
      server: (message, errorCode) => 'Server error. Please try again later.',
      unauthorized: (message, errorCode) => 'Authentication failed. Please login again.',
      forbidden: (message, errorCode) => 'Access denied.',
      notFound: (message, errorCode) => 'Service not found. Please check if backend is running.',
      validation: (message) => message,
      tokenExpired: (message) => 'Session expired. Please login again.',
      agoraEngine: (message, code) => 'Failed to join call. Please check your connection and try again.',
      channelJoin: (message) => 'Failed to join call. Please try again.',
      permission: (message) => message,
      unknown: (message) => 'An unexpected error occurred. Please try again.',
    );
  }
}
```

## Data Models

No new data models needed. Existing models are sufficient.

## Error Handling Strategy

### Error Code Mapping

| Agora Error Code | Error Name | Cause | User Message | Action |
|-----------------|------------|-------|--------------|--------|
| -17 | errJoinChannelRejected | Channel profile mismatch, invalid token, or network issue | "Failed to join call. Please try again." | Retry with exponential backoff |
| -2 | errInvalidAppId | App ID is invalid | "Invalid app configuration. Please contact support." | Show support contact |
| -5 | errInvalidChannelName | Channel name is invalid | "Invalid call ID. Please try again." | Return to previous screen |
| -7 | errNotInitialized | Engine not initialized | "Call service not ready. Please restart the app." | Restart app |
| -110 | errTokenExpired | Token has expired | "Session expired. Reconnecting..." | Auto-refresh token |

### Retry Strategy

```dart
class RetryStrategy {
  static const maxRetries = 3;
  static const initialDelay = Duration(seconds: 1);
  
  static Future<T> withRetry<T>({
    required Future<T> Function() operation,
    required String operationName,
  }) async {
    int attempt = 0;
    
    while (attempt < maxRetries) {
      try {
        return await operation();
      } catch (e) {
        attempt++;
        
        if (attempt >= maxRetries) {
          rethrow;
        }
        
        final delay = initialDelay * (1 << attempt); // Exponential backoff
        CallLogger.logWarning(
          '$operationName failed (attempt $attempt/$maxRetries). '
          'Retrying in ${delay.inSeconds}s...',
        );
        
        await Future.delayed(delay);
      }
    }
    
    throw Exception('$operationName failed after $maxRetries attempts');
  }
}
```

## Testing Strategy

### Unit Tests

1. **AgoraService Tests**
   - Test initialization with valid App ID
   - Test initialization with invalid App ID
   - Test join channel with valid token
   - Test join channel without initialization
   - Test that channelProfile is NOT set in ChannelMediaOptions

2. **EnvValidator Tests**
   - Test validation with valid AGORA_APP_ID
   - Test validation with missing AGORA_APP_ID
   - Test validation with invalid AGORA_APP_ID length

3. **Error Handling Tests**
   - Test each error code mapping
   - Test user-friendly error messages
   - Test retry strategy

### Integration Tests

1. **End-to-End Call Flow**
   - Initialize engine
   - Fetch token
   - Join channel
   - Verify no error -17
   - Leave channel

2. **Error Recovery**
   - Simulate network error during join
   - Verify retry mechanism works
   - Verify user sees appropriate message

### Manual Testing Checklist

- [ ] Backend is running and accessible
- [ ] User is logged in (JWT token valid)
- [ ] AGORA_APP_ID matches between frontend and backend
- [ ] AGORA_APP_CERTIFICATE is correct in backend
- [ ] Initiate video call
- [ ] Verify join succeeds (no error -17)
- [ ] Verify video/audio streams work
- [ ] Verify remote user can join
- [ ] End call successfully

## Implementation Notes

### Priority 1: Fix ChannelMediaOptions (CRITICAL)

**This is the main fix:**

1. Open `lib/features/call/data/services/agora_service.dart`
2. Find the `joinChannel` method
3. Remove `channelProfile` from `ChannelMediaOptions`:

```dart
// ❌ BEFORE (Broken)
options: const ChannelMediaOptions(
  channelProfile: ChannelProfileType.channelProfileCommunication,  // REMOVE THIS
  clientRoleType: ClientRoleType.clientRoleBroadcaster,
)

// ✅ AFTER (Fixed)
options: const ChannelMediaOptions(
  clientRoleType: ClientRoleType.clientRoleBroadcaster,
)
```

### Priority 2: Add Logging

1. Add detailed logging in `joinChannel` method
2. Log token (first 20 chars), channel ID, UID, and video flag
3. Log success/failure of join operation

### Priority 3: Add Validation

1. Create `EnvValidator` class
2. Validate AGORA_APP_ID on app startup
3. Validate App ID length (should be 32 characters)

### Priority 4: Improve Error Messages

1. Update `Failure` extension to provide user-friendly messages
2. Map Agora error codes to actionable messages
3. Add retry mechanism for transient errors

## Deployment Considerations

### Environment Variables

**Frontend (.env):**
```env
AGORA_APP_ID=9300ff3fc592405fa28e43a96ab2bf0f
```

**Backend (.env):**
```env
AGORA_APP_ID=9300ff3fc592405fa28e43a96ab2bf0f
AGORA_APP_CERTIFICATE=b5807d0448a94153a1a4562c03a7de29
```

**⚠️ IMPORTANT:** Ensure App ID matches exactly between frontend and backend!

### Verification Steps

1. **Verify App ID:**
   ```bash
   # Frontend
   grep AGORA_APP_ID chattrix-ui/.env
   
   # Backend
   grep AGORA_APP_ID chattrix-api/.env
   ```

2. **Verify Backend Token Generation:**
   - Check logs for "Token generated" messages
   - Verify UID is generated correctly
   - Verify token expiration is set

3. **Verify Frontend Join:**
   - Check logs for "Joining channel" messages
   - Verify no "channelProfile" in ChannelMediaOptions
   - Verify join succeeds without error -17

### Monitoring

1. **Log all join attempts:**
   - Channel ID
   - UID
   - Token (first 20 chars)
   - Success/failure
   - Error code if failed

2. **Track metrics:**
   - Join success rate
   - Average time to join
   - Error -17 occurrence rate
   - Token fetch success rate

3. **Alert on:**
   - Join success rate < 95%
   - Error -17 rate > 5%
   - Token fetch failures

## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system-essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*

Before writing properties, let me analyze the acceptance criteria:

### Acceptance Criteria Testing Prework

**1.1** WHEN generating a token THEN the system SHALL use ChannelProfileType.channelProfileCommunication
Thoughts: This is about the backend token generation. We can verify that tokens are generated with the correct profile by checking the backend logs or response.
Testable: no (backend behavior, not testable in Flutter unit tests)

**1.2** WHEN joining a channel THEN the system SHALL use the same ChannelProfileType.channelProfileCommunication
Thoughts: This is about ensuring the join request uses Communication profile. We can test this by mocking the Agora SDK and verifying the parameters passed to joinChannel.
Testable: yes - property

**1.3** WHEN initializing the engine THEN the system SHALL set channelProfile to ChannelProfileType.channelProfileCommunication
Thoughts: This is about the initialization parameters. We can test this by mocking the SDK and verifying the RtcEngineContext parameters.
Testable: yes - property

**1.4** WHEN setting ChannelMediaOptions THEN the system SHALL explicitly set channelProfile to match initialization
Thoughts: Actually, the fix is to NOT set channelProfile in ChannelMediaOptions. This is a negative requirement.
Testable: yes - property

**1.5** WHEN the profiles mismatch THEN the system SHALL log a warning before attempting to join
Thoughts: This is about logging behavior. We can test this by capturing log output.
Testable: yes - example

**2.1** WHEN the app starts THEN the system SHALL validate AGORA_APP_ID is not empty
Thoughts: This is about validation at startup. We can test this with different env configurations.
Testable: yes - property

**2.2** WHEN generating tokens THEN the backend SHALL use the correct AGORA_APP_CERTIFICATE
Thoughts: This is backend behavior, not testable in Flutter.
Testable: no

**2.3** WHEN tokens are invalid THEN the system SHALL log the App ID being used (first 8 characters only)
Thoughts: This is about logging behavior when errors occur.
Testable: yes - example

**2.4** WHEN the App ID mismatches THEN the system SHALL display a clear error message
Thoughts: This is about error handling. We can test this by simulating mismatched App IDs.
Testable: yes - example

**2.5** WHEN debugging THEN the system SHALL provide a way to verify App ID matches between frontend and backend
Thoughts: This is about providing debugging tools, not a testable property.
Testable: no

**3.1** WHEN initializing the engine THEN the system SHALL set all required parameters in one place
Thoughts: This is about code organization, not a functional requirement.
Testable: no

**3.2** WHEN joining a channel THEN the system SHALL not override channel profile settings
Thoughts: This is the core fix - ensuring channelProfile is NOT in ChannelMediaOptions.
Testable: yes - property

**3.3** WHEN ChannelMediaOptions are created THEN the system SHALL only set necessary options
Thoughts: This is about what fields are set in ChannelMediaOptions. We can verify only clientRoleType is set.
Testable: yes - property

**3.4** WHEN the engine is already initialized THEN the system SHALL not reinitialize
Thoughts: This is about idempotency of initialization. We can test calling initialize() twice.
Testable: yes - property

**3.5** WHEN joining fails THEN the system SHALL log all configuration parameters used
Thoughts: This is about logging on failure.
Testable: yes - example

**4.1** WHEN attempting to join THEN the system SHALL log the token (first 20 characters), channel ID, UID, and profile
Thoughts: This is about logging behavior.
Testable: yes - example

**4.2** WHEN join succeeds THEN the system SHALL log the success event with elapsed time
Thoughts: This is about logging on success.
Testable: yes - example

**4.3** WHEN join fails THEN the system SHALL log the error code and message
Thoughts: This is about logging on failure.
Testable: yes - example

**4.4** WHEN Agora events occur THEN the system SHALL log all event details
Thoughts: This is about logging all events.
Testable: yes - property

**4.5** WHEN debugging THEN the system SHALL log the full ChannelMediaOptions being used
Thoughts: This is about debug logging.
Testable: yes - example

**5.1-5.5**: Backend requirements, not testable in Flutter

**6.1** WHEN error -17 occurs THEN the system SHALL display "Failed to join call. Please check your connection and try again."
Thoughts: This is about error message mapping. We can test this with different error codes.
Testable: yes - example

**6.2-6.5**: Similar error message mapping tests
Testable: yes - examples

**7.1-7.5**: Testing requirements, not properties to test

**8.1** WHEN initialization fails THEN the system SHALL catch the exception and return a Failure
Thoughts: This is about error handling. We can test this by simulating initialization failures.
Testable: yes - property

**8.2-8.5**: Error handling examples
Testable: yes - examples

**9.1** WHEN joining a video call THEN the system SHALL enable video before joining
Thoughts: This is about the order of operations. We can verify enableVideo is called before joinChannel.
Testable: yes - property

**9.2** WHEN joining an audio call THEN the system SHALL disable video before joining
Thoughts: Similar to 9.1, but for audio calls.
Testable: yes - property

**9.3-9.5**: Media setup behavior
Testable: yes - properties

**10.1** WHEN joining a channel THEN the system SHALL set clientRoleType to ClientRoleType.clientRoleBroadcaster
Thoughts: This is about verifying the role is set correctly.
Testable: yes - property

**10.2-10.5**: Role-related behavior
Testable: yes - properties/examples

### Property Reflection

After reviewing all properties, I notice some redundancy:

- Properties 1.2, 1.3, and 3.2 all relate to channel profile consistency - can be combined
- Properties 9.1 and 9.2 can be combined into one property about media setup based on call type
- Many logging properties (4.1-4.5) are examples, not universal properties

Let me consolidate:

### Correctness Properties

**Property 1: Channel profile consistency**
*For any* Agora engine initialization and subsequent channel join, the channel profile SHALL be set to Communication during initialization and SHALL NOT be overridden in ChannelMediaOptions
**Validates: Requirements 1.2, 1.3, 3.2, 3.3**

**Property 2: Initialization idempotency**
*For any* Agora engine, calling initialize() multiple times SHALL only initialize once and SHALL return success on subsequent calls
**Validates: Requirements 3.4**

**Property 3: App ID validation**
*For any* app startup, if AGORA_APP_ID is empty or invalid, the system SHALL throw an exception before attempting to initialize the engine
**Validates: Requirements 2.1**

**Property 4: Media setup based on call type**
*For any* channel join operation, if the call type is video, the system SHALL enable video before joining; if audio-only, the system SHALL disable video before joining
**Validates: Requirements 9.1, 9.2**

**Property 5: Client role is broadcaster**
*For any* channel join operation, the ChannelMediaOptions SHALL set clientRoleType to ClientRoleType.clientRoleBroadcaster
**Validates: Requirements 10.1**

**Property 6: Error handling returns Failure**
*For any* Agora operation that throws an exception, the system SHALL catch the exception and return a Failure type instead of propagating the exception
**Validates: Requirements 8.1**

**Property 7: Event logging**
*For any* Agora event received, the system SHALL log the event type and relevant details
**Validates: Requirements 4.4**

## Conclusion

The primary fix is simple but critical: **remove `channelProfile` from `ChannelMediaOptions` in the `joinChannel` method**. This single change should resolve the error -17 issue. Additional improvements include better logging, validation, and error handling to prevent similar issues in the future.
