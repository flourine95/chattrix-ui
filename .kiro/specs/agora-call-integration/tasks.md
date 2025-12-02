# Implementation Plan

- [x] 1. Set up domain layer entities and contracts




  - Create `lib/features/agora_call/domain/` directory structure
  - Define `CallEntity`, `CallConnectionEntity`, `CallInvitationEntity` with Freezed
  - Define `CallStatus` and `CallType` enums
  - Define `CallFailure` sealed class with all error cases
  - Create `AgoraCallRepository` interface
  - _Requirements: 9.1_

- [x] 2. Implement data layer models and DTOs





  - Create `lib/features/agora_call/data/models/` directory
  - Implement `CallModel` with JSON serialization
  - Implement `CallConnectionModel` with JSON serialization
  - Implement `CallInvitationModel` with JSON serialization
  - Add `toEntity()` extension methods for all models
  - _Requirements: 1.3, 2.1, 3.2_

- [x] 3. Implement remote data source for API communication





  - Create `AgoraCallRemoteDataSource` class
  - Implement `initiateCall()` method with Dio
  - Implement `acceptCall()` method with Dio
  - Implement `rejectCall()` method with Dio
  - Implement `endCall()` method with Dio
  - Add proper error handling for all methods
  - _Requirements: 1.1, 1.2, 3.1, 4.1, 6.1_

- [x] 4. Implement Agora SDK service wrapper





  - Create `AgoraEngineService` class
  - Implement `initialize()` method to create RTC engine
  - Implement `joinChannel()` method with token and channel ID
  - Implement `leaveChannel()` method
  - Implement `muteLocalAudio()` method
  - Implement `muteLocalVideo()` method
  - Implement `switchCamera()` method
  - Implement `registerEventHandlers()` method
  - Implement `dispose()` method for cleanup
  - _Requirements: 1.4, 5.3, 5.4, 5.5, 6.2, 6.3_

- [x] 5. Implement repository implementation





  - Create `AgoraCallRepositoryImpl` class
  - Inject `AgoraCallRemoteDataSource` dependency
  - Implement `initiateCall()` with Either error handling
  - Implement `acceptCall()` with Either error handling
  - Implement `rejectCall()` with Either error handling
  - Implement `endCall()` with Either error handling
  - Add `_handleDioError()` helper to map HTTP errors to domain failures
  - _Requirements: 1.1, 1.2, 3.1, 4.1, 6.1, 8.1, 9.4_

- [x] 6. Create Riverpod providers for dependency injection




  - Create `agoraCallRepositoryProvider` using @riverpod annotation
  - Create `agoraEngineServiceProvider` using @riverpod annotation
  - Create `ringtoneServiceProvider` for ringtone management
  - Run build_runner to generate provider code
  - _Requirements: 9.3_

- [x] 7. Implement call state management with Riverpod






  - Create `CallStateNotifier` extending `AsyncNotifier<CallEntity?>`
  - Implement `build()` method to initialize state and listen to WebSocket events
  - Implement `initiateCall()` method
  - Implement `acceptCall()` method
  - Implement `rejectCall()` method
  - Implement `endCall()` method
  - Implement `_listenToCallEvents()` to handle WebSocket messages
  - Implement `_handleIncomingCall()` for call.incoming events
  - Implement `_handleCallAccepted()` for call.accepted events
  - Implement `_handleCallRejected()` for call.rejected events
  - Implement `_handleCallEnded()` for call.ended events
  - Implement `_handleCallTimeout()` for call.timeout events
  - Implement `_handleQualityWarning()` for call.quality_warning events
  - _Requirements: 1.1, 1.2, 2.1, 3.1, 4.1, 6.1, 7.1, 7.2, 7.3, 7.4, 7.5, 9.3_

- [x] 8. Implement call controls state management




  - Create `CallControlsNotifier` extending `Notifier<CallControlsState>`
  - Define `CallControlsState` with isMuted, isVideoEnabled, isSpeakerOn flags
  - Implement `toggleMute()` method
  - Implement `toggleVideo()` method
  - Implement `toggleSpeaker()` method
  - Implement `switchCamera()` method
  - Integrate with `AgoraEngineService` for actual control actions
  - _Requirements: 5.3, 5.4, 5.5_

- [x] 9. Implement ringtone service




  - Create `RingtoneService` class using audioplayers package
  - Add ringtone audio file to `assets/sounds/` directory
  - Implement `play()` method to start ringtone
  - Implement `stop()` method to stop ringtone
  - Implement looping functionality
  - Handle audio focus and volume
  - _Requirements: 2.4_
- [x] 10. Implement permission service



- [ ] 10. Implement permission service

  - Create `PermissionService` class
  - Implement `requestCallPermissions()` method
  - Handle microphone permission for audio calls
  - Handle camera permission for video calls
  - Return boolean indicating if all permissions granted
  - Show permission rationale dialogs when needed
  - _Requirements: 8.2_
- [x] 11. Build OutgoingCallScreen UI



- [ ] 11. Build OutgoingCallScreen UI

  - Create `OutgoingCallScreen` as HookConsumerWidget
  - Display callee name and avatar
  - Show "Calling..." or "Ringing..." status text
  - Add cancel button to end call
  - Listen to call state changes
  - Navigate to ActiveCallScreen when call is accepted
  - Show error dialog when call is rejected or times out
  - Dismiss screen when call ends
  - _Requirements: 1.5, 7.2, 7.4_

