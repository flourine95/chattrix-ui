# Requirements Document - User Notes/Stories Feature

## Introduction

Implement the User Notes/Stories feature that allows users to create and view short status updates displayed on their avatars in the online users list. This feature will use mock data initially until the backend API is available.

## Glossary

- **User Note/Story**: A short text status update (similar to Instagram/Facebook Stories) that appears above a user's avatar
- **My Story**: The current user's own note/story that they can create and edit
- **Note Dialog**: A dialog/modal for creating or editing the user's note
- **Mock Data**: Temporary local data storage until API is available
- **Online Users List**: Horizontal scrollable list showing online users with their notes
- **Note Expiry**: Optional feature where notes automatically expire after a set time (future enhancement)

## Requirements

### Requirement 1: Display User's Own Story

**User Story:** As a user, I want to see my own story item in the online users list, so that I can quickly access my note creation/editing.

#### Acceptance Criteria

1. WHEN the online users list is displayed THEN the system SHALL show "Your story" as the first item
2. WHEN the user has not created a note THEN the system SHALL display a "+" icon on the avatar
3. WHEN the user has created a note THEN the system SHALL display the note text above the avatar
4. WHEN the user taps "Your story" THEN the system SHALL open a dialog to create/edit their note
5. WHEN the avatar is displayed THEN the system SHALL use the current user's avatar image

### Requirement 2: Create/Edit Note Dialog

**User Story:** As a user, I want to create or edit my note through a simple dialog, so that I can quickly update my status.

#### Acceptance Criteria

1. WHEN the user taps "Your story" THEN the system SHALL display a dialog with a text input field
2. WHEN the dialog opens for a new note THEN the system SHALL show an empty text field with placeholder "What's on your mind?"
3. WHEN the dialog opens for editing THEN the system SHALL pre-fill the text field with the existing note
4. WHEN the user types in the text field THEN the system SHALL limit input to 60 characters
5. WHEN the user taps "Save" THEN the system SHALL save the note and close the dialog
6. WHEN the user taps "Cancel" or outside the dialog THEN the system SHALL close without saving
7. WHEN the user has an existing note THEN the system SHALL show a "Delete" button to remove the note

### Requirement 3: Display Other Users' Notes

**User Story:** As a user, I want to see notes from other online users, so that I can know what they're up to.

#### Acceptance Criteria

1. WHEN displaying an online user THEN the system SHALL show their note text above their avatar (if they have one)
2. WHEN a user has no note THEN the system SHALL only show their avatar and username
3. WHEN a note is too long THEN the system SHALL truncate it with ellipsis
4. WHEN the user taps an online user with a note THEN the system SHALL navigate to conversation with that user
5. WHEN displaying notes THEN the system SHALL use a small font size (10-12px) to fit above avatar

### Requirement 4: Mock Data Storage

**User Story:** As a developer, I want to use mock data for notes until the API is ready, so that the feature can be implemented and tested now.

#### Acceptance Criteria

1. WHEN the app starts THEN the system SHALL initialize mock note data for the current user and some online users
2. WHEN the user creates/edits a note THEN the system SHALL store it in local state (Riverpod provider)
3. WHEN the user deletes a note THEN the system SHALL remove it from local state
4. WHEN the app restarts THEN the system SHALL reset to default mock data (no persistence for now)
5. WHEN mock data is used THEN the system SHALL include clear TODO comments indicating where API calls should be added

### Requirement 5: UI/UX Design

**User Story:** As a user, I want the notes feature to match the modern design of the demo, so that the experience is polished and intuitive.

#### Acceptance Criteria

1. WHEN displaying "Your story" THEN the system SHALL use a circular avatar with a "+" icon overlay
2. WHEN displaying a note THEN the system SHALL show it in a small text label above the avatar
3. WHEN the note dialog opens THEN the system SHALL use a Material Design dialog with rounded corners
4. WHEN the user types in the dialog THEN the system SHALL show a character counter (e.g., "45/60")
5. WHEN displaying the online users list THEN the system SHALL maintain consistent spacing and alignment

### Requirement 6: Accessibility

**User Story:** As a user with accessibility needs, I want the notes feature to be fully accessible, so that I can use it with screen readers and keyboard navigation.

#### Acceptance Criteria

