# Requirements Document

## Introduction

This feature refactors the incoming call handling mechanism from an overlay-based approach (using `IncomingCallListener` widget wrapper) to a pure route-based approach using GoRouter. The current implementation uses a widget wrapper in the MaterialApp builder that listens to incoming calls and pushes a route, which can cause issues with navigation state management and lifecycle. The new approach will integrate incoming call handling directly into the routing system for better reliability and maintainability.

## Glossary

- **IncomingCallListener**: The current widget wrapper that listens to incoming call invitations and navigates to the incoming call screen
- **GoRouter**: The declarative routing package used by the Flutter application
- **Route-based approach**: Navigation pattern where routes are defined declaratively and navigation is handled through the router configuration
- **Overlay-based approach**: Navigation pattern where UI elements are rendered on top of existing screens using widget wrappers
- **CallInvitationData**: Data model containing information about an incoming call (caller ID, name, avatar, call type)
- **IncomingCallProvider**: Riverpod provider that manages the current incoming call invitation state
- **App Lifecycle**: The state of the application (foreground, background, paused, resumed)

## Requirements

### Requirement 1

**User Story:** As a user, I want incoming calls to be handled reliably through the routing system, so that call notifications work consistently without navigation issues.

#### Acceptance Criteria

1. WHEN an incoming call invitation is received THEN the system SHALL navigate to the incoming call route using the router configuration
2. WHEN the app is in the foreground and receives a call THEN the system SHALL immediately display the incoming call screen
3. WHEN the app transitions from background to foreground with a pending call THEN the system SHALL display the incoming call screen
4. WHEN a user accepts or rejects a call THEN the system SHALL navigate back using proper router navigation
5. WHEN multiple incoming calls arrive in sequence THEN the system SHALL handle each call's navigation state independently

### Requirement 2

**User Story:** As a developer, I want to remove the IncomingCallListener widget wrapper, so that the app architecture is cleaner and more maintainable.

#### Acceptance Criteria

1. WHEN the app initializes THEN the system SHALL NOT include IncomingCallListener in the MaterialApp builder
2. WHEN incoming call logic is needed THEN the system SHALL use router-level listeners or redirects
3. WHEN the codebase is reviewed THEN the IncomingCallListener widget file SHALL be removed
4. WHEN the main.dart file is reviewed THEN the builder property SHALL only contain ToastOverlay
5. WHEN navigation occurs THEN the system SHALL use GoRouter's declarative routing without widget wrappers

### Requirement 3

**User Story:** As a user, I want the incoming call screen to integrate seamlessly with the app's navigation stack, so that back button behavior and navigation history work correctly.

#### Acceptance Criteria

1. WHEN a user presses the back button on the incoming call screen THEN the system SHALL treat it as a call rejection
2. WHEN the incoming call screen is displayed THEN the system SHALL be part of the normal navigation stack
3. WHEN a call times out or is rejected THEN the system SHALL properly clean up the navigation state
4. WHEN navigating away from the incoming call screen THEN the system SHALL clear the incoming call provider state
5. WHEN the app is killed and restarted THEN the system SHALL NOT show stale incoming call screens

### Requirement 4

**User Story:** As a developer, I want incoming call routing to handle app lifecycle states correctly, so that calls are displayed appropriately when the app is in foreground or background.

#### Acceptance Criteria

1. WHEN the app is in the foreground and receives a call THEN the system SHALL immediately navigate to the incoming call route
2. WHEN the app is in the background and receives a call THEN the system SHALL store the invitation without navigating
3. WHEN the app resumes from background with a pending invitation THEN the system SHALL navigate to the incoming call route
4. WHEN the app lifecycle state changes THEN the system SHALL check for pending invitations
5. WHEN a call invitation expires THEN the system SHALL clear the pending invitation state

### Requirement 5

**User Story:** As a user, I want the incoming call screen to maintain all existing functionality, so that accepting, rejecting, and timeout behavior work exactly as before.

#### Acceptance Criteria

1. WHEN the incoming call screen is displayed THEN the system SHALL show caller information, avatar, and call type
2. WHEN a user taps accept THEN the system SHALL initiate the call and navigate to the call screen
3. WHEN a user taps reject THEN the system SHALL send rejection signal and navigate back
4. WHEN 60 seconds elapse THEN the system SHALL auto-reject with timeout reason and navigate back
5. WHEN the ringtone plays THEN the system SHALL stop it when the screen is dismissed or call is answered
