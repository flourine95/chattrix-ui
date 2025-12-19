# Requirements Document - Messenger-Style Seen Status

## Introduction

Update the seen status display to show avatars instead of text, following Messenger's design pattern. This provides a more visual and intuitive way to see who has read messages.

## Glossary

- **Seen Status**: Visual indicator showing who has read a message
- **Avatar**: Small circular profile picture of a user
- **Read Receipt**: Information about when and by whom a message was read
- **Message Bubble**: Container displaying a chat message
- **Chat View**: The conversation screen showing messages
- **Chat List**: The list of all conversations

## Requirements

### Requirement 1: Avatar-Based Seen Status in Chat View

**User Story:** As a user, I want to see small avatars of people who read my messages, so that I can quickly identify who has seen them without reading text.

#### Acceptance Criteria

1. WHEN a message is read in a direct chat, THE System SHALL display the reader's avatar at the bottom-right corner of the message bubble
2. WHEN a message is read in a group chat by one person, THE System SHALL display that person's avatar at the bottom-right corner
3. WHEN a message is read in a group chat by multiple people, THE System SHALL display up to 3 avatars stacked/overlapped at the bottom-right corner
4. WHEN a message is read by more than 3 people in a group, THE System SHALL display 3 avatars with a "+X" indicator
5. WHEN a message is not yet read, THE System SHALL display a grey checkmark icon instead of avatars
6. THE System SHALL only display seen status for messages sent by the current user

### Requirement 2: Avatar Positioning and Styling

**User Story:** As a user, I want the seen avatars to be positioned like Messenger, so that the interface feels familiar and professional.

#### Acceptance Criteria

1. THE Avatar SHALL be positioned at the bottom-right corner of the message bubble, slightly overlapping the bubble edge
2. THE Avatar SHALL be small (16-20px diameter) to not distract from the message content
3. WHEN multiple avatars are shown, THE System SHALL stack them horizontally with slight overlap (each subsequent avatar offset by 12px)
4. THE Avatar SHALL have a white border (2px) to separate it from the message bubble background
5. THE Avatar SHALL be circular with proper clipping
6. WHEN the avatar image fails to load, THE System SHALL display a fallback with the user's initials

### Requirement 3: Sent Status Indicator

**User Story:** As a user, I want to see a clear indicator when my message is sent but not yet read, so that I know the delivery status.

#### Acceptance Criteria

1. WHEN a message is sent but not read, THE System SHALL display a grey checkmark icon at the bottom-right corner
2. THE Checkmark icon SHALL be the same size as the avatar (16-20px)
3. THE Checkmark SHALL use a subtle grey color to indicate "sent but not seen" status
4. WHEN the message transitions from sent to seen, THE System SHALL replace the checkmark with the reader's avatar

### Requirement 4: Chat List Seen Status

**User Story:** As a user, I want to see a small avatar in the chat list for read messages, so that I can quickly scan which conversations have been seen.

#### Acceptance Criteria

1. WHEN the last message in a conversation is sent by the current user and has been read, THE System SHALL display a small avatar next to the message preview
2. THE Avatar in chat list SHALL be smaller than in chat view (12-14px diameter)
3. WHEN the last message is sent but not read, THE System SHALL display a grey checkmark
4. FOR group chats with multiple readers, THE System SHALL display the first reader's avatar with a "+X" text indicator

### Requirement 5: Interactive Seen Status

**User Story:** As a user, I want to tap on the seen avatars to see full details of who read the message and when, so that I can get complete read receipt information.

#### Acceptance Criteria

1. WHEN a user taps on the seen avatars in a group chat, THE System SHALL display a bottom sheet with the full list of readers
2. THE Bottom sheet SHALL show each reader's avatar, full name, and read time
3. THE Bottom sheet SHALL be scrollable if there are many readers
4. WHEN a user taps on the seen avatar in a direct chat, THE System SHALL optionally show the read time in a tooltip
5. THE Bottom sheet SHALL have a close button or swipe-down gesture to dismiss

### Requirement 6: Performance and Optimization

**User Story:** As a developer, I want the avatar loading to be efficient, so that the chat performance remains smooth.

#### Acceptance Criteria

1. THE System SHALL cache avatar images to avoid repeated network requests
2. THE System SHALL use lazy loading for avatars in long conversation lists
3. WHEN scrolling quickly, THE System SHALL prioritize loading avatars in the visible viewport
4. THE System SHALL use placeholder avatars while images are loading
5. THE System SHALL handle missing or broken avatar URLs gracefully with fallback initials

## Non-Functional Requirements

### Performance
- Avatar images should load within 200ms on good network
- No noticeable lag when scrolling through messages
- Smooth transition animation when status changes from sent to seen

### Accessibility
- Avatar images should have proper semantic labels for screen readers
- Sufficient color contrast for checkmark icons
- Tap targets should be at least 44x44 points for interactive elements

### Compatibility
- Works on both iOS and Android
- Supports dark and light themes
- Handles different screen sizes and densities

## Out of Scope

- Typing indicators
- Message delivery status (single checkmark)
- Read receipts for media messages (already handled)
- Disabling read receipts (privacy settings)
