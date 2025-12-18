# Implementation Plan

- [x] 1. Update domain entities and enums




  - Add `ConversationFilter` enum (all, unread, groups) to domain layer
  - Ensure `Conversation` entity has all required fields from design
  - Ensure `ConversationParticipant` entity has `online` and `lastSeen` fields
  - _Requirements: 2.1, 2.2, 2.3, 3.1, 3.2, 3.5_


- [x] 2. Create filter state management



- [x] 2.1 Implement FilterNotifier

  - Create `FilterNotifier` extending `StateNotifier<ConversationFilter>`
  - Implement `setFilter(ConversationFilter filter)` method
  - Implement `currentFilter` getter
  - Create Riverpod provider for FilterNotifier
  - _Requirements: 2.1, 2.2, 2.3, 2.4_

- [ ]* 2.2 Write property test for filter state
  - **Property 10: Filter state persistence**
  - **Validates: Requirements 2.4**

- [x] 3. Update ConversationsNotifier for filter support




- [x] 3.1 Add filter parameter to _fetchConversations


  - Modify `_fetchConversations()` to accept `ConversationFilter` parameter
  - Pass filter to `GetConversationsUseCase`
  - Update `build()` to use current filter from `FilterNotifier`
  - _Requirements: 2.1, 2.2, 2.3_

- [x] 3.2 Add applyFilter method


  - Implement `applyFilter(ConversationFilter filter)` method
  - Update filter in `FilterNotifier`
  - Refresh conversations with new filter
  - _Requirements: 2.1, 2.2, 2.3_

- [ ]* 3.3 Write property test for filter application
  - **Property 2: Filter application correctness**
  - **Validates: Requirements 2.1, 2.2, 2.3**

- [x] 4. Update repository and use case for filter support




- [x] 4.1 Update GetConversationsUseCase

  - Add `filter` parameter to `call()` method
  - Pass filter to repository
  - _Requirements: 2.1, 2.2, 2.3_

- [x] 4.2 Update ChatRepository interface

  - Add `filter` parameter to `getConversations()` method
  - Update method signature in interface
  - _Requirements: 2.1, 2.2, 2.3_

- [x] 4.3 Update ChatRepositoryImpl

  - Implement filter logic in `getConversations()`
  - Map `ConversationFilter` enum to API query parameter
  - Handle filter in API call
  - _Requirements: 2.1, 2.2, 2.3_

- [x] 5. Create online users state management




- [x] 5.1 Implement OnlineUsersNotifier

  - Create `OnlineUsersNotifier` extending `AsyncNotifier<List<User>>`
  - Implement `build()` to fetch online users from contacts
  - Implement `refresh()` method
  - Implement `updateUserStatus(String userId, bool isOnline)` method
  - Listen to WebSocket `user.status` events
  - Create Riverpod provider for OnlineUsersNotifier
  - _Requirements: 7.1, 7.2, 7.3_

- [ ]* 5.2 Write property test for online users
  - **Property 4: Online indicator accuracy**
  - **Validates: Requirements 3.5, 7.2**


- [x] 6. Create UI components




- [x] 6.1 Create FilterChip widget


  - Create `FilterChip` widget with label, isSelected, onTap props
  - Implement animated background/text color transitions (200ms)
  - Use rounded corners (BorderRadius.circular(20))
  - _Requirements: 2.5, 9.3, 10.1_

- [x] 6.2 Create OnlineUserItem widget


  - Create `OnlineUserItem` widget with user, note, onTap props
  - Display circular avatar with online indicator
  - Display user note above avatar (if available)
  - Display user's first name below avatar
  - Handle tap to navigate to conversation
  - _Requirements: 7.1, 7.2, 7.4, 8.1, 8.2, 8.5, 9.2_

- [x] 6.3 Create ConversationListItem widget


  - Create `ConversationListItem` widget with conversation, currentUser, onTap props
  - Display avatar with online indicator (for DIRECT conversations)
  - Display conversation name (use ConversationUtils.getConversationTitle)
  - Display last message with sender name (for groups)
  - Display timestamp (use ConversationUtils.formatTimeAgo)
  - Display unread count badge (if unreadCount > 0)
  - Display typing indicator (if user is typing)
  - Handle tap to navigate to chat detail
  - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5, 4.2, 4.4, 9.2, 9.5_

