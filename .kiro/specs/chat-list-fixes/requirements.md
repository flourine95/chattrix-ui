# Requirements Document - Chat List Fixes & UI Improvements

## Introduction

This spec documents the fixes and improvements made to the ChatListPage to resolve API integration issues and align the UI with the English design standards. The work focused on fixing conversation loading errors caused by API response structure mismatches and improving the UI by moving the create button to the AppBar.

## Glossary

- **ChatListPage**: Main conversation list screen with API integration
- **Conversation**: Chat conversation (DIRECT or GROUP type)
- **Paginated Response**: API response structure with nested data: `{ data: { data: [...], page, size, total } }`
- **AppBar**: Top navigation bar containing title and action buttons
- **FAB (FloatingActionButton)**: Floating button typically positioned at bottom-right
- **Filter**: Conversation filter (All, Unread, Groups)
- **Online Users**: Horizontal scrollable list of currently online users

## Requirements

### Requirement 1: Fix Conversation Loading Error

**User Story:** As a user, I want the conversation list to load successfully after login, so that I can see my chats without errors.

#### Acceptance Criteria

1. WHEN the ChatListPage fetches conversations from `/v1/conversations` THEN the system SHALL correctly parse the paginated response structure `{ data: { data: [...], page, size, total } }`
2. WHEN the API returns a paginated response THEN the system SHALL extract the conversations array from `response.data['data']['data']`
3. WHEN conversations are successfully parsed THEN the system SHALL display them in the conversation list without type cast errors
4. WHEN the search API returns results THEN the system SHALL use the same parsing logic for consistency
5. WHEN parsing fails THEN the system SHALL throw a ServerException with a descriptive error message

**Technical Details:**
- **Root Cause**: Code expected `response.data['data']` to be a List, but API returns nested structure
- **Solution**: Access `paginatedData['data']` to get the actual conversations array
- **Files Modified**: `lib/features/chat/data/datasources/chat_remote_datasource_impl.dart`
- **Methods Updated**: `getConversations()`, `searchConversations()`

### Requirement 2: Move Create Button to AppBar

**User Story:** As a user, I want the create chat button in the top-right corner of the AppBar, so that I can easily start new conversations without a floating button blocking content.

#### Acceptance Criteria

1. WHEN the ChatListPage renders THEN the system SHALL display a "New chat" IconButton in the AppBar actions
2. WHEN the create button is displayed THEN the system SHALL use the `message-circle-plus.svg` icon with primary color
3. WHEN the user taps the create button THEN the system SHALL navigate to `/new-chat` route
4. WHEN the AppBar is rendered THEN the system SHALL NOT display a FloatingActionButton at the bottom-right
5. WHEN the create button is focused THEN the system SHALL display the tooltip "New chat"

**Technical Details:**
- **Removed**: `FloatingActionButton` from Scaffold
- **Removed**: `_AnimatedFAB` widget class (no longer needed)
- **Added**: IconButton in AppBar `actions` with SVG icon
- **Files Modified**: `lib/features/chat/presentation/pages/chat_list_page.dart`

### Requirement 3: English UI Labels

**User Story:** As a user, I want all UI text in English, so that the interface is consistent with the app's language standards.

#### Acceptance Criteria

1. WHEN displaying filter chips THEN the system SHALL use English labels: "All", "Unread", "Groups"
2. WHEN displaying the user's story item THEN the system SHALL show "Your story" instead of "Tin của bạn"
3. WHEN displaying empty states THEN the system SHALL use English messages
4. WHEN displaying error messages THEN the system SHALL use English text
5. WHEN providing accessibility labels THEN the system SHALL use English descriptions

**Technical Details:**
- **Filter Labels Changed**:
  - "Tất cả" → "All"
  - "Chưa đọc" → "Unread"
  - "Nhóm" → "Groups"
- **Story Label Changed**: "Tin của bạn" → "Your story"
- **Files Modified**: `lib/features/chat/presentation/pages/chat_list_page.dart`