1. WHEN "Your story" is focused THEN the system SHALL announce "Your story. Double tap to add or edit your note."
2. WHEN an online user with a note is focused THEN the system SHALL announce "Username. Note: [note text]. Double tap to open conversation."
3. WHEN the note dialog opens THEN the system SHALL focus the text input field automatically
4. WHEN the dialog is open THEN the system SHALL support keyboard navigation (Tab, Enter, Escape)
5. WHEN the character limit is reached THEN the system SHALL announce "Character limit reached"

## Mock Data Structure

### User Note Model

```dart
class UserNote {
  final String userId;
  final String content;
  final DateTime createdAt;
  final DateTime? expiresAt; // Optional, for future use
  
  UserNote({
    required this.userId,
    required this.content,
    required this.createdAt,
    this.expiresAt,
  });
}
```

### Mock Data Examples

```dart
// Current user's note (initially null)
UserNote? myNote = null;

// Other users' notes
final mockNotes = {
  'user-123': UserNote(
    userId: 'user-123',
    content: 'Coding 💻',
    createdAt: DateTime.now(),
  ),
  'user-456': UserNote(
    userId: 'user-456',
    content: 'At the gym 💪',
    createdAt: DateTime.now(),
  ),
  'user-789': UserNote(
    userId: 'user-789',
    content: 'Lunch break 🍜',
    createdAt: DateTime.now(),
  ),
};
```

## Future API Integration

### Recommended API Endpoints

When the backend is ready, these endpoints should be implemented:

1. **Create/Update User Note**
   - `POST /v1/users/me/note`
   - Body: `{ "content": "My note text", "expiresAt": "2025-12-17T10:00:00Z" }`
   - Response: `{ "success": true, "data": { "id": "note-123", "content": "...", ... } }`

2. **Get User Note**
   - `GET /v1/users/{userId}/note`
   - Response: `{ "success": true, "data": { "id": "note-123", "content": "...", ... } }`

3. **Delete User Note**
   - `DELETE /v1/users/me/note`
   - Response: `{ "success": true, "message": "Note deleted" }`

4. **Get Online Users with Notes**
   - `GET /v1/users/online?includeNotes=true`
   - Response: `{ "success": true, "data": [{ "id": "...", "username": "...", "note": {...} }] }`

### Migration Path

1. Create note provider with mock data
2. Implement UI with mock data
3. Test thoroughly with mock data
4. When API is ready:
   - Replace mock data initialization with API calls
   - Update create/edit/delete methods to call API
   - Add error handling for API failures
   - Add loading states
   - Test with real API

## Technical Considerations

### State Management

- Use Riverpod provider for note state
- Use `StateNotifier` or `AsyncNotifier` for note management
- Keep mock data separate from business logic for easy API migration

### Performance

- Notes are small text strings, no performance concerns
- Consider caching notes to reduce API calls (future)
- Consider WebSocket updates for real-time note changes (future)

### Security

- Validate note content length (max 60 characters)
- Sanitize input to prevent XSS (if notes support HTML in future)
- Ensure users can only edit their own notes

### Testing

- Unit tests for note creation/editing/deletion logic
- Widget tests for note dialog UI
- Integration tests for note display in online users list
- Accessibility tests for screen reader support

## Notes

### Design Inspiration

- Instagram Stories: Short, ephemeral status updates
- Facebook Stories: Similar concept with text/media
- WhatsApp Status: Text-based status updates

### User Experience Goals

1. **Quick**: Creating a note should take < 10 seconds
2. **Simple**: Single text field, no complex options
3. **Discoverable**: "Your story" is prominently placed first
4. **Non-intrusive**: Notes are small and don't dominate the UI
5. **Fun**: Emoji support makes notes more expressive

### Known Limitations

1. **No Persistence**: Mock data resets on app restart
2. **No Expiry**: Notes don't automatically expire (future feature)
3. **No Media**: Text-only for now (future: images, videos)
4. **No Privacy**: All notes are visible to all users (future: privacy settings)
5. **No Reactions**: Users can't react to notes (future feature)

## Success Metrics

### User Engagement

- % of users who create at least one note
- Average number of notes created per user per day
- % of users who view others' notes

### Technical Metrics

- Note creation success rate
- Average time to create a note
- Dialog open/close performance

### Quality Metrics

- Zero crashes related to notes feature
- < 1% error rate for note operations
- 100% accessibility compliance
