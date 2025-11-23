# Implementation Plan

- [x] 1. Update backend API to generate and return channel ID





  - Modify `/v1/calls/initiate` endpoint to generate channel ID using format `channel_{timestamp}_{callerId}_{calleeId}`
  - Return channel ID in API response
  - Store channel ID in database call record
  - _Requirements: 3.1, 3.2_
-

- [x] 2. Update backend WebSocket routing for call invitations



  - When call is created, broadcast `call_invitation` message to callee's WebSocket connection
  - Include all required fields: callId, channelId, callerId, callerName, callerAvatar, callType
  - _Requirements: 1.2, 3.3_


- [x] 3. Add WebSocket connection validation to CallStateProvider



  - Inject CallSignalingService into CallStateProvider
  - Add connection state check before initiating calls
  - Throw WebSocketNotConnectedException if not connected
  - _Requirements: 1.5, 8.1_

- [ ]* 3.1 Write property test for WebSocket connection validation
  - **Property 1: WebSocket invitation delivery**
  - **Validates: Requirements 1.1, 8.3**

- [x] 4. Integrate WebSocket signaling into call initiation flow





  - After successful REST API call creation, send WebSocket invitation
  - Use backend-provided channel ID from API response
  - Pass all required parameters to sendCallInvitation method
  - Add error handling for WebSocket send failures
  - _Requirements: 1.1, 8.3_

- [ ]* 4.1 Write property test for call invitation message format
  - **Property 2: Call invitation parsing completeness**
  - **Validates: Requirements 1.3**
-

- [x] 5. Update CallSignalingService message format




  - Ensure message format matches backend expectations
  - Use correct field names and types (callType: "VIDEO" vs "video")
  - Add isConnected getter for connection state checking
  - _Requirements: 8.3_
-

- [x] 6. Create IncomingCallProvider to listen to signaling service




  - Create new Riverpod provider that watches CallSignalingService
  - Subscribe to callInvitationStream
  - Manage incoming call state (current invitation)
  - Provide clearInvitation method
  - _Requirements: 8.2_

- [ ]* 6.1 Write unit test for IncomingCallProvider stream subscription
  - Verify provider subscribes to signaling service stream
  - **Validates: Requirements 8.2**

- [x] 7. Update IncomingCallListener to use IncomingCallProvider





  - Watch currentIncomingCallProvider instead of direct signaling service
  - Navigate to incoming call screen with invitation data
  - Handle foreground/background states appropriately
  - _Requirements: 13.2, 13.3_

- [ ]* 7.1 Write property test for caller information display
  - **Property 3: Caller information display**
  - **Validates: Requirements 2.1**
-

- [x] 8. Fix IncomingCallScreen to use invitation channel ID




  - Extract channel ID from CallInvitation parameter
  - Pass invitation's channel ID to acceptCall method (not generated)
  - Update reject logic to send WebSocket message
  - Display caller name, avatar, and call type from invitation
  - _Requirements: 2.1, 3.4, 4.4_

- [ ]* 8.1 Write property test for channel ID consistency
  - **Property 6: Channel ID consistency across participants**
  - **Validates: Requirements 3.4, 4.4, 6.3**


- [x] 9. Implement accept call flow with proper channel ID




  - Update CallStateProvider.acceptCall to use provided channel ID
  - Request Agora token with invitation's channel ID
  - Join Agora channel with correct channel ID
  - Send call.accept WebSocket message
  - _Requirements: 4.1, 4.4, 4.5_

- [ ]* 9.1 Write property test for accept message transmission
  - **Property 7: Accept message transmission**
  - **Validates: Requirements 4.1**

- [x] 10. Implement reject call flow with WebSocket signaling





  - Update reject logic to send call.reject message with reason
  - Ensure no Agora token request or channel join on rejection
  - Clear incoming call state
  - _Requirements: 5.1, 5.5_

- [ ]* 10.1 Write property test for reject message transmission
  - **Property 8: Reject message transmission with reason**
  - **Validates: Requirements 5.1**

- [ ]* 10.2 Write property test for no Agora join on rejection
  - **Property 9: No Agora join on rejection**
  - **Validates: Requirements 5.5**


- [x] 11. Implement busy call auto-rejection




  - Check if call is already active when invitation arrives
  - Automatically send call.reject with reason "busy"
  - Don't display incoming call screen
  - _Requirements: 2.3_

- [ ]* 11.1 Write property test for busy call rejection
  - **Property 4: Busy call rejection**
  - **Validates: Requirements 2.3**

- [x] 12. Implement end call flow with WebSocket signaling




  - Send call.end message with call ID and duration
  - Leave Agora channel and cleanup resources
  - Update call state to null
  - _Requirements: 9.1, 9.4_

- [ ]* 12.1 Write property test for end call message transmission
  - **Property 10: End call message transmission**
  - **Validates: Requirements 9.1**

