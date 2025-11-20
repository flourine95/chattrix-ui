# Implementation Plan

- [x] 1. Setup project dependencies and configuration





  - Add agora_rtc_engine, permission_handler, and other required packages to pubspec.yaml
  - Configure environment variables in .env file for AGORA_APP_ID and token server URL
  - Update analysis_options.yaml if needed for new dependencies
  - Run build_runner to generate initial code
  - _Requirements: 8.3, 8.4_

- [x] 2. Implement Domain Layer entities and interfaces





  - [x] 2.1 Create CallEntity with freezed


    - Define CallEntity with all required fields (callId, channelId, users, type, status, etc.)
    - Define CallType, CallStatus, CameraFacing, NetworkQuality enums
    - _Requirements: 7.2_

  - [x] 2.2 Create CallHistoryEntity with freezed


    - Define CallHistoryEntity for storing call records
    - _Requirements: 12.1, 12.2_

  - [x] 2.3 Define CallRepository interface


    - Create abstract CallRepository with all method signatures
    - Ensure all methods return Either<Failure, T> types
    - Include methods for initialize, createCall, joinCall, endCall, toggles, streams
    - _Requirements: 7.1, 7.4_

  - [ ]* 2.4 Write property test for call entity creation
    - **Property 1: Call initiation creates proper channel configuration**
    - **Validates: Requirements 1.1, 2.1**

- [x] 3. Implement Data Layer models and DTOs





  - [x] 3.1 Create CallModel DTO with freezed and json_serializable


    - Define CallModel with JSON serialization
    - Implement fromEntity and toEntity conversion methods
    - _Requirements: 1.1, 2.1_

  - [x] 3.2 Create CallHistoryModel DTO


    - Define CallHistoryModel with JSON serialization for local storage
    - Implement conversion methods
    - _Requirements: 12.1, 12.2_

  - [ ]* 3.3 Write property test for model conversions
    - **Property 32: Completed calls saved with metadata**
    - **Validates: Requirements 12.1**

- [x] 4. Implement Agora Service wrapper





  - [x] 4.1 Create AgoraService class


    - Initialize RtcEngine with app ID from environment
    - Implement joinChannel method with token authentication
    - Implement leaveChannel and cleanup methods
    - Set up event stream for Agora callbacks
    - _Requirements: 1.1, 1.3, 8.1_

  - [x] 4.2 Implement audio/video control methods


    - Add muteLocalAudioStream method
    - Add muteLocalVideoStream method
    - Add switchCamera method
    - Add enableVideo/enableAudio methods
    - _Requirements: 3.3, 3.4, 4.2_

  - [x] 4.3 Implement event handling

    - Handle onJoinChannelSuccess callback
    - Handle onUserJoined callback for remote participants
    - Handle onUserOffline callback
    - Handle onNetworkQuality callback
    - Handle onTokenPrivilegeWillExpire callback
    - _Requirements: 1.3, 6.2, 8.2_

  - [ ]* 4.4 Write property test for audio mute toggle
    - **Property 7: Muting microphone stops audio transmission**
    - **Validates: Requirements 3.3**

  - [ ]* 4.5 Write property test for video toggle
    - **Property 8: Disabling camera stops video transmission**
    - **Validates: Requirements 3.4**

- [x] 5. Implement permission handling




  - [x] 5.1 Create PermissionService


    - Implement requestCameraPermission method
    - Implement requestMicrophonePermission method
    - Implement checkCameraPermission and checkMicrophonePermission methods
    - Implement openAppSettings method for denied permissions
    - _Requirements: 1.5, 2.4, 11.3_

  - [ ]* 5.2 Write property test for permission requests
    - **Property 4: Camera permission requested before video capture**
    - **Property 5: Microphone permission requested before audio capture**
    - **Validates: Requirements 1.5, 2.4**

- [x] 6. Implement token management service




  - [x] 6.1 Create TokenService


    - Implement method to fetch Agora token from backend server
    - Implement token refresh logic
    - Handle token expiration events
    - _Requirements: 8.1, 8.2, 8.5_

  - [ ]* 6.2 Write property test for token handling
    - **Property 19: Channel join includes valid token**
    - **Property 20: Token expiration triggers refresh request**
    - **Property 21: Token renewal failure disconnects call**
    - **Validates: Requirements 8.1, 8.2, 8.5**

