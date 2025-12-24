# Requirements Document

## Introduction

This document defines the requirements for the Poll Management feature in the Chattrix UI application. The feature enables users to create, vote on, view, and manage polls within conversations, providing an interactive way for groups to make decisions and gather opinions.

## Glossary

- **Poll_System**: The complete poll management subsystem
- **Poll**: A question with multiple choice options that users can vote on
- **Poll_Creator**: The user who creates a poll
- **Voter**: A user who casts a vote on a poll
- **Option**: A single choice within a poll that users can vote for
- **Conversation**: A chat room or direct message thread where polls are created
- **Active_Poll**: A poll that is not closed and not expired
- **WebSocket_Service**: Real-time communication service for poll updates

## Requirements

### Requirement 1: Create Poll

**User Story:** As a conversation participant, I want to create polls with multiple options, so that I can gather opinions from other participants.

#### Acceptance Criteria

1. WHEN a user creates a poll, THE Poll_System SHALL validate that the question is between 1 and 500 characters
2. WHEN a user creates a poll, THE Poll_System SHALL validate that there are between 2 and 10 options
3. WHEN a user creates a poll, THE Poll_System SHALL validate that each option is between 1 and 200 characters
4. WHEN a user creates a poll, THE Poll_System SHALL require the allowMultipleVotes setting to be specified
5. WHEN a user creates a poll with an expiration date, THE Poll_System SHALL validate that the date is in ISO datetime format
6. WHEN a poll is successfully created, THE Poll_System SHALL return the complete poll data including all options with zero votes
7. WHEN a poll is successfully created, THE WebSocket_Service SHALL broadcast a POLL_CREATED event to all conversation participants
8. WHEN a user attempts to create a poll with invalid data, THE Poll_System SHALL return validation errors with specific field messages

### Requirement 2: Vote on Poll

**User Story:** As a conversation participant, I want to vote on polls, so that I can express my opinion on the question.

#### Acceptance Criteria

1. WHEN a user votes on a single-choice poll, THE Poll_System SHALL accept exactly one option ID
2. WHEN a user votes on a multiple-choice poll, THE Poll_System SHALL accept one or more option IDs
3. WHEN a user votes on a poll, THE Poll_System SHALL update the vote counts and percentages for all options
4. WHEN a user votes again on a poll, THE Poll_System SHALL replace their previous vote with the new vote
5. WHEN a user votes on a poll, THE WebSocket_Service SHALL broadcast a POLL_VOTED event to all conversation participants
6. WHEN a user attempts to vote on an inactive poll, THE Poll_System SHALL reject the vote and return an error
7. WHEN a user attempts to vote on a closed poll, THE Poll_System SHALL reject the vote and return an error
8. WHEN a user attempts to vote on an expired poll, THE Poll_System SHALL reject the vote and return an error
9. WHEN a user attempts to vote with multiple options on a single-choice poll, THE Poll_System SHALL reject the vote and return a validation error

### Requirement 3: Remove Vote

**User Story:** As a voter, I want to remove my vote from a poll, so that I can change my mind or abstain from voting.

#### Acceptance Criteria

1. WHEN a user removes their vote, THE Poll_System SHALL update the vote counts and percentages for all affected options
2. WHEN a user removes their vote, THE Poll_System SHALL remove their user ID from the voters list
3. WHEN a user removes their vote, THE WebSocket_Service SHALL broadcast a POLL_VOTED event to all conversation participants
4. WHEN a user attempts to remove a vote from an inactive poll, THE Poll_System SHALL reject the action and return an error

### Requirement 4: View Poll Details

**User Story:** As a conversation participant, I want to view poll details including current results, so that I can see how others have voted.

#### Acceptance Criteria

1. WHEN a user requests poll details, THE Poll_System SHALL return the complete poll data including question, options, and creator information
2. WHEN a user requests poll details, THE Poll_System SHALL return the current vote counts and percentages for each option
3. WHEN a user requests poll details, THE Poll_System SHALL return the list of voters for each option
4. WHEN a user requests poll details, THE Poll_System SHALL indicate which options the current user has voted for
5. WHEN a user requests poll details, THE Poll_System SHALL indicate whether the poll is active, closed, or expired
6. WHEN a user requests details for a non-existent poll, THE Poll_System SHALL return a 404 error

### Requirement 5: List Conversation Polls

**User Story:** As a conversation participant, I want to see all polls in a conversation, so that I can review past and current polls.

#### Acceptance Criteria

1. WHEN a user requests polls for a conversation, THE Poll_System SHALL return polls sorted by creation date in descending order
2. WHEN a user requests polls for a conversation, THE Poll_System SHALL support pagination with page and size parameters
3. WHEN a user requests polls for a conversation, THE Poll_System SHALL return pagination metadata including total count and page information
4. WHEN a user requests polls for a conversation, THE Poll_System SHALL include complete poll data for each poll in the list
5. WHEN a user requests polls with pagination, THE Poll_System SHALL indicate whether there are next and previous pages available

### Requirement 6: Close Poll

**User Story:** As a poll creator, I want to close my poll manually, so that I can end voting when I have enough responses.

#### Acceptance Criteria

