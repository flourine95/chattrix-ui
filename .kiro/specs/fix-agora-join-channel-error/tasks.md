# Implementation Plan - Fix Agora Join Channel Error (-17)

## Task List

- [x] 1. Fix ChannelMediaOptions in AgoraService (CRITICAL FIX)




  - Open `lib/features/call/data/services/agora_service.dart`
  - Find the `joinChannel` method (around line 109)
  - Remove `channelProfile: ChannelProfileType.channelProfileCommunication,` from `ChannelMediaOptions` constructor
  - Keep only `clientRoleType: ClientRoleType.clientRoleBroadcaster`
  - The channel profile is already set during engine initialization and should NOT be overridden per-channel
  - _Requirements: 1.2, 1.4, 3.2, 3.3_

- [ ] 1.1 Write property test for channel profile consistency









  - **Property 1: Channel profile consistency**
  - **Validates: Requirements 1.2, 1.3, 3.2, 3.3**

- [x] 2. Add detailed logging to AgoraService





  - [x] 2.1 Add logging in initialize method


    - Add print statements or use a logger
    - Log App ID (first 8 characters only for security)
    - Log initialization success/failure
    - Log channel profile being used
    - _Requirements: 2.3, 4.1_
  

  - [x] 2.2 Add logging in joinChannel method

    - Log channel ID, UID, and isVideo flag
    - Log token (first 20 characters only for security)
    - Log the ChannelMediaOptions being used
    - Log join success/failure
    - _Requirements: 4.1, 4.3, 4.5_
  

  - [x] 2.3 Enhance event logging in _registerEventHandlers

    - Add print statements in each event handler
    - Log all Agora events with relevant details
    - Log error events with error code and message
    - _Requirements: 4.2, 4.3, 4.4_


- [x] 2.4 Write property test for event logging





  - **Property 7: Event logging**
  - **Validates: Requirements 4.4**

- [x] 3. Create EnvValidator class




  - [x] 3.1 Create new file lib/core/config/env_validator.dart


    - Create static `validate()` method to check AGORA_APP_ID
    - Create static `getAgoraAppId()` method to retrieve App ID
    - Validate App ID is not null or empty
    - Validate App ID length is 32 characters
    - Throw exception with clear message if invalid
    - _Requirements: 2.1, 2.4_
  
  - [x] 3.2 Call EnvValidator in app initialization


    - Add `EnvValidator.validate()` call in main.dart after dotenv.load()
    - Wrap in try-catch to handle validation errors gracefully
    - Show error dialog if validation fails
    - _Requirements: 2.1_

- [x] 3.3 Write property test for App ID validation






  - **Property 3: App ID validation**
  - **Validates: Requirements 2.1**

- [x] 4. Improve error messages in Failure extension




  - [x] 4.1 Add userMessage extension to Failure class


    - Create extension on Failure in lib/core/errors/failures.dart
    - Add `String get userMessage` that uses `.when()` to map each Failure type
    - Map agoraEngine failure to "Failed to join call. Please check your connection and try again."
    - Map channelJoin failure to "Failed to join call. Please try again."
    - Map network failure to "Network error. Please check your internet connection."
    - Map unauthorized to "Authentication failed. Please login again."
    - Map other failures to appropriate user-friendly messages
    - _Requirements: 6.1, 6.2, 6.3, 6.4_
  
  - [x] 4.2 Update UI to use userMessage


    - Find where errors are displayed in call screens
    - Replace raw error message display with `failure.userMessage`
    - Add error dialog with actionable messages
    - _Requirements: 6.1_

- [x] 5. Add initialization idempotency check
  - ✅ Already implemented: `initialize()` method checks `_isInitialized` at line 58-60
  - ✅ Returns early if already initialized
  - Add logging when skipping reinitialization (enhancement)
  - _Requirements: 3.4, 8.4_

- [x] 5.1 Write property test for initialization idempotency






  - **Property 2: Initialization idempotency**
  - **Validates: Requirements 3.4**

- [x] 6. Ensure media setup based on call type
  - ✅ Already implemented: `joinChannel()` enables video for video calls (line 99-102)
  - ✅ Already implemented: `joinChannel()` disables video for audio calls (line 103-105)
  - ✅ Audio is always enabled (line 96)
  - ✅ Video preview starts for video calls (line 101)
  - _Requirements: 9.1, 9.2, 9.3, 9.4_

- [x] 6.1 Write property test for media setup





  - **Property 4: Media setup based on call type**
  - **Validates: Requirements 9.1, 9.2**

- [x] 7. Verify client role is set correctly
  - ✅ Already implemented: `clientRoleType` is set to `ClientRoleType.clientRoleBroadcaster` (line 110)
  - ⚠️ BUT channelProfile needs to be removed (see Task 1)
  - _Requirements: 10.1, 10.2_

- [x] 7.1 Write property test for client role






  - **Property 5: Client role is broadcaster**
  - **Validates: Requirements 10.1**

- [x] 8. Enhance error handling
  - ✅ Try-catch already exists in initialize() (line 60-72)
  - ✅ Try-catch already exists in joinChannel() (line 108-118)
  - ✅ Try-catch already exists in leaveChannel() (line 123-133)
  - ✅ ErrorEvent is emitted on failures
  - Consider returning Either<Failure, void> instead of throwing (optional enhancement)
  - _Requirements: 8.1, 8.2_


- [x] 8.1 Write property test for error handling






  - **Property 6: Error handling returns Failure**
  - **Validates: Requirements 8.1**

- [x] 9. Manual testing checklist



  - [x] 9.1 Test video call flow




    - Ensure backend is running
    - Ensure user is logged in
    - Initiate a video call
    - Verify no error -17 occurs
    - Verify join succeeds
    - Verify video/audio streams work
    - Verify remote user can join
    - End call successfully
    - _Requirements: 1.1, 1.2, 1.3, 1.4_
  
  - [x] 9.2 Test audio-only call




    - Initiate an audio call
    - Verify video is disabled
    - Verify audio works
    - _Requirements: 9.2_
  -

  - [x] 9.3 Test error scenarios



    - Test with invalid App ID (should fail gracefully)
    - Test with backend stopped (should show connection error)
    - Test with invalid token (should show auth error)
    - Verify error messages are user-friendly
    - _Requirements: 2.1, 2.4, 6.1, 8.1_
  

  - [ ] 9.4 Verify logging output

    - Check console logs for initialization messages
    - Check console logs for join channel messages
    - Check console logs for event messages
    - Verify sensitive data is masked (token, App ID)
    - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5_

- [ ] 10. Checkpoint - Ensure all tests pass

  - Ensure all tests pass, ask the user if questions arise.
