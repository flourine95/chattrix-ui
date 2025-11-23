# Requirements Document

## Introduction

This document defines the requirements for fixing critical issues in the Chattrix UI call system where call invitations are not being delivered to recipients and where multiple users initiating calls simultaneously end up in different channels. The fix will ensure proper WebSocket signaling integration and channel synchronization between caller and callee.

## Glossary

- **Call System**: The complete video/audio calling feature within Chattrix UI
- **WebSocket Service**: Real-time bidirectional communication service for signaling
- **Call Signaling**: The process of exchanging call control messages (invitation, accept, reject, end) between participants
- **Channel ID**: A unique identifier for an Agora channel where participants communicate
- **Caller**: The user who initiates a call
- **Callee**: The user who receives a call invitation
- **Call Invitation**: A WebSocket message sent from caller to callee to initiate a call
- **Call State Provider**: Riverpod provider managing call state and logic
- **Incoming Call Listener**: UI component that listens for and displays incoming call notifications
- **Backend API**: The Jakarta EE server that manages call metadata and WebSocket routing

## Requirements

### Requirement 1

**User Story:** As a caller, I want the callee to receive my call invitation immediately, so that they can respond to my call request.

#### Acceptance Criteria

1. WHEN a caller initiates a call THEN the Call System SHALL send a call invitation message through the WebSocket Service to the callee
2. WHEN the Backend API receives a call initiation request THEN the Backend API SHALL broadcast a `call_invitation` message to the callee's WebSocket connection
3. WHEN the callee's WebSocket Service receives a `call_invitation` message THEN the Call System SHALL parse the message and extract call metadata
4. WHEN call metadata is extracted THEN the Call System SHALL display an incoming call screen to the callee within 500 milliseconds
5. WHEN the WebSocket connection is not established THEN the Call System SHALL prevent call initiation and display an error message

### Requirement 2

**User Story:** As a callee, I want to see who is calling me with their profile information, so that I can decide whether to accept the call.

#### Acceptance Criteria

1. WHEN a `call_invitation` message arrives THEN the Call System SHALL display the caller's name, avatar, and call type
2. WHEN the incoming call screen is displayed THEN the Call System SHALL provide accept and reject buttons
3. WHEN the callee is already in another call THEN the Call System SHALL automatically reject the new invitation with reason "busy"
4. WHEN the incoming call screen is displayed THEN the Call System SHALL play a ringtone sound
5. WHEN 60 seconds elapse without response THEN the Call System SHALL automatically dismiss the incoming call screen

### Requirement 3

**User Story:** As a caller and callee, I want to join the same Agora channel, so that we can communicate in the same virtual room.

#### Acceptance Criteria

1. WHEN a caller initiates a call THEN the Call System SHALL generate a unique channel ID using the format `channel_{timestamp}_{callerId}_{calleeId}`
2. WHEN the Backend API creates a call record THEN the Backend API SHALL store the channel ID in the database
3. WHEN the Backend API sends a `call_invitation` message THEN the message SHALL include the channel ID from the call record
4. WHEN the callee accepts the call THEN the Call System SHALL use the channel ID from the invitation message to join the Agora channel
5. WHEN both participants join THEN the Agora RTC Engine SHALL connect them to the same channel using the identical channel ID

### Requirement 4

**User Story:** As a callee, I want to accept an incoming call, so that I can join the conversation with the caller.

#### Acceptance Criteria

1. WHEN the callee taps the accept button THEN the Call System SHALL send a `call.accept` message through the WebSocket Service
2. WHEN the Backend API receives a `call.accept` message THEN the Backend API SHALL update the call status to "ACTIVE" in the database
3. WHEN the call status is updated THEN the Backend API SHALL broadcast a `call_accepted` message to the caller's WebSocket connection
4. WHEN the callee accepts the call THEN the Call System SHALL request an Agora token from the Backend API using the channel ID from the invitation
5. WHEN the Agora token is received THEN the Call System SHALL join the Agora channel and navigate to the active call screen

### Requirement 5

**User Story:** As a callee, I want to reject an incoming call, so that I can decline unwanted conversations.

#### Acceptance Criteria

1. WHEN the callee taps the reject button THEN the Call System SHALL send a `call.reject` message through the WebSocket Service with a reason
2. WHEN the Backend API receives a `call.reject` message THEN the Backend API SHALL update the call status to "REJECTED" in the database
3. WHEN the call status is updated THEN the Backend API SHALL broadcast a `call_rejected` message to the caller's WebSocket connection
4. WHEN the caller receives a `call_rejected` message THEN the Call System SHALL dismiss the waiting screen and display a rejection notification
5. WHEN the callee rejects the call THEN the Call System SHALL dismiss the incoming call screen without joining the Agora channel

### Requirement 6

**User Story:** As a caller, I want to know when the callee accepts or rejects my call, so that I understand the call status.

#### Acceptance Criteria

1. WHEN the caller initiates a call THEN the Call System SHALL display a waiting screen showing "Calling {calleeName}..."
2. WHEN the caller's WebSocket Service receives a `call_accepted` message THEN the Call System SHALL dismiss the waiting screen
3. WHEN the `call_accepted` message is received THEN the Call System SHALL join the Agora channel using the same channel ID
4. WHEN the caller's WebSocket Service receives a `call_rejected` message THEN the Call System SHALL display the rejection reason
5. WHEN the caller's WebSocket Service receives a `call_timeout` message THEN the Call System SHALL dismiss the waiting screen and show "No answer"

### Requirement 7

**User Story:** As a user, I want the call system to handle WebSocket reconnections gracefully, so that temporary network issues don't break call functionality.

#### Acceptance Criteria

