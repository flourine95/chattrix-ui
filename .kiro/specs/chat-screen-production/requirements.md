# Requirements Document

## Introduction

Chuyển đổi màn hình chat demo (ChatListPagePreview) thành màn hình chat chính thức (ChatListPage) với đầy đủ tính năng tích hợp API backend, real-time updates qua WebSocket, và UI/UX hiện đại theo thiết kế demo.

## Glossary

- **ChatListPage**: Màn hình danh sách cuộc trò chuyện chính thức tích hợp API
- **ChatListPagePreview**: Màn hình demo với mock data (sẽ được thay thế)
- **Conversation**: Cuộc trò chuyện (DIRECT hoặc GROUP)
- **DIRECT Conversation**: Cuộc trò chuyện 1-1 giữa 2 người
- **GROUP Conversation**: Cuộc trò chuyện nhóm với nhiều người
- **Online Indicator**: Chấm xanh hiển thị trạng thái online của user
- **Unread Count**: Số tin nhắn chưa đọc trong conversation
- **Last Message**: Tin nhắn cuối cùng trong conversation
- **Typing Indicator**: Hiển thị khi user đang gõ tin nhắn
- **Filter**: Bộ lọc conversations (Tất cả, Chưa đọc, Nhóm)
- **WebSocket**: Kết nối real-time để nhận updates
- **Story/Note**: Ghi chú ngắn của user hiển thị trên avatar (tính năng tương lai)

## Requirements

### Requirement 1

**User Story:** As a user, I want to see my conversation list with real-time updates, so that I can quickly access my chats and see new messages.

#### Acceptance Criteria

1. WHEN the ChatListPage loads THEN the system SHALL fetch all conversations from the API endpoint `/v1/conversations` with pagination support
2. WHEN conversations are loaded THEN the system SHALL display them sorted by most recent activity (updatedAt descending)
3. WHEN a new message arrives via WebSocket THEN the system SHALL update the conversation list in real-time without requiring a refresh
4. WHEN a conversation is updated THEN the system SHALL move it to the top of the list
5. WHEN the API returns an error THEN the system SHALL display an appropriate error message to the user

### Requirement 2

**User Story:** As a user, I want to filter my conversations by type, so that I can quickly find specific chats.

#### Acceptance Criteria

1. WHEN the user selects "Tất cả" filter THEN the system SHALL display all conversations using the API parameter `filter=all`
2. WHEN the user selects "Chưa đọc" filter THEN the system SHALL display only conversations with unreadCount > 0 using the API parameter `filter=unread`
3. WHEN the user selects "Nhóm" filter THEN the system SHALL display only GROUP conversations using the API parameter `filter=group`
4. WHEN a filter is applied THEN the system SHALL maintain the filter state during the session
5. WHEN switching between filters THEN the system SHALL animate the transition smoothly

### Requirement 3

**User Story:** As a user, I want to see conversation details including avatar, name, last message, and unread count, so that I can understand the conversation status at a glance.

#### Acceptance Criteria

1. WHEN displaying a DIRECT conversation THEN the system SHALL show the other participant's username, avatar, and online status
2. WHEN displaying a GROUP conversation THEN the system SHALL show the group name, group avatar (or default), and member count
3. WHEN a conversation has a last message THEN the system SHALL display the message content, sender name (for groups), and timestamp
4. WHEN a conversation has unread messages THEN the system SHALL display the unread count badge
5. WHEN a user is online in a DIRECT conversation THEN the system SHALL display a green online indicator on their avatar

### Requirement 4

**User Story:** As a user, I want to see typing indicators, so that I know when someone is composing a message.

#### Acceptance Criteria

1. WHEN a user in a conversation starts typing THEN the system SHALL receive a WebSocket event `typing.indicator` with typing=true
2. WHEN receiving a typing indicator THEN the system SHALL display "Đang soạn tin..." as the last message preview
3. WHEN a user stops typing THEN the system SHALL receive a WebSocket event `typing.indicator` with typing=false
4. WHEN a typing indicator stops THEN the system SHALL revert to showing the actual last message
5. WHEN multiple users are typing in a group THEN the system SHALL display "X người đang soạn tin..."

### Requirement 5

**User Story:** As a user, I want to search for conversations, so that I can quickly find specific chats.

#### Acceptance Criteria

1. WHEN the user taps the search bar THEN the system SHALL navigate to a search screen or expand the search functionality
2. WHEN the user types in the search field THEN the system SHALL filter conversations by name or last message content
3. WHEN search results are displayed THEN the system SHALL highlight matching text
4. WHEN the user clears the search THEN the system SHALL restore the full conversation list
5. WHEN no results are found THEN the system SHALL display "Không tìm thấy tin nhắn nào"

### Requirement 6

**User Story:** As a user, I want to create new conversations, so that I can start chatting with contacts or create groups.

#### Acceptance Criteria

1. WHEN the user taps the "New Chat" button THEN the system SHALL navigate to the new chat screen
2. WHEN creating a DIRECT conversation THEN the system SHALL call POST `/v1/conversations` with type=DIRECT and exactly 1 participantId
3. WHEN creating a GROUP conversation THEN the system SHALL call POST `/v1/conversations` with type=GROUP and multiple participantIds
4. WHEN a conversation already exists THEN the system SHALL navigate to the existing conversation instead of creating a duplicate
5. WHEN conversation creation fails THEN the system SHALL display an error message with the failure reason

### Requirement 7

**User Story:** As a user, I want to see online users in a horizontal scrollable list, so that I can quickly start conversations with active contacts.

#### Acceptance Criteria

