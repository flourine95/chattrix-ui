# Requirements Document

## Introduction

This spec addresses a bug where voting on a poll creates a duplicate poll message in the chat. Currently, when a user votes on a poll, the WebSocket event handler creates a new message instead of updating the existing poll message, resulting in multiple poll instances appearing in the chat.

## Glossary

- **Poll Message**: A message of type 'POLL' that displays a poll in the chat
- **Poll Vote Event**: A WebSocket event triggered when any user votes on a poll
- **Messages Notifier**: The Riverpod state manager that handles the list of messages in a conversation
- **Poll Entity**: The domain entity representing a poll with its current state (votes, options, etc.)

## Requirements

### Requirement 1: Update Existing Poll on Vote

**User Story:** As a user, when I vote on a poll, I want to see the poll update in place without creating duplicate poll messages, so that the chat remains clean and organized.

#### Acceptance Criteria

1. WHEN a poll vote event is received via WebSocket, THE Messages_Notifier SHALL update the existing poll message with the new poll data
2. WHEN updating a poll message, THE Messages_Notifier SHALL preserve the original message ID and creation timestamp
3. WHEN a poll is updated, THE Messages_Notifier SHALL NOT create a new message in the messages list
4. WHEN multiple users vote on the same poll, THE Messages_Notifier SHALL update the same poll message instance for each vote

### Requirement 2: Maintain Poll State Consistency

**User Story:** As a user, I want to see accurate and up-to-date poll results, so that I can make informed voting decisions.

#### Acceptance Criteria

1. WHEN a poll is updated, THE Messages_Notifier SHALL replace the poll data with the latest poll entity from the WebSocket event
2. WHEN a poll message is updated, THE System SHALL preserve all other message properties (sender info, reactions, etc.)
3. WHEN no matching poll message exists, THE Messages_Notifier SHALL log a warning and skip the update

### Requirement 3: Handle Poll Lifecycle Events

**User Story:** As a user, I want polls to behave correctly throughout their lifecycle (creation, voting, closing, deletion), so that the chat experience is reliable.

#### Acceptance Criteria

1. WHEN a poll is created, THE Messages_Notifier SHALL add a new poll message to the messages list
2. WHEN a poll is closed, THE Messages_Notifier SHALL update all instances of that poll in the messages list
3. WHEN a poll is deleted, THE Messages_Notifier SHALL remove all instances of that poll from the messages list
4. WHEN a poll vote event is received, THE Messages_Notifier SHALL only update the poll data without changing message position
