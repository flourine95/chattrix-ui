# Requirements Document

## Introduction

This document specifies requirements for optimizing the Chattrix Flutter application to eliminate main thread blocking that causes frame drops and UI jank. The system currently performs heavy operations (JSON parsing, secure storage access, and frequent polling) on the main thread, resulting in "Skipped frames" warnings and degraded user experience.

## Glossary

- **Main Thread**: The UI thread in Flutter responsible for rendering frames and handling user interactions
- **Isolate**: A separate execution context in Dart that runs independently with its own memory heap
- **Frame Drop**: When the application fails to render a frame within the 16.67ms budget (60 FPS)
- **ChatWebSocketService**: The service responsible for managing WebSocket connections and message handling
- **AuthInterceptor**: The Dio interceptor that handles JWT token management for HTTP requests
- **MessagesNotifier**: The Riverpod state notifier that manages chat message state
- **FlutterSecureStorage**: The plugin used for storing sensitive data like JWT tokens
- **JSON Parsing**: The process of converting JSON strings into Dart objects

## Requirements

### Requirement 1

**User Story:** As a user, I want the chat interface to remain smooth and responsive, so that I can read and send messages without experiencing lag or stuttering.

#### Acceptance Criteria

1. WHEN the system receives WebSocket messages THEN the system SHALL parse JSON data in a background isolate to avoid blocking the main thread
2. WHEN the system parses message models from JSON THEN the system SHALL complete the operation without causing frame drops on the main thread
3. WHEN the system handles multiple rapid WebSocket messages THEN the system SHALL maintain 60 FPS rendering performance
4. WHEN the system decodes large JSON payloads THEN the system SHALL use compute() to offload work from the main thread
5. WHEN the system converts models to entities THEN the system SHALL perform the conversion in the background isolate before returning to the main thread

### Requirement 2

**User Story:** As a user, I want network requests to complete quickly without freezing the UI, so that I can navigate and interact with the app smoothly.

#### Acceptance Criteria

1. WHEN the system reads JWT tokens from secure storage THEN the system SHALL cache tokens in memory to avoid repeated disk access
2. WHEN the system writes JWT tokens to secure storage THEN the system SHALL perform the write operation asynchronously without blocking the main thread
3. WHEN the system adds authorization headers to requests THEN the system SHALL retrieve tokens from the in-memory cache
4. WHEN the system refreshes JWT tokens THEN the system SHALL update both secure storage and the in-memory cache
5. WHEN the system clears tokens on logout THEN the system SHALL clear both secure storage and the in-memory cache

### Requirement 3

**User Story:** As a user, I want the chat list to update automatically when new messages arrive, so that I can see new conversations without manually refreshing.

#### Acceptance Criteria

1. WHEN the system receives WebSocket updates THEN the system SHALL rely on WebSocket events instead of polling
2. WHEN the system detects a WebSocket disconnection THEN the system SHALL fall back to polling until reconnection
3. WHEN the system is connected via WebSocket THEN the system SHALL disable periodic polling to reduce unnecessary network requests
4. WHEN the system reconnects to WebSocket THEN the system SHALL re-enable event-driven updates and disable polling
5. WHEN the system receives a message via WebSocket THEN the system SHALL update the UI state without triggering a full data refresh

### Requirement 4

**User Story:** As a user, I want the chat message list to scroll smoothly, so that I can read through conversation history without lag.

#### Acceptance Criteria

1. WHEN the system renders message bubbles THEN the system SHALL use const constructors where possible to reduce widget rebuilds
2. WHEN the system displays a long message list THEN the system SHALL implement proper list view optimization with appropriate cache extent
3. WHEN the system updates message state THEN the system SHALL use selective widget rebuilds to avoid re-rendering the entire list
4. WHEN the system displays media attachments THEN the system SHALL lazy-load images and videos outside the viewport
5. WHEN the system renders replied messages THEN the system SHALL cache the lookup results to avoid repeated searches

### Requirement 5

**User Story:** As a developer, I want clear performance metrics and debugging tools, so that I can identify and fix performance bottlenecks.

#### Acceptance Criteria

1. WHEN the system performs heavy operations THEN the system SHALL log execution time for operations exceeding 16ms
2. WHEN the system uses background isolates THEN the system SHALL log isolate creation and message passing overhead
3. WHEN the system experiences frame drops THEN the system SHALL provide actionable error messages identifying the cause
4. WHEN the system runs in debug mode THEN the system SHALL display performance overlays showing FPS and frame timing
5. WHEN the system completes optimization THEN the system SHALL demonstrate consistent 60 FPS performance during typical usage