- [ ]* 6.4 Write property test for unread badge
  - **Property 5: Unread count visibility**
  - **Validates: Requirements 3.4**

- [ ]* 6.5 Write property test for typing indicator
  - **Property 6: Typing indicator display**
  - **Validates: Requirements 4.2, 4.4**

- [x] 7. Update ChatListPage with new UI





- [x] 7.1 Replace ListView with CustomScrollView


  - Convert to `CustomScrollView` with `SliverAppBar`
  - Set app bar title to "Chats" with large bold font (30px, FontWeight.w800)
  - Add floating action button with message-circle-plus icon
  - Use BouncingScrollPhysics for iOS-style bounce
  - _Requirements: 9.1, 9.4, 10.3_

- [x] 7.2 Add search bar


  - Create search bar container with rounded corners (BorderRadius.circular(30))
  - Add search icon and "Search" placeholder text
  - Handle tap to navigate to search screen (future implementation)
  - _Requirements: 5.1, 9.4_

- [x] 7.3 Add filter chips


  - Create horizontal scrollable row of filter chips
  - Add "Tất cả", "Chưa đọc", "Nhóm" chips
  - Connect to FilterNotifier for state management
  - Handle chip tap to apply filter
  - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5, 9.3_

- [x] 7.4 Add online users horizontal list


  - Create horizontal scrollable list above conversation list
  - Show only when "Tất cả" filter is active
  - Display "Tin của bạn" as first item
  - Display online users from OnlineUsersNotifier
  - Handle user tap to navigate to conversation
  - _Requirements: 7.1, 7.2, 7.3, 7.4, 7.5, 8.1, 8.2_

- [x] 7.5 Update conversation list rendering


  - Use ConversationListItem widget for each conversation
  - Handle empty state ("No conversations yet")
  - Handle error state with retry button
  - Handle loading state with CircularProgressIndicator
  - _Requirements: 1.1, 1.2, 1.5, 3.1, 3.2, 3.3, 3.4, 3.5, 9.5_

- [ ]* 7.6 Write property test for conversation ordering
  - **Property 1: Conversation list ordering consistency**
  - **Validates: Requirements 1.2**

- [x] 8. Implement timestamp formatting utility




- [x] 8.1 Create formatTimeAgo utility

  - Implement logic for relative time (< 1 hour: "2m", "45m")
  - Implement logic for today (time: "14:30")
  - Implement logic for yesterday ("Yesterday")
  - Implement logic for this week (day name: "Mon", "Tue")
  - Implement logic for earlier (date: "Dec 10")
  - Add to ConversationUtils or create separate TimeUtils
  - _Requirements: 11.1, 11.2, 11.3, 11.4, 11.5_

- [ ]* 8.2 Write property test for timestamp formatting
  - **Property 8: Timestamp formatting consistency**
  - **Validates: Requirements 11.1, 11.2, 11.3, 11.4, 11.5**


- [x] 9. Implement WebSocket event handling




- [x] 9.1 Handle message events


  - Listen to `messageStream` in ConversationsNotifier
  - Update conversation's last message on event
  - Move conversation to top of list
  - Increment unread count if message is not from current user
  - _Requirements: 1.3, 1.4, 12.3_

- [x] 9.2 Handle conversation update events

  - Listen to `conversationUpdateStream` in ConversationsNotifier
  - Refresh affected conversation on event
  - _Requirements: 1.3, 12.4_

- [x] 9.3 Handle user status events

  - Listen to `userStatusStream` in ConversationsNotifier
  - Update participant's online status in conversations
  - Update online users list in OnlineUsersNotifier
  - _Requirements: 3.5, 7.3, 12.5_

- [x] 9.4 Handle typing indicator events

  - Listen to `typingIndicatorStream` in ConversationsNotifier
  - Update conversation's last message preview to show "Đang soạn tin..."
  - Revert to actual last message when typing stops
  - Handle multiple users typing in groups ("X người đang soạn tin...")
  - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5_

- [ ]* 9.5 Write property test for WebSocket updates
  - **Property 3: WebSocket update propagation**
  - **Validates: Requirements 1.3, 12.3, 12.4, 12.5**


- [x] 10. Implement polling fallback



- [x] 10.1 Verify polling start/stop logic

  - Ensure polling starts when WebSocket disconnects
  - Ensure polling stops when WebSocket reconnects
  - Verify polling interval (10 seconds)
  - _Requirements: 12.2_