1. WHEN the WebSocket connection is lost during call initiation THEN the Call System SHALL attempt to reconnect automatically
2. WHEN the WebSocket reconnects successfully THEN the Call System SHALL re-subscribe to call signaling messages
3. WHEN the WebSocket connection fails after 3 retry attempts THEN the Call System SHALL display an error message
4. WHEN a call is active and WebSocket disconnects THEN the Call System SHALL maintain the Agora connection for audio/video
5. WHEN the WebSocket reconnects during an active call THEN the Call System SHALL resume signaling without disrupting media streams

### Requirement 8

**User Story:** As a developer, I want proper integration between the Call System and WebSocket Service, so that signaling messages are reliably delivered.

#### Acceptance Criteria

1. THE Call System SHALL inject the WebSocket Service via Riverpod dependency injection
2. THE Call System SHALL listen to the WebSocket Service's message stream for call-related events
3. WHEN sending signaling messages THEN the Call System SHALL use the WebSocket Service's `sendMessage` method
4. THE Call System SHALL filter WebSocket messages by type to handle only call-related messages
5. THE Call System SHALL NOT create multiple WebSocket connections for call signaling

### Requirement 9

**User Story:** As a user, I want to end an active call, so that I can terminate the conversation when finished.

#### Acceptance Criteria

1. WHEN a user taps the end call button THEN the Call System SHALL send a `call.end` message through the WebSocket Service
2. WHEN the Backend API receives a `call.end` message THEN the Backend API SHALL update the call status to "ENDED" in the database
3. WHEN the call status is updated THEN the Backend API SHALL broadcast a `call_ended` message to all participants
4. WHEN a participant receives a `call_ended` message THEN the Call System SHALL leave the Agora channel and release resources
5. WHEN the call ends THEN the Call System SHALL navigate both participants back to the previous screen

### Requirement 10

**User Story:** As a developer, I want comprehensive logging for call signaling, so that I can debug issues effectively.

#### Acceptance Criteria

1. WHEN a call invitation is sent THEN the Call System SHALL log the channel ID, callee ID, and call type
2. WHEN a WebSocket message is received THEN the Call System SHALL log the message type and payload
3. WHEN joining an Agora channel THEN the Call System SHALL log the channel ID, token (first 20 characters), and UID
4. WHEN a signaling error occurs THEN the Call System SHALL log the error message and stack trace
5. THE Call System SHALL use the existing CallLogger utility for all logging operations

### Requirement 11

**User Story:** As a user, I want the call system to prevent race conditions when multiple users call each other simultaneously, so that calls are handled predictably.

#### Acceptance Criteria

1. WHEN User A calls User B while User B is calling User A THEN the Backend API SHALL detect the race condition
2. WHEN a race condition is detected THEN the Backend API SHALL accept only the first call request and reject the second
3. WHEN the second call is rejected THEN the Backend API SHALL send a `call_rejected` message with reason "already_in_call"
4. WHEN a user receives a call while initiating a call THEN the Call System SHALL prioritize the incoming call
5. WHEN the race condition is resolved THEN both users SHALL join the same channel from the accepted call

### Requirement 12

**User Story:** As a user, I want call invitations to timeout automatically, so that I'm not stuck waiting indefinitely for a response.

#### Acceptance Criteria

1. WHEN a call invitation is sent THEN the Backend API SHALL set a timeout of 60 seconds
2. WHEN 60 seconds elapse without acceptance THEN the Backend API SHALL update the call status to "TIMEOUT"
3. WHEN the call times out THEN the Backend API SHALL broadcast a `call_timeout` message to both participants
4. WHEN the caller receives a `call_timeout` message THEN the Call System SHALL dismiss the waiting screen
5. WHEN the callee receives a `call_timeout` message THEN the Call System SHALL dismiss the incoming call screen

### Requirement 13

**User Story:** As a developer, I want the Incoming Call Listener to be properly integrated into the app navigation, so that call invitations are received on all screens.

#### Acceptance Criteria

1. THE Call System SHALL wrap the main app navigation with the Incoming Call Listener widget
2. THE Incoming Call Listener SHALL listen to the WebSocket Service's message stream continuously
3. WHEN a `call_invitation` message is received THEN the Incoming Call Listener SHALL display a full-screen incoming call overlay
4. WHEN the user accepts or rejects the call THEN the Incoming Call Listener SHALL dismiss the overlay
5. THE Incoming Call Listener SHALL NOT interfere with existing navigation or UI interactions

### Requirement 14

**User Story:** As a user, I want to receive visual and audio feedback during call state transitions, so that I understand what's happening.

#### Acceptance Criteria

1. WHEN initiating a call THEN the Call System SHALL display a loading indicator and "Connecting..." message
2. WHEN waiting for the callee to respond THEN the Call System SHALL display "Calling {calleeName}..." with an animated indicator
3. WHEN the callee accepts THEN the Call System SHALL display "Connecting to call..." before joining the channel
4. WHEN joining the Agora channel fails THEN the Call System SHALL display an error message with a retry option
5. WHEN the call connects successfully THEN the Call System SHALL hide all loading indicators and show the call interface

### Requirement 15

**User Story:** As a developer, I want proper error handling for all signaling operations, so that failures are gracefully managed.

#### Acceptance Criteria

1. WHEN sending a WebSocket message fails THEN the Call System SHALL return a `Failure` object with error details
2. WHEN the Backend API returns an error response THEN the Call System SHALL parse the error and display a user-friendly message
3. WHEN the Agora token request fails THEN the Call System SHALL prevent joining the channel and display an error
4. WHEN any signaling error occurs THEN the Call System SHALL clean up resources and reset the call state
5. THE Call System SHALL use the `Either<Failure, T>` pattern for all asynchronous operations