- [x] 12. Build IncomingCallScreen UI




  - Create `IncomingCallScreen` as HookConsumerWidget
  - Display caller name and avatar
  - Show call type (audio/video) indicator
  - Add accept button (green)
  - Add reject button (red)
  - Start ringtone when screen appears
  - Stop ringtone when user responds
  - Handle accept action by calling provider method
  - Handle reject action by calling provider method
  - Auto-dismiss on timeout
  - _Requirements: 2.2, 2.3, 2.4, 3.5, 4.3_





- [ ] 13. Build ActiveCallScreen UI

  - Create `ActiveCallScreen` as HookConsumerWidget
  - Display remote user name and avatar
  - Show call duration timer
  - Add RemoteVideoView widget for video calls
  - Add LocalVideoPreview widget for video calls
  - Add CallControls widget with mute, video, speaker, camera switch buttons
  - Add end call button (red)


  - Show network quality indicator
  - Handle call.ended event to dismiss screen
  - Clean up Agora resources on dispose
  - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5, 6.4, 7.3_

- [x] 14. Build reusable call widgets


  - Create `RemoteVideoView` widget to display remote user's video stream
  - Create `LocalVideoPreview` widget to display local camera preview
  - Create `CallControls` widget with mute, video, speaker, camera switch buttons
  - Create `NetworkQualityIndicator` widget to show connection quality
  - Create `CallDurationTimer` widget to display elapsed time
  - Style all widgets according to app theme
  - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5, 7.5_
-

- [x] 15. Implement call initiation flow




  - Add call button to user profile or chat screen
  - Show call type selection dialog (audio/video)
  - Request permissions before initiating call
  - Call `initiateCall()` on CallStateNotifier
  - Navigate to OutgoingCallScreen on success
  - Show error message on failure
  - Join Agora channel with received credentials
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5_

- [x] 16. Implement call reception flow




  - Listen to call.incoming events in app-level listener
  - Show IncomingCallScreen when call invitation received
  - Start ringtone playback
  - Handle accept action: stop ringtone, call acceptCall(), join Agora channel
  - Handle reject action: stop ringtone, call rejectCall(), dismiss screen
  - Handle timeout: stop ringtone, dismiss screen
  - _Requirements: 2.1, 2.2, 2.3, 2.4, 3.1, 3.2, 3.3, 3.4, 4.1, 4.2_

- [x] 17. Implement call end flow




  - Handle end button press in ActiveCallScreen
  - Call `endCall()` on CallStateNotifier
  - Leave Agora channel immediately
  - Release all media resources
  - Display final call duration
  - Navigate back to previous screen
  - Clear call state
  - _Requirements: 6.1, 6.2, 6.3, 6.4, 6.5_

- [x] 18. Implement WebSocket event handling




  - Filter call.* events from rawMessageStream
  - Parse call.accepted events and update state to CONNECTED
  - Parse call.rejected events and show notification
  - Parse call.ended events and trigger cleanup
  - Parse call.timeout events and show notification
  - Parse call.quality_warning events and show banner
  - _Requirements: 7.1, 7.2, 7.3, 7.4, 7.5_
-

- [x] 19. Implement error handling and recovery



  - Handle API errors with user-friendly messages
  - Handle Agora SDK errors with notification and cleanup
  - Handle WebSocket disconnection with reconnection attempt
  - Show quality warnings without terminating call
  - Auto-reject incoming calls when user is busy
  - Handle permission denied errors
  - _Requirements: 8.1, 8.2, 8.3, 8.4, 8.5_

- [x] 20. Implement security measures





  - Ensure JWT token is included in all API request headers
  - Use unique Agora token for each call session
  - Clear all tokens from memory when call ends
  - Verify HTTPS is used for all API calls
  - Verify WSS is used for WebSocket connection
  - Never log or persist sensitive tokens
  - _Requirements: 10.1, 10.2, 10.3, 10.5_
- [x] 21. Add platform-specific configurations




- [ ] 21. Add platform-specific configurations

  - Add camera and microphone permissions to AndroidManifest.xml
  - Add camera and microphone usage descriptions to iOS Info.plist
  - Configure Agora SDK for Android in build.gradle
  - Configure Agora SDK for iOS in Podfile
  - Test permissions on both platforms
  - _Requirements: 8.2_
- [x] 22. Integrate with existing app navigation




- [ ] 22. Integrate with existing app navigation

  - Add call screen routes to go_router configuration
  - Handle deep linking for incoming calls
  - Handle app backgrounding during active call
  - Handle app foregrounding with active call
  - Ensure proper navigation stack management
  - _Requirements: 1.5, 2.2, 3.4, 6.4_

- [x] 23. Add call quality monitoring




  - Listen to Agora network quality events
  - Update NetworkQualityIndicator based on quality metrics
  - Show warning banner when quality degrades
  - Log quality metrics for debugging
  - _Requirements: 7.5, 8.4_


- [x] 24. Implement edge case handling



  - Handle multiple rapid incoming calls (keep most recent, reject others)
  - Handle call events received in wrong order
  - Handle WebSocket disconnection during active call (Agora continues)
  - Handle app termination during active call
  - Handle device rotation during video call
  - _Requirements: 2.5, 8.3, 8.5_
- [x] 25. Final integration and cleanup




- [ ] 25. Final integration and cleanup

  - Run build_runner to generate all code
  - Fix any compilation errors
  - Verify all imports are correct
  - Remove any debug logging
  - Ensure proper resource disposal
  - Test complete call flow end-to-end
  - _Requirements: All_