- [ ]* 10.2 Write property test for polling fallback
  - **Property 9: Polling fallback activation**
  - **Validates: Requirements 12.2**

- [x] 11. Implement search functionality




- [x] 11.1 Create SearchConversationsUseCase


  - Implement use case to search conversations by query
  - Call repository method
  - _Requirements: 5.2_

- [x] 11.2 Update repository for search


  - Add `searchConversations(String query)` method to ChatRepository interface
  - Implement method in ChatRepositoryImpl
  - Filter conversations by name or last message content
  - _Requirements: 5.2_

- [x] 11.3 Create search screen (basic)


  - Create basic search screen with text field
  - Display filtered conversations
  - Handle empty results ("Không tìm thấy tin nhắn nào")
  - Navigate from ChatListPage search bar tap
  - _Requirements: 5.1, 5.2, 5.4, 5.5_

- [ ]* 11.4 Write property test for search filtering
  - **Property 12: Search result filtering**
  - **Validates: Requirements 5.2**

- [x] 12. Implement conversation creation




- [x] 12.1 Update CreateConversationUseCase


  - Ensure validation for DIRECT conversations (exactly 1 participant)
  - Ensure validation for GROUP conversations (at least 1 participant)
  - Handle duplicate conversation check
  - _Requirements: 6.2, 6.3, 6.4_

- [x] 12.2 Update new chat screen


  - Connect to CreateConversationUseCase
  - Handle conversation creation success (navigate to conversation)
  - Handle conversation creation failure (show error)
  - Handle duplicate conversation (navigate to existing)
  - _Requirements: 6.1, 6.2, 6.3, 6.4, 6.5_

- [ ]* 12.3 Write property test for conversation uniqueness
  - **Property 7: Conversation creation uniqueness**
  - **Validates: Requirements 6.4**


- [x] 13. Implement error handling




- [x] 13.1 Handle API errors


  - Handle 401 Unauthorized (redirect to login)
  - Handle 403 Forbidden (show error toast)
  - Handle 404 Not Found (remove conversation)
  - Handle 400 Bad Request (show validation error)
  - Handle 429 Rate Limit (show retry option)
  - Handle 500 Server Error (show generic error)
  - _Requirements: 1.5_

- [x] 13.2 Handle network errors


  - Handle connection timeout (retry with backoff)
  - Handle no internet connection (show offline banner)
  - _Requirements: 1.5_

- [x] 13.3 Handle WebSocket errors


  - Handle connection failed (retry with backoff, enable polling)
  - Handle connection lost (attempt reconnection, enable polling)
  - Handle message parse error (log and ignore)
  - _Requirements: 12.1, 12.2_


- [x] 14. Implement animations and transitions



- [x] 14.1 Add filter chip animations


  - Animate background color change on selection (200ms)
  - Animate text color change on selection (200ms)
  - Use AnimatedContainer for smooth transitions
  - _Requirements: 2.5, 10.1_

- [x] 14.2 Add conversation list animations


  - Fade in new conversations (300ms)
  - Animate conversation reordering
  - _Requirements: 10.2_

- [x] 14.3 Add interaction feedback


  - Add InkWell ripple effect on conversation tap
  - Add scale animation on online user tap (0.95x)
  - Add FAB scale animation on tap
  - _Requirements: 10.4_


- [x] 15. Implement accessibility features




- [x] 15.1 Add semantic labels


  - Add semantic labels for all interactive elements
  - Add semantic labels for conversation items
  - Add semantic labels for filter chips
  - Add semantic labels for online users

- [x] 15.2 Add screen reader announcements


  - Announce conversation updates
  - Announce filter changes
  - Announce new messages


- [x] 16. Checkpoint - Ensure all tests pass



  - Ensure all tests pass, ask the user if questions arise.

- [x] 17. Replace demo page with production page





- [x] 17.1 Update routing


  - Update router to use ChatListPage instead of ChatListPagePreview
  - Remove ChatListPagePreview from codebase (or mark as deprecated)
  - Verify navigation works correctly

- [x] 17.2 Final testing


  - Test all features end-to-end
  - Test on different screen sizes
  - Test dark mode
  - Test with real API data
  - Test WebSocket connection/disconnection
  - Test polling fallback

- [x] 18. Final Checkpoint - Ensure all tests pass




  - Ensure all tests pass, ask the user if questions arise.