1. WHEN a poll creator closes a poll, THE Poll_System SHALL set the isClosed flag to true
2. WHEN a poll creator closes a poll, THE Poll_System SHALL set the isActive flag to false
3. WHEN a poll creator closes a poll, THE WebSocket_Service SHALL broadcast a POLL_CLOSED event to all conversation participants
4. WHEN a non-creator attempts to close a poll, THE Poll_System SHALL reject the action and return a 403 Forbidden error
5. WHEN a user attempts to close an already closed poll, THE Poll_System SHALL return an appropriate error message

### Requirement 7: Delete Poll

**User Story:** As a poll creator, I want to delete my poll, so that I can remove polls that are no longer relevant.

#### Acceptance Criteria

1. WHEN a poll creator deletes a poll, THE Poll_System SHALL remove the poll and all associated votes from the system
2. WHEN a poll creator deletes a poll, THE WebSocket_Service SHALL broadcast a POLL_DELETED event to all conversation participants
3. WHEN a non-creator attempts to delete a poll, THE Poll_System SHALL reject the action and return a 403 Forbidden error
4. WHEN a user attempts to delete a non-existent poll, THE Poll_System SHALL return a 404 error

### Requirement 8: Real-time Poll Updates

**User Story:** As a conversation participant, I want to see poll updates in real-time, so that I can see voting results as they happen.

#### Acceptance Criteria

1. WHEN a poll is created, THE WebSocket_Service SHALL send a POLL_CREATED event with complete poll data to all conversation participants
2. WHEN a vote is cast or removed, THE WebSocket_Service SHALL send a POLL_VOTED event with updated poll data to all conversation participants
3. WHEN a poll is closed, THE WebSocket_Service SHALL send a POLL_CLOSED event with updated poll data to all conversation participants
4. WHEN a poll is deleted, THE WebSocket_Service SHALL send a POLL_DELETED event with poll ID and conversation ID to all conversation participants
5. WHEN a WebSocket event is received, THE Poll_System SHALL update the UI immediately without requiring a page refresh

### Requirement 9: Poll Expiration Handling

**User Story:** As a poll creator, I want to set an expiration date for my poll, so that voting automatically ends at a specific time.

#### Acceptance Criteria

1. WHEN a poll reaches its expiration date, THE Poll_System SHALL set the isExpired flag to true
2. WHEN a poll reaches its expiration date, THE Poll_System SHALL set the isActive flag to false
3. WHEN a poll has no expiration date set, THE Poll_System SHALL allow voting indefinitely until manually closed
4. WHEN displaying a poll, THE Poll_System SHALL calculate and display whether the poll is expired based on the current time
5. WHEN a user attempts to vote on an expired poll, THE Poll_System SHALL reject the vote

### Requirement 10: Poll Validation and Error Handling

**User Story:** As a user, I want clear error messages when poll operations fail, so that I understand what went wrong and how to fix it.

#### Acceptance Criteria

1. WHEN validation fails, THE Poll_System SHALL return a 400 error with specific field-level error messages
2. WHEN authentication is missing, THE Poll_System SHALL return a 401 error with an appropriate message
3. WHEN authorization fails, THE Poll_System SHALL return a 403 error indicating the user lacks permission
4. WHEN a resource is not found, THE Poll_System SHALL return a 404 error with a clear message
5. WHEN a business rule is violated, THE Poll_System SHALL return a 400 error with a descriptive message
6. WHEN a network error occurs, THE Poll_System SHALL display a user-friendly error message
7. WHEN the server returns an unexpected error, THE Poll_System SHALL display a generic error message and log the details

### Requirement 11: Poll UI Display

**User Story:** As a conversation participant, I want to see poll results visually, so that I can quickly understand the voting distribution.

#### Acceptance Criteria

1. WHEN displaying poll options, THE Poll_System SHALL show vote counts and percentages for each option
2. WHEN displaying poll options, THE Poll_System SHALL show visual progress bars representing the percentage of votes
3. WHEN displaying poll options, THE Poll_System SHALL highlight options that the current user has voted for
4. WHEN displaying a poll, THE Poll_System SHALL indicate whether the poll allows multiple votes
5. WHEN displaying a poll, THE Poll_System SHALL show the poll creator's information
6. WHEN displaying a poll, THE Poll_System SHALL show the total number of voters
7. WHEN displaying a poll, THE Poll_System SHALL show the expiration date if one is set
8. WHEN displaying a poll, THE Poll_System SHALL visually indicate whether the poll is active, closed, or expired
9. WHEN displaying an active poll, THE Poll_System SHALL show voting controls (radio buttons for single-choice, checkboxes for multiple-choice)
10. WHEN displaying an inactive poll, THE Poll_System SHALL disable voting controls

### Requirement 12: Authentication and Authorization

**User Story:** As a system, I want to ensure only authenticated users can interact with polls, so that poll data remains secure.

#### Acceptance Criteria

1. WHEN a user attempts any poll operation, THE Poll_System SHALL require a valid JWT token in the Authorization header
2. WHEN a user attempts to close a poll, THE Poll_System SHALL verify the user is the poll creator
3. WHEN a user attempts to delete a poll, THE Poll_System SHALL verify the user is the poll creator
4. WHEN a user attempts to vote on a poll, THE Poll_System SHALL verify the user is a participant in the conversation
5. WHEN a user attempts to view polls, THE Poll_System SHALL verify the user is a participant in the conversation