- [x] 13. Implement WebSocket message filtering




  - Update CallSignalingService.handleIncomingMessage to filter by type
  - Process only call-related messages (call_invitation, call_accepted, call_rejected, call_ended, call_timeout)
  - Ignore non-call messages silently
  - _Requirements: 8.4_

- [ ]* 13.1 Write property test for message filtering
  - **Property 11: WebSocket message filtering**
  - **Validates: Requirements 8.4**


- [x] 14. Implement incoming call prioritization for race conditions



  - Detect when user is initiating call and receives invitation simultaneously
  - Cancel outgoing call
  - Prioritize and display incoming call
  - _Requirements: 11.4_

- [ ]* 14.1 Write property test for incoming call prioritization
  - **Property 13: Incoming call prioritization**
  - **Validates: Requirements 11.4**


- [x] 15. Add comprehensive logging for all call operations



  - Log call initiation with callId, channelId, calleeId, callType
  - Log WebSocket messages received with type and payload
  - Log Agora channel join with channelId, token (first 20 chars), uid
  - Log all errors with message and stack trace
  - Use CallLogger utility for all logging
  - _Requirements: 10.1, 10.2, 10.3, 10.4_

- [ ]* 15.1 Write property test for comprehensive logging
  - **Property 14: Comprehensive logging**
  - **Validates: Requirements 10.1, 10.2, 10.3, 10.4**

- [x] 16. Implement error handling with Either<Failure, T> pattern





  - Return Failure objects for WebSocket send failures
  - Parse and return Failure for API errors
  - Handle token request failures with Failure
  - Cleanup resources on any signaling error
  - _Requirements: 15.1, 15.2, 15.3, 15.4_

- [ ]* 16.1 Write property test for error handling
  - **Property 15: Error handling with Failure type**
  - **Validates: Requirements 15.1, 15.2, 15.4**
-

- [x] 17. Add channel ID format validation




  - Validate backend-provided channel IDs match expected format
  - Log warning if format doesn't match pattern `channel_{timestamp}_{userId1}_{userId2}`
  - _Requirements: 3.1_

- [ ]* 17.1 Write property test for channel ID format validation
  - **Property 5: Channel ID format validation**
  - **Validates: Requirements 3.1**
-

- [x] 18. Implement Agora connection independence from WebSocket



  - Ensure Agora RTC connection remains active when WebSocket disconnects
  - Don't disconnect Agora when WebSocket connection is lost
  - Continue media streaming during WebSocket reconnection
  - _Requirements: 7.4_

- [ ]* 18.1 Write property test for Agora independence
  - **Property 12: Agora independence from WebSocket**
  - **Validates: Requirements 7.4**

- [x] 19. Add UI feedback for call state transitions




  - Display "Connecting..." when initiating call
  - Display "Calling {calleeName}..." while waiting for response
  - Display "Connecting to call..." when callee accepts
  - Display error message with retry option on Agora join failure
  - Hide loading indicators when call connects successfully
  - _Requirements: 14.1, 14.2, 14.3, 14.4, 14.5_


- [x] 20. Handle call response messages (accepted, rejected, timeout)




  - Listen to call_accepted messages and join Agora channel
  - Listen to call_rejected messages and display rejection reason
  - Listen to call_timeout messages and dismiss waiting screen
  - _Requirements: 6.2, 6.3, 6.4, 6.5, 12.4, 12.5_



- [ ] 21. Add ringtone playback for incoming calls

  - Play ringtone sound when incoming call screen is displayed

  - Stop ringtone when call is accepted or rejected
  - _Requirements: 2.4_

- [ ] 22. Implement 60-second timeout for incoming calls


  - Start timer when incoming call screen is displayed
  - Auto-dismiss screen after 60 seconds
  - _Requirements: 2.5_

- [x] 23. Checkpoint - Ensure all tests pass





  - Run all unit tests and property tests
  - Fix any failing tests
  - Verify all core functionality works
  - Ask the user if questions arise

- [ ] 24. Integration testing with backend
  - Test full call flow: initiate → invite → accept → join → end
  - Test rejection flow: initiate → invite → reject
  - Test timeout flow: initiate → invite → timeout
  - Test race condition: both users call simultaneously
  - Test WebSocket reconnection during call
  - _Requirements: All_

- [ ]* 24.1 Write integration tests for call flows
  - Test full call flow with channel synchronization
  - Test rejection flow
  - Test timeout flow
  - Test race condition handling

- [ ] 25. Manual testing and bug fixes
  - Test on real devices with two users
  - Verify call invitations are received
  - Verify both users join same Agora channel
  - Verify audio/video works correctly
  - Fix any issues found during testing
  - _Requirements: All_

- [ ] 26. Final checkpoint - Ensure all tests pass
  - Run complete test suite
  - Verify all acceptance criteria are met
  - Ask the user if questions arise