- [x] 7. Implement call local data source




  - [x] 7.1 Create CallLocalDataSource

    - Implement saveCallHistory method using local storage
    - Implement getCallHistory method
    - Implement deleteCallHistory method
    - Use existing persistence mechanism (flutter_secure_storage or similar)
    - _Requirements: 12.1, 12.2, 12.3_

  - [ ]* 7.2 Write property test for call history sorting
    - **Property 34: Call history sorted chronologically**
    - **Validates: Requirements 12.4**

- [x] 8. Implement CallRepository implementation





  - [x] 8.1 Create CallRepositoryImpl


    - Inject AgoraService, CallLocalDataSource, TokenService, PermissionService
    - Implement initialize method with error handling
    - _Requirements: 7.1, 11.1_

  - [x] 8.2 Implement createCall method


    - Request permissions before starting call
    - Fetch token from TokenService
    - Initialize Agora engine if needed
    - Enable audio/video based on call type
    - Join channel with token
    - Return Either<Failure, CallEntity>
    - _Requirements: 1.1, 1.5, 2.1, 2.4_

  - [x] 8.3 Implement joinCall method


    - Similar to createCall but for accepting incoming calls
    - _Requirements: 1.3_

  - [x] 8.4 Implement endCall method


    - Leave Agora channel
    - Release media resources
    - Save call to history
    - Send end notification via WebSocket
    - _Requirements: 5.1, 5.2, 5.3, 12.1_

  - [x] 8.5 Implement media control methods


    - Implement toggleAudioMute using AgoraService
    - Implement toggleVideo using AgoraService
    - Implement switchCamera using AgoraService
    - Return updated state after each toggle
    - _Requirements: 3.1, 3.2, 3.3, 3.4, 4.1, 4.2_

  - [x] 8.6 Implement state and quality streams


    - Implement watchCallState stream
    - Implement watchNetworkQuality stream
    - Map Agora events to domain entities
    - _Requirements: 6.1, 6.2, 6.3_

  - [x] 8.7 Implement call history methods


    - Implement saveCallHistory using local data source
    - Implement getCallHistory with sorting
    - _Requirements: 12.1, 12.2, 12.4_

  - [ ]* 8.8 Write property test for call flow
    - **Property 2: Accepting call joins both participants to same channel**
    - **Property 13: Ending call releases all resources**
    - **Validates: Requirements 1.3, 5.1, 5.2**

  - [ ]* 8.9 Write property test for error handling
    - **Property 28: SDK initialization failure prevents call initiation**
    - **Property 29: Channel join failure returns Failure type**
    - **Validates: Requirements 11.1, 11.2**

- [ ] 9. Checkpoint - Ensure all tests pass




  - Ensure all tests pass, ask the user if questions arise.


- [x] 10. Implement WebSocket signaling integration



  - [x] 10.1 Extend WebSocket service for call signaling


    - Add call invitation message type
    - Add call response message type
    - Add call ended message type
    - Integrate with existing WebSocketService
    - _Requirements: 9.4_

  - [x] 10.2 Implement call invitation sender


    - Send call invitation when createCall is called
    - Include callId, channelId, caller info, call type
    - _Requirements: 1.1_

  - [x] 10.3 Implement call invitation receiver


    - Listen for incoming call invitations
    - Trigger notification or UI update
    - Handle invitation timeout
    - _Requirements: 1.2, 9.3_

  - [ ]* 10.4 Write property test for signaling
    - **Property 14: End call sends notification to remote participant**
    - **Property 24: Expired invitations are cleaned up**
    - **Validates: Requirements 5.3, 9.3**