### Requirement 4: Clean Code Structure

**User Story:** As a developer, I want unused code removed, so that the codebase is maintainable and easy to understand.

#### Acceptance Criteria

1. WHEN reviewing the code THEN the system SHALL NOT contain unused widget classes
2. WHEN reviewing the code THEN the system SHALL NOT contain unused variables
3. WHEN reviewing the code THEN the system SHALL NOT contain commented-out code
4. WHEN reviewing the code THEN the system SHALL follow the project's coding standards
5. WHEN building the app THEN the system SHALL NOT produce warnings about unused code

**Technical Details:**
- **Removed**: `_AnimatedFAB` widget class (entire class deleted)
- **Removed**: Unused `primary` variable
- **Removed**: `floatingActionButton` property from Scaffold
- **Files Modified**: `lib/features/chat/presentation/pages/chat_list_page.dart`

## Implementation Summary

### Files Modified

1. **lib/features/chat/data/datasources/chat_remote_datasource_impl.dart**
   - Fixed `getConversations()` method to parse paginated response
   - Fixed `searchConversations()` method to parse paginated response
   - Added proper error logging with AppLogger

2. **lib/features/chat/presentation/pages/chat_list_page.dart**
   - Removed FloatingActionButton from bottom-right
   - Added "New chat" IconButton to AppBar actions
   - Changed filter labels to English
   - Changed "Your story" label to English
   - Removed unused `_AnimatedFAB` widget class
   - Removed unused `primary` variable

### Testing Results

- ✅ No compilation errors after changes
- ✅ Conversation list loads successfully after login
- ✅ Search functionality works with paginated responses
- ✅ Create button appears in AppBar top-right
- ✅ All UI text is in English
- ✅ No unused code warnings

## Future Enhancements

### Potential Improvements

1. **Error Handling**: Add more specific error messages for different API failure scenarios
2. **Loading States**: Improve loading indicators during conversation fetch
3. **Retry Logic**: Add automatic retry for failed API calls
4. **Offline Support**: Cache conversations for offline viewing
5. **Performance**: Implement virtual scrolling for large conversation lists

### API Considerations

1. **Pagination**: Current implementation uses default pagination parameters
   - Consider adding "Load More" functionality for large conversation lists
   - Consider implementing infinite scroll

2. **Real-time Updates**: WebSocket integration is in place
   - Monitor for any issues with real-time conversation updates
   - Ensure proper handling of WebSocket reconnection

3. **Search Optimization**: Current search uses the same endpoint as conversation list
   - Consider debouncing search queries to reduce API calls
   - Consider adding search history or suggestions

## Notes

### Design Decisions

1. **AppBar vs FAB**: Moved create button to AppBar for better UX
   - Reasoning: FAB can block content and is less discoverable
   - AppBar placement is more consistent with modern chat apps
   - Follows user's explicit preference

2. **English UI**: All labels converted to English
   - Reasoning: Matches project's language standards
   - Improves consistency across the app
   - Aligns with demo design reference

3. **Paginated Response Handling**: Extracted nested data structure
   - Reasoning: API returns paginated format for scalability
   - Allows for future pagination features
   - Maintains consistency with API design

### Known Limitations

1. **Online Users**: Currently displayed only when "All" filter is active
   - Future: Consider showing online users in other filter views
   - Future: Add API endpoint for dedicated online users list

2. **User Stories/Notes**: "Your story" feature is placeholder
   - Future: Implement API endpoints for user notes
   - Future: Add note creation/editing dialog
   - Future: Display notes on user avatars

3. **Conversation Search**: Uses same endpoint as conversation list
   - Future: Consider dedicated search endpoint for better performance
   - Future: Add search filters (by user, by date, by type)

## References

- API Spec: `api-spec.yaml`
- Tech Stack: `.kiro/steering/tech.md`
- Riverpod Standards: `.kiro/steering/riverpod_3_prompt.md`
- API Flow Template: `.kiro/steering/api_flow_template.md`
