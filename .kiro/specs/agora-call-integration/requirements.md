# Requirements Document

## Introduction

This document specifies the requirements for implementing audio and video calling functionality in the Chattrix UI application. The feature enables users to initiate, accept, reject, and manage real-time voice and video calls using the Agora SDK, integrated with the Chattrix backend API and WebSocket messaging system. This implementation will be a new feature separate from any existing call functionality.

## Glossary

- **Call System**: The complete audio/video calling subsystem within Chattrix UI
- **Caller**: The user who initiates a call
- **Callee**: The user who receives a call invitation
- **Call Session**: An active connection between two users for audio or video communication
- **Agora SDK**: Third-party real-time communication SDK used for media streaming
- **WebSocket Channel**: Persistent bidirectional communication channel for real-time events
- **Call Token**: Authentication token provided by the backend for joining an Agora channel
- **Channel ID**: Unique identifier for an Agora communication channel
- **Call State**: Current status of a call (INITIATING, RINGING, CONNECTING, CONNECTED, REJECTED, ENDED)

## Requirements

### Requirement 1

**User Story:** As a user, I want to initiate audio or video calls to other users, so that I can communicate with them in real-time.

#### Acceptance Criteria

1. WHEN a user selects another user and chooses to start an audio call, THEN the Call System SHALL send an initiate request to the backend with call type AUDIO
2. WHEN a user selects another user and chooses to start a video call, THEN the Call System SHALL send an initiate request to the backend with call type VIDEO
3. WHEN the backend responds successfully to an initiate request, THEN the Call System SHALL receive a call ID, channel ID, and Agora token
4. WHEN the Call System receives connection credentials, THEN the Call System SHALL join the Agora channel using the provided token and channel ID
5. WHEN joining the Agora channel, THEN the Call System SHALL display a calling screen with the callee's information

### Requirement 2

**User Story:** As a user, I want to receive incoming call notifications, so that I can decide whether to accept or reject calls.

#### Acceptance Criteria

1. WHEN the WebSocket Channel receives a call.incoming event, THEN the Call System SHALL extract the call invitation payload containing caller information
2. WHEN a call invitation is received, THEN the Call System SHALL display an incoming call screen showing the caller's name and avatar
3. WHEN displaying the incoming call screen, THEN the Call System SHALL provide accept and reject action buttons
4. WHEN an incoming call screen is displayed, THEN the Call System SHALL play a ringtone sound until the user responds or the call times out
5. WHEN multiple incoming calls arrive, THEN the Call System SHALL handle only the most recent call and auto-reject previous pending calls

### Requirement 3

**User Story:** As a callee, I want to accept incoming calls, so that I can communicate with the caller.

#### Acceptance Criteria

1. WHEN a user presses the accept button on an incoming call, THEN the Call System SHALL send an accept request to the backend with the call ID
2. WHEN the backend responds successfully to an accept request, THEN the Call System SHALL receive an Agora token for the callee
3. WHEN the callee receives connection credentials, THEN the Call System SHALL join the Agora channel using the provided token
4. WHEN the callee joins the channel, THEN the Call System SHALL transition to an active call screen
5. WHEN the callee accepts a call, THEN the Call System SHALL stop playing the ringtone

### Requirement 4

**User Story:** As a callee, I want to reject incoming calls, so that I can decline unwanted communications.

#### Acceptance Criteria

1. WHEN a user presses the reject button on an incoming call, THEN the Call System SHALL send a reject request to the backend with the call ID and a reason
2. WHEN the reject request is sent, THEN the Call System SHALL close the incoming call screen immediately
3. WHEN a user rejects a call, THEN the Call System SHALL stop playing the ringtone
4. WHEN the backend processes the rejection, THEN the Call System SHALL not join any Agora channel

### Requirement 5

**User Story:** As a user in an active call, I want to see and control call features, so that I can manage my communication experience.

#### Acceptance Criteria

1. WHEN a call is in CONNECTED state, THEN the Call System SHALL display the remote user's video stream for video calls
2. WHEN a call is in CONNECTED state, THEN the Call System SHALL display call duration timer
3. WHEN a call is active, THEN the Call System SHALL provide controls for muting/unmuting the microphone
4. WHEN a video call is active, THEN the Call System SHALL provide controls for enabling/disabling the camera
5. WHEN a video call is active, THEN the Call System SHALL provide a control for switching between front and rear cameras

### Requirement 6

**User Story:** As a user in an active call, I want to end the call, so that I can terminate the communication when finished.

#### Acceptance Criteria

1. WHEN a user presses the end call button, THEN the Call System SHALL send an end request to the backend with the call ID
2. WHEN the end request is sent, THEN the Call System SHALL leave the Agora channel immediately
3. WHEN leaving the Agora channel, THEN the Call System SHALL release all media resources including camera and microphone
4. WHEN the call ends, THEN the Call System SHALL close the call screen and return to the previous screen
5. WHEN the call ends, THEN the Call System SHALL display the final call duration

### Requirement 7

**User Story:** As a user, I want to receive real-time call state updates, so that I know the current status of my calls.

#### Acceptance Criteria

1. WHEN the WebSocket Channel receives a call.accepted event, THEN the Call System SHALL update the call state to CONNECTED for the caller
2. WHEN the WebSocket Channel receives a call.rejected event, THEN the Call System SHALL display a rejection notification and close the calling screen
3. WHEN the WebSocket Channel receives a call.ended event, THEN the Call System SHALL leave the Agora channel and close the call screen
4. WHEN the WebSocket Channel receives a call.timeout event, THEN the Call System SHALL display a timeout notification and close the calling screen
5. WHEN the WebSocket Channel receives a call.quality_warning event, THEN the Call System SHALL display a network quality warning to the user

### Requirement 8

**User Story:** As a user, I want the call system to handle errors gracefully, so that I have a reliable calling experience.

#### Acceptance Criteria

1. WHEN the backend returns an error for an initiate request, THEN the Call System SHALL display an appropriate error message to the user
2. WHEN the Agora SDK fails to join a channel, THEN the Call System SHALL notify the user and send an end request to the backend
3. WHEN the WebSocket connection is lost during a call, THEN the Call System SHALL attempt to reconnect and notify the user of connection issues
4. WHEN network conditions degrade during a call, THEN the Call System SHALL display a quality warning without terminating the call
5. WHEN a user is already in a call and receives another call invitation, THEN the Call System SHALL auto-reject the new call with reason "busy"

### Requirement 9

**User Story:** As a developer, I want the call feature to follow Clean Architecture principles, so that the codebase is maintainable and testable.

#### Acceptance Criteria

1. WHEN implementing call entities, THEN the Call System SHALL define them in the domain layer without framework dependencies
2. WHEN implementing call data sources, THEN the Call System SHALL create repository implementations in the data layer
3. WHEN implementing call business logic, THEN the Call System SHALL use Riverpod providers with code generation
4. WHEN handling call state, THEN the Call System SHALL use Either type from dartz for error handling
5. WHEN implementing call UI, THEN the Call System SHALL use HookConsumerWidget for all call screens

### Requirement 10

**User Story:** As a user, I want my call data to be secure, so that my communications remain private.

#### Acceptance Criteria

1. WHEN initiating or accepting calls, THEN the Call System SHALL include the JWT authentication token in all API requests
2. WHEN receiving Agora tokens, THEN the Call System SHALL use them only for the specific call session
3. WHEN a call ends, THEN the Call System SHALL clear all call-related tokens from memory
4. WHEN storing call history, THEN the Call System SHALL not persist sensitive call tokens
5. WHEN transmitting call data, THEN the Call System SHALL use secure HTTPS and WSS protocols
