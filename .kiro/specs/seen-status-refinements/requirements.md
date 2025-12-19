# Requirements Document - Seen Status Refinements

## Introduction

Refine the seen status display to match Messenger's exact behavior: show avatar only on the last message, position avatar at bottom-right in chat list, remove "sent" checkmark, and fix unread count not updating when new messages arrive.

## Glossary

- **Last Message**: The most recent message in a conversation
- **Seen Avatar**: Small circular profile picture showing who read the message
- **Chat View**: The conversation screen showing all messages
- **Chat List**: The list of all conversations on home screen
- **Unread Count**: Badge showing number of unread messages
- **WebSocket**: Real-time connection for instant message delivery

## Requirements

### Requirement 1: Show Seen Avatar Only on Last Message

**User Story:** As a user, I want to see the seen avatar only on my most recent message, so that the chat view is cleaner and less cluttered.

#### Acceptance Criteria

1. WHEN viewing a conversation, THE System SHALL display the seen avatar only on the last message sent by the current user
2. WHEN there are multiple messages sent by the current user, THE System SHALL NOT display seen avatars on older messages
3. WHEN the last message is sent by someone else, THE System SHALL NOT display any seen avatar
4. THE System SHALL update the seen avatar position when a new message is sent

### Requirement 2: Position Avatar at Bottom-Right in Chat List

**User Story:** As a user, I want the seen avatar to appear at the bottom-right corner of the conversation item in the chat list, so that it's clearly visible and doesn't interfere with the message preview text.

#### Acceptance Criteria

1. WHEN viewing the chat list, THE System SHALL position the seen avatar at the bottom-right corner of the conversation item
2. THE Avatar SHALL be positioned below the message preview text
3. THE Avatar SHALL be aligned to the right edge of the conversation item
4. THE Avatar SHALL have appropriate spacing from the edges (8-12px padding)
5. THE Avatar SHALL not overlap with the message preview text or timestamp

### Requirement 3: Remove "Sent" Checkmark Indicator

**User Story:** As a user, I don't need to see a checkmark for sent messages, so that the interface is cleaner and matches Messenger's minimal design.

#### Acceptance Criteria

1. THE System SHALL NOT display any checkmark icon for sent but unread messages
2. WHEN a message is sent but not read, THE System SHALL display nothing (no indicator)
3. WHEN a message is read, THE System SHALL display only the reader's avatar
4. THE System SHALL maintain this behavior in both chat view and chat list

### Requirement 4: Fix Unread Count Not Updating on New Messages

**User Story:** As a user, I want to see the unread count badge update immediately when I receive a new message, so that I know there are new messages waiting.

#### Acceptance Criteria

1. WHEN a new message arrives via WebSocket, THE System SHALL increment the unread count for that conversation
2. WHEN the user is not viewing the conversation, THE System SHALL display the unread count badge
3. WHEN the user opens the conversation, THE System SHALL reset the unread count to zero
4. WHEN multiple messages arrive, THE System SHALL accumulate the unread count correctly
5. THE Unread count SHALL update in real-time without requiring app refresh
6. THE System SHALL handle WebSocket reconnection and sync unread counts correctly

### Requirement 5: WebSocket Message Handling

**User Story:** As a developer, I want the system to properly handle incoming WebSocket messages, so that unread counts and message lists update correctly.

#### Acceptance Criteria

1. WHEN a WebSocket message event is received, THE System SHALL parse the message data
2. WHEN the message is for a conversation the user is not viewing, THE System SHALL increment that conversation's unread count
3. WHEN the message is for the currently open conversation, THE System SHALL add the message to the list but NOT increment unread count
4. THE System SHALL update the conversation's lastMessage field with the new message
5. THE System SHALL move the conversation to the top of the chat list
6. THE System SHALL trigger a UI refresh to show the updated state

### Requirement 6: Conversation State Management

**User Story:** As a developer, I want proper state management for conversations, so that unread counts and message updates are reliable.

#### Acceptance Criteria

1. THE ConversationsNotifier SHALL listen to WebSocket message events
2. WHEN a new message arrives, THE ConversationsNotifier SHALL update the affected conversation
3. THE System SHALL maintain conversation order (most recent first)
4. THE System SHALL persist unread counts across app restarts (if applicable)
5. THE System SHALL handle edge cases (duplicate messages, out-of-order messages)

## Non-Functional Requirements

### Performance
- Unread count updates should be instant (< 100ms)
- No lag when scrolling through chat list
- Efficient WebSocket event handling

### Reliability
- Unread counts must be accurate
- No missed messages or incorrect counts
- Proper error handling for WebSocket failures

### User Experience
- Clean, minimal interface
- Consistent with Messenger design
- Smooth animations and transitions

## Out of Scope

- Read receipts privacy settings
- Message delivery status (single checkmark)
- Typing indicators
- Push notifications for new messages
- Desktop/web platform support (focus on mobile)

## Technical Notes

### Current Issues
1. **Seen avatar shows on all messages** - Need to filter to show only on last message
2. **Chat list avatar position** - Need to reposition to bottom-right
3. **Checkmark still showing** - Need to remove completely
4. **Unread count not updating** - Need to implement WebSocket listener in ConversationsNotifier

### Implementation Approach
1. Modify `BaseBubbleContainer` to accept `isLastMessage` parameter
2. Update `ChatViewPage` to determine which message is last
3. Modify `ConversationListItem` layout to position avatar at bottom-right
4. Remove checkmark rendering from `SeenStatusWidget`
5. Add WebSocket message listener to `ConversationsNotifier`
6. Implement unread count increment logic
7. Test with multiple scenarios (direct chat, group chat, multiple messages)