1. WHEN the "Tất cả" filter is active THEN the system SHALL display a horizontal scrollable list of online users above the conversation list
2. WHEN displaying online users THEN the system SHALL show users from the contact list who have online=true
3. WHEN a user's online status changes THEN the system SHALL update the online users list in real-time via WebSocket event `user.status`
4. WHEN the user taps an online user THEN the system SHALL navigate to the conversation with that user (creating one if needed)
5. WHEN no users are online THEN the system SHALL hide the online users section

### Requirement 8

**User Story:** As a user, I want to see my own "story" or note in the online users list, so that I can add personal status updates.

#### Acceptance Criteria

1. WHEN the online users list is displayed THEN the system SHALL show "Tin của bạn" as the first item
2. WHEN the user has not set a note THEN the system SHALL display "Ghi chú..." placeholder
3. WHEN the user taps "Tin của bạn" THEN the system SHALL open a dialog to create/edit their note
4. WHEN the user saves a note THEN the system SHALL update the note via API (future endpoint)
5. WHEN the user has a note THEN the system SHALL display it above their avatar in the online users list

### Requirement 9

**User Story:** As a user, I want the UI to match the modern design of the demo, so that I have a polished and intuitive experience.

#### Acceptance Criteria

1. WHEN the ChatListPage renders THEN the system SHALL use the same visual design as ChatListPagePreview (colors, spacing, typography)
2. WHEN displaying avatars THEN the system SHALL use circular avatars with online indicators positioned at bottom-right
3. WHEN displaying filter chips THEN the system SHALL use rounded chips with smooth color transitions on selection
4. WHEN displaying the search bar THEN the system SHALL use a rounded container with gray background and search icon
5. WHEN displaying conversation items THEN the system SHALL use the same layout and styling as the demo

### Requirement 10

**User Story:** As a user, I want smooth animations and transitions, so that the app feels responsive and polished.

#### Acceptance Criteria

1. WHEN switching between filters THEN the system SHALL animate the background color and text color changes over 200ms
2. WHEN new conversations appear THEN the system SHALL fade them in smoothly
3. WHEN scrolling the conversation list THEN the system SHALL use BouncingScrollPhysics for iOS-style bounce
4. WHEN tapping a conversation THEN the system SHALL provide visual feedback with InkWell ripple effect
5. WHEN loading data THEN the system SHALL display a loading indicator without blocking the UI

### Requirement 11

**User Story:** As a user, I want to see accurate timestamps for messages, so that I know when conversations were last active.

#### Acceptance Criteria

1. WHEN a message was sent within the last hour THEN the system SHALL display relative time (e.g., "2m", "45m")
2. WHEN a message was sent today THEN the system SHALL display the time (e.g., "14:30")
3. WHEN a message was sent yesterday THEN the system SHALL display "Yesterday"
4. WHEN a message was sent this week THEN the system SHALL display the day name (e.g., "Mon", "Tue")
5. WHEN a message was sent earlier THEN the system SHALL display the date (e.g., "Dec 10")

### Requirement 12

**User Story:** As a user, I want WebSocket connection to be managed automatically, so that I receive real-time updates without manual intervention.

#### Acceptance Criteria

1. WHEN the ChatListPage is mounted THEN the system SHALL ensure WebSocket connection is established
2. WHEN WebSocket connection is lost THEN the system SHALL attempt to reconnect automatically
3. WHEN receiving WebSocket event `chat.message` THEN the system SHALL update the conversation's last message
4. WHEN receiving WebSocket event `conversation.update` THEN the system SHALL refresh the affected conversation
5. WHEN receiving WebSocket event `user.status` THEN the system SHALL update the user's online status in all relevant conversations

## Notes on API Limitations

### Missing Endpoints (Future Enhancements)

1. **Online Users List**: API không có endpoint riêng để lấy danh sách users online. Hiện tại phải dựa vào `online` field trong conversation participants hoặc contacts list.
   - **Workaround**: Lấy từ contacts list và filter theo `online=true`
   - **Recommendation**: Thêm endpoint `GET /v1/users/online` để tối ưu performance

2. **User Notes/Stories**: API không có endpoint để tạo/cập nhật notes cho user (tính năng "Tin của bạn" trong demo).
   - **Workaround**: Tạm thời disable tính năng này hoặc lưu local
   - **Recommendation**: Thêm endpoints:
     - `POST /v1/users/me/note` - Create/update note
     - `DELETE /v1/users/me/note` - Delete note
     - `GET /v1/users/{userId}/note` - Get user's note
   - **Schema suggestion**:
     ```json
     {
       "content": "Đói quá 🍜",
       "expiresAt": "2025-12-17T10:00:00Z" // Optional, for temporary notes
     }
     ```

3. **Contact Notes**: API có endpoint để tạo notes cho contacts (`POST /v1/contacts/{contactId}/notes`) nhưng không có field `note` trong `ContactResponse` để hiển thị note ngắn trên avatar.
   - **Recommendation**: Thêm field `latestNote` vào `ContactResponse` để hiển thị note mới nhất

### API Design Feedback

1. ✅ **Good**: Pagination support cho conversations
2. ✅ **Good**: Filter support (all, unread, groups)
3. ✅ **Good**: WebSocket events đầy đủ cho real-time updates
4. ✅ **Good**: Typing indicator support
5. ⚠️ **Improvement**: Thêm endpoint để lấy online users list riêng
6. ⚠️ **Improvement**: Thêm user notes/stories feature
7. ⚠️ **Improvement**: Thêm field `latestNote` vào ContactResponse