- [x] 11. Implement Presentation Layer - Riverpod providers




  - [x] 11.1 Create CallRepository provider


    - Define callRepositoryProvider using Riverpod code generation
    - Wire up all dependencies (AgoraService, TokenService, etc.)
    - _Requirements: 7.3_

  - [x] 11.2 Create CallNotifier with AsyncNotifier


    - Define CallNotifier extending AsyncNotifier<CallEntity?>
    - Implement build method returning null initially
    - _Requirements: 7.3_

  - [x] 11.3 Implement call action methods in CallNotifier


    - Implement initiateCall method
    - Implement acceptCall method
    - Implement rejectCall method
    - Implement endCall method
    - Handle AsyncValue states (loading, error, data)
    - _Requirements: 1.1, 1.2, 1.3, 5.1_

  - [x] 11.4 Implement media control methods in CallNotifier


    - Implement toggleMute method
    - Implement toggleVideo method
    - Implement switchCamera method
    - Update state after each action
    - _Requirements: 3.1, 3.2, 4.1_

  - [x] 11.5 Create network quality provider


    - Define networkQualityProvider as StreamProvider
    - Watch repository's network quality stream
    - _Requirements: 6.2_

  - [x] 11.6 Create call history provider


    - Define CallHistoryNotifier with AsyncNotifier
    - Implement methods to fetch and refresh history
    - _Requirements: 12.4_

  - [ ]* 11.7 Write property test for state management
    - **Property 9: UI state reflects media control changes**
    - **Property 16: Network quality changes update UI indicators**
    - **Validates: Requirements 3.5, 6.2**

- [x] 12. Implement UI components - Call screen





  - [x] 12.1 Create CallScreen widget


    - Create HookConsumerWidget for call screen
    - Watch callNotifierProvider
    - Use switch expression for AsyncValue states (loading, error, data)
    - Handle navigation and routing
    - _Requirements: 10.1, 10.2, 10.3_

  - [x] 12.2 Create video view widgets


    - Create RemoteVideoView widget using AgoraVideoView
    - Create LocalVideoPreview widget
    - Position local preview as overlay
    - Handle video call type only
    - _Requirements: 1.4_

  - [x] 12.3 Create CallControls widget


    - Create bottom control bar with buttons
    - Add mute/unmute button with icon toggle
    - Add video on/off button
    - Add camera switch button
    - Add end call button
    - Wire buttons to CallNotifier methods
    - _Requirements: 3.1, 3.2, 4.1, 5.1_

  - [x] 12.4 Create CallInfo widget


    - Display remote user name
    - Display call duration timer
    - Display network quality indicator
    - Show connection status
    - _Requirements: 6.1, 6.2, 10.4_

  - [x] 12.5 Create audio call UI

    - Create simplified UI for audio-only calls
    - Display participant avatars/names
    - Display call duration
    - Show audio controls only
    - _Requirements: 2.3_

  - [ ]* 12.6 Write property test for UI state
    - **Property 3: Video call UI contains both local and remote streams**
    - **Property 6: Audio-only calls have video disabled**
    - **Property 26: Participant information displayed in UI**
    - **Validates: Requirements 1.4, 2.2, 10.4**

- [x] 13. Implement incoming call notification UI





  - [x] 13.1 Create IncomingCallScreen widget


    - Display caller information
    - Show accept and reject buttons
    - Play ringtone (optional)
    - Handle accept action to join call
    - Handle reject action to dismiss
    - _Requirements: 1.2_

  - [x] 13.2 Integrate with navigation


    - Add route for incoming call screen
    - Navigate to incoming call screen when invitation received
    - Navigate to active call screen when accepted
    - _Requirements: 1.2, 1.3_

  - [ ]* 13.3 Write property test for invitation handling
    - **Property 2: Accepting call joins both participants to same channel**
    - **Property 23: Notification tap navigates to call screen**
    - **Validates: Requirements 1.3, 9.2**

- [x] 14. Implement background notifications





  - [x] 14.1 Add flutter_local_notifications dependency


    - Add package to pubspec.yaml
    - Configure Android notification channels
    - Configure iOS notification settings
    - _Requirements: 9.1_

  - [x] 14.2 Create NotificationService


    - Implement showIncomingCallNotification method
    - Implement dismissNotification method
    - Handle notification tap actions
    - _Requirements: 9.1, 9.2_

  - [x] 14.3 Integrate notifications with call invitations


    - Check app state when invitation received
    - Show notification if app is in background
    - Navigate to call screen on notification tap
    - Dismiss notification on timeout or answer
    - _Requirements: 9.1, 9.2, 9.3_

  - [ ]* 14.4 Write property test for background notifications
    - **Property 22: Background invitations trigger notifications**
    - **Validates: Requirements 9.1**

- [x] 15. Implement call history UI





  - [x] 15.1 Create CallHistoryScreen widget


    - Display list of call history entries
    - Show call type icon (audio/video)
    - Show call status (completed, missed, rejected)
    - Show timestamp and duration
    - Sort in reverse chronological order
    - _Requirements: 12.4_

  - [x] 15.2 Create CallHistoryItem widget


    - Display participant name and avatar
    - Display call metadata
    - Handle tap to show call back option
    - _Requirements: 12.5_

  - [x] 15.3 Implement call back functionality

    - Add call back button/action on history item tap
    - Initiate new call to the participant
    - _Requirements: 12.5_

  - [ ]* 15.4 Write property test for call history
    - **Property 33: Missed calls recorded in history**
    - **Property 35: History entry tap provides callback option**
    - **Validates: Requirements 12.2, 12.5**

- [x] 16. Implement error handling and user feedback





  - [x] 16.1 Create error display widgets


    - Create CallErrorView widget for error states
    - Display user-friendly error messages
    - Provide retry button where applicable
    - _Requirements: 11.1, 11.2_

  - [x] 16.2 Create permission request dialogs


    - Create dialog for camera permission denial
    - Create dialog for microphone permission denial
    - Provide button to open app settings
    - _Requirements: 11.3_

  - [x] 16.3 Implement network quality warnings


    - Display warning banner for poor network quality
    - Show reconnecting indicator
    - _Requirements: 6.3_

  - [x] 16.4 Implement logging for errors


    - Log all Failure objects with context
    - Log quality metrics
    - Log call events for debugging
    - _Requirements: 6.4, 11.5_

  - [ ]* 16.5 Write property test for error handling
    - **Property 30: Permission denial triggers appropriate UI**
    - **Property 31: Errors trigger logging**
    - **Validates: Requirements 11.3, 11.5**

- [x] 17. Platform-specific configuration





  - [x] 17.1 Configure Android


    - Add permissions to AndroidManifest.xml (CAMERA, RECORD_AUDIO, INTERNET)
    - Configure ProGuard rules for Agora SDK if needed
    - Test runtime permissions
    - _Requirements: 1.5, 2.4_

  - [x] 17.2 Configure iOS


    - Add usage descriptions to Info.plist (NSCameraUsageDescription, NSMicrophoneUsageDescription)
    - Configure background modes if needed
    - Test permissions on iOS device
    - _Requirements: 1.5, 2.4_

  - [x] 17.3 Configure Web (optional)


    - Test Agora SDK on web platform
    - Handle browser-specific permissions
    - _Requirements: 1.5, 2.4_

- [x] 18. Integration and UI polish





  - [x] 18.1 Integrate call buttons in chat/contact screens


    - Add video call button to chat header
    - Add audio call button to chat header
    - Wire buttons to CallNotifier.initiateCall
    - _Requirements: 1.1, 2.1_

  - [x] 18.2 Add call history to profile/settings


    - Add navigation to call history screen
    - Display recent calls count badge
    - _Requirements: 12.4_

  - [x] 18.3 Polish UI animations and transitions


    - Add smooth transitions between call states
    - Add button press animations
    - Add loading indicators
    - _Requirements: 10.3_

  - [x] 18.4 Handle device orientation changes


    - Test portrait and landscape modes
    - Adjust video view layouts
    - _Requirements: 10.5_

  - [ ]* 18.5 Write property test for orientation handling
    - **Property 27: Orientation changes trigger layout updates**
    - **Validates: Requirements 10.5**

- [ ] 19. Final checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.

- [ ] 20. End-to-end testing and bug fixes
  - [ ] 20.1 Test complete call flows
    - Test video call initiation, acceptance, and completion
    - Test audio call flows
    - Test call rejection
    - Test call timeout
    - _Requirements: 1.1, 1.2, 1.3, 2.1, 5.1_

  - [ ] 20.2 Test media controls
    - Test mute/unmute during calls
    - Test video on/off during calls
    - Test camera switching
    - _Requirements: 3.1, 3.2, 3.3, 3.4, 4.1, 4.2_

  - [ ] 20.3 Test error scenarios
    - Test permission denials
    - Test network disconnections
    - Test token expiration
    - Test SDK initialization failures
    - _Requirements: 11.1, 11.2, 11.3, 8.2, 8.5_

  - [ ] 20.4 Test call history
    - Test call history recording
    - Test missed call recording
    - Test call back functionality
    - _Requirements: 12.1, 12.2, 12.5_

  - [ ] 20.5 Fix any bugs discovered during testing
    - Address edge cases
    - Improve error messages
    - Optimize performance
