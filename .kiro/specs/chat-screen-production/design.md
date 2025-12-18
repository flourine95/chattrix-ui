# Design Document

## Overview

This design document outlines the architecture and implementation strategy for converting the demo chat list screen (ChatListPagePreview) into a production-ready chat list screen (ChatListPage) with full API integration, real-time WebSocket updates, and modern UI/UX.

The implementation will follow Clean Architecture principles with clear separation between Presentation, Domain, and Data layers. The UI will maintain the polished design from the demo while integrating with the backend API and WebSocket infrastructure.

## Architecture

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                        │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  ChatListPage (HookConsumerWidget)                   │  │
│  │  - Displays conversations with filters               │  │
│  │  - Shows online users horizontal list                │  │
│  │  - Handles user interactions                         │  │
│  └──────────────────────────────────────────────────────┘  │
│                          ↓                                   │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  ConversationsNotifier (Riverpod AsyncNotifier)      │  │
│  │  - Manages conversation list state                   │  │
│  │  - Handles WebSocket updates                         │  │
│  │  - Implements polling fallback                       │  │
│  └──────────────────────────────────────────────────────┘  │
│                          ↓                                   │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  FilterNotifier (StateNotifier)                      │  │
│  │  - Manages filter state (all/unread/groups)          │  │
│  └──────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│                      Domain Layer                            │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  Use Cases                                            │  │
│  │  - GetConversationsUseCase                           │  │
│  │  - GetOnlineUsersUseCase                             │  │
│  │  - SearchConversationsUseCase                        │  │
│  └──────────────────────────────────────────────────────┘  │
│                          ↓                                   │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  Entities                                             │  │
│  │  - Conversation                                       │  │
│  │  - ConversationParticipant                           │  │
│  │  - LastMessage                                        │  │
│  └──────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│                       Data Layer                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  ChatRepository                                       │  │
│  │  - Fetches conversations from API                    │  │
│  │  - Handles pagination                                 │  │
│  │  - Applies filters                                    │  │
│  └──────────────────────────────────────────────────────┘  │
│                          ↓                                   │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  ChatWebSocketDataSource                             │  │
│  │  - Manages WebSocket connection                      │  │
│  │  - Streams real-time events                          │  │
│  │  - Handles reconnection                              │  │
│  └──────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

### Component Interaction Flow

```
User Action → ChatListPage → ConversationsNotifier → Use Case → Repository → API
                    ↑                                                          ↓
                    └──────────── WebSocket Events ←──────────────────────────┘
```

## Components and Interfaces

### 1. Presentation Layer Components

#### ChatListPage (Widget)

**Responsibilities:**
- Render conversation list with modern UI design
- Display filter chips (Tất cả, Chưa đọc, Nhóm)
- Show online users horizontal list
- Handle user interactions (tap conversation, tap filter, tap search)
- Display loading/error states

**Key Features:**
- Uses `HookConsumerWidget` for Riverpod integration
- Implements `CustomScrollView` with `SliverAppBar` for smooth scrolling
- Displays conversation items with avatar, name, last message, timestamp, unread badge
- Shows online indicator for DIRECT conversations
- Implements search bar (navigates to search screen)
- Floating action button for new chat

**State Dependencies:**
- `conversationsProvider` - List of conversations
- `filterProvider` - Current filter selection
- `onlineUsersProvider` - List of online users
- `currentUserProvider` - Current logged-in user

#### ConversationListItem (Widget)

**Responsibilities:**
- Render individual conversation item
- Display avatar with online indicator
- Show conversation name, last message, timestamp
- Display unread count badge
- Handle tap to navigate to chat detail

**Props:**
- `conversation: Conversation` - Conversation data
- `currentUser: User` - Current user for determining "me" context
- `onTap: VoidCallback` - Navigation callback

#### OnlineUserItem (Widget)

**Responsibilities:**
- Render online user in horizontal list
- Display avatar with online indicator
- Show user note/story above avatar (if available)
- Handle tap to navigate to conversation

**Props:**
- `user: User` - User data
- `note: String?` - User's note/story
- `onTap: VoidCallback` - Navigation callback

#### FilterChip (Widget)

**Responsibilities:**
- Render filter chip with label
- Handle selection state
- Animate background/text color on selection

**Props:**
- `label: String` - Filter label
- `isSelected: bool` - Selection state
- `onTap: VoidCallback` - Selection callback

### 2. State Management

#### ConversationsNotifier (AsyncNotifier)

**State:** `AsyncValue<List<Conversation>>`

**Methods:**
```dart
// Build initial state - fetch conversations
Future<List<Conversation>> build()

// Refresh conversations manually
Future<void> refresh()

// Apply filter (all/unread/groups)
Future<void> applyFilter(ConversationFilter filter)

// Handle WebSocket message event
void _handleMessageEvent(MessageEvent event)

// Handle WebSocket conversation update event
void _handleConversationUpdateEvent(ConversationUpdateEvent event)

// Handle WebSocket user status event
void _handleUserStatusEvent(UserStatusEvent event)

// Start polling when WebSocket disconnected
void _startPolling()

// Stop polling when WebSocket connected
void _stopPolling()
```

**WebSocket Integration:**
- Listens to `messageStream` for new messages
- Listens to `conversationUpdateStream` for conversation updates
- Listens to `userStatusStream` for online status changes
- Listens to `typingIndicatorStream` for typing indicators
- Automatically refreshes affected conversations on events

**Polling Fallback:**
- Polls every 10 seconds when WebSocket disconnected
- Stops polling when WebSocket reconnects
- Ensures data freshness even without WebSocket

#### FilterNotifier (StateNotifier)

**State:** `ConversationFilter` (enum: all, unread, groups)

**Methods:**
```dart
// Set filter
void setFilter(ConversationFilter filter)

// Get current filter
ConversationFilter get currentFilter
```

#### OnlineUsersNotifier (AsyncNotifier)

**State:** `AsyncValue<List<User>>`

**Methods:**
```dart
// Build initial state - fetch online users
Future<List<User>> build()

// Refresh online users
Future<void> refresh()

// Handle user status change
void updateUserStatus(String userId, bool isOnline)
```

### 3. Domain Layer

#### Use Cases

**GetConversationsUseCase**
```dart
Future<Either<Failure, List<Conversation>>> call({
  ConversationFilter filter = ConversationFilter.all,
  int page = 0,
  int size = 20,
})
```

**GetOnlineUsersUseCase**
```dart
Future<Either<Failure, List<User>>> call()
```

**SearchConversationsUseCase**
```dart
Future<Either<Failure, List<Conversation>>> call({
  required String query,
})
```

**CreateConversationUseCase**
```dart
Future<Either<Failure, Conversation>> call({
  required ConversationType type,
  required List<int> participantIds,
  String? name, // For GROUP
})
```

#### Entities

**Conversation**
```dart
@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    required int id,
    String? name, // For GROUP
    required ConversationType type,
    String? avatarUrl, // For GROUP
    required List<ConversationParticipant> participants,
    LastMessage? lastMessage,
    required int unreadCount,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Conversation;
}
```

**ConversationParticipant**
```dart
@freezed
class ConversationParticipant with _$ConversationParticipant {
  const factory ConversationParticipant({
    required int userId,
    required String username,
    String? fullName,
    String? avatarUrl,
    required ParticipantRole role,
    bool? online,
    DateTime? lastSeen,
  }) = _ConversationParticipant;
}
```

**LastMessage**
```dart
@freezed
class LastMessage with _$LastMessage {
  const factory LastMessage({
    required int id,
    required String content,
    required int senderId,
    required String senderUsername,
    required DateTime sentAt,
    required MessageType type,
    int? readCount,
    List<ReadReceipt>? readBy,
  }) = _LastMessage;
}
```

**ConversationType** (enum)
```dart
enum ConversationType {
  direct,
  group,
}
```

**ConversationFilter** (enum)
```dart
enum ConversationFilter {
  all,
  unread,
  groups,
}
```

### 4. Data Layer

#### ChatRepository

**Methods:**
```dart
// Get conversations with filter and pagination
Future<Either<Failure, List<Conversation>>> getConversations({
  ConversationFilter filter = ConversationFilter.all,
  int page = 0,
  int size = 20,
})

// Get single conversation
Future<Either<Failure, Conversation>> getConversation(int conversationId)

// Create conversation
Future<Either<Failure, Conversation>> createConversation({
  required ConversationType type,
  required List<int> participantIds,
  String? name,
})

// Search conversations
Future<Either<Failure, List<Conversation>>> searchConversations({
  required String query,
})
```

#### ChatWebSocketDataSource

**Streams:**
```dart
// Message events
Stream<MessageEvent> get messageStream

// Conversation update events
Stream<ConversationUpdateEvent> get conversationUpdateStream

// User status events
Stream<UserStatusEvent> get userStatusStream

// Typing indicator events
Stream<TypingIndicatorEvent> get typingIndicatorStream

// Connection state
Stream<bool> get connectionStream
```

**Methods:**
```dart
// Connect to WebSocket
Future<void> connect()

// Disconnect from WebSocket
Future<void> disconnect()

// Check connection status
bool get isConnected

// Send typing indicator
void sendTypingIndicator(int conversationId, bool isTyping)
```

## Data Models

### API DTOs

**ConversationResponseDto**
```dart
@freezed
class ConversationResponseDto with _$ConversationResponseDto {
  const factory ConversationResponseDto({
    required int id,
    String? name,
    required String type,
    String? avatarUrl,
    required List<ParticipantDto> participants,
    LastMessageDto? lastMessage,
    required int unreadCount,
    required String createdAt,
    required String updatedAt,
  }) = _ConversationResponseDto;

  factory ConversationResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ConversationResponseDtoFromJson(json);
}
```

**ParticipantDto**
```dart
@freezed
class ParticipantDto with _$ParticipantDto {
  const factory ParticipantDto({
    required int userId,
    required String username,
    String? fullName,
    String? avatarUrl,
    required String role,
    bool? online,
    String? lastSeen,
  }) = _ParticipantDto;

  factory ParticipantDto.fromJson(Map<String, dynamic> json) =>
      _$ParticipantDtoFromJson(json);
}
```

**LastMessageDto**
```dart
@freezed
class LastMessageDto with _$LastMessageDto {
  const factory LastMessageDto({
    required int id,
    required String content,
    required int senderId,
    required String senderUsername,
    required String sentAt,
    required String type,
    int? readCount,
    List<ReadReceiptDto>? readBy,
  }) = _LastMessageDto;

  factory LastMessageDto.fromJson(Map<String, dynamic> json) =>
      _$LastMessageDtoFromJson(json);
}
```

### Mappers

**ConversationMapper**
```dart
extension ConversationDtoMapper on ConversationResponseDto {
  Conversation toEntity() {
    return Conversation(
      id: id,
      name: name,
      type: type.toLowerCase() == 'direct' 
          ? ConversationType.direct 
          : ConversationType.group,
      avatarUrl: avatarUrl,
      participants: participants.map((p) => p.toEntity()).toList(),
      lastMessage: lastMessage?.toEntity(),
      unreadCount: unreadCount,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}

extension ParticipantDtoMapper on ParticipantDto {
  ConversationParticipant toEntity() {
    return ConversationParticipant(
      userId: userId,
      username: username,
      fullName: fullName,
      avatarUrl: avatarUrl,
      role: role.toLowerCase() == 'admin' 
          ? ParticipantRole.admin 
          : ParticipantRole.member,
      online: online,
      lastSeen: lastSeen != null ? DateTime.parse(lastSeen!) : null,
    );
  }
}
```

## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system-essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*

### Property 1: Conversation list ordering consistency
*For any* conversation list returned by the API, conversations should be ordered by `updatedAt` in descending order (most recent first)
**Validates: Requirements 1.2**

### Property 2: Filter application correctness
*For any* filter selection (all/unread/groups), the displayed conversations should match the filter criteria:
- `all`: All conversations
- `unread`: Only conversations with `unreadCount > 0`
- `groups`: Only conversations with `type == GROUP`
**Validates: Requirements 2.1, 2.2, 2.3**

### Property 3: WebSocket update propagation
*For any* WebSocket event (message, conversation update, user status), the affected conversation(s) should be updated in the UI within 1 second
**Validates: Requirements 1.3, 12.3, 12.4, 12.5**

### Property 4: Online indicator accuracy
*For any* DIRECT conversation, if the other participant has `online == true`, the online indicator should be visible on their avatar
**Validates: Requirements 3.5**

### Property 5: Unread count visibility
*For any* conversation with `unreadCount > 0`, the unread badge should be displayed with the correct count
**Validates: Requirements 3.4**

### Property 6: Typing indicator display
*For any* conversation where a user is typing, the last message preview should show "Đang soạn tin..." instead of the actual last message
**Validates: Requirements 4.2, 4.4**

### Property 7: Conversation creation uniqueness
*For any* DIRECT conversation creation request, if a conversation with the same participant already exists, the system should navigate to the existing conversation instead of creating a duplicate
**Validates: Requirements 6.4**

### Property 8: Timestamp formatting consistency
*For any* message timestamp, the displayed format should match the time difference:
- < 1 hour: relative time (e.g., "2m")
- Today: time (e.g., "14:30")
- Yesterday: "Yesterday"
- This week: day name (e.g., "Mon")
- Earlier: date (e.g., "Dec 10")
**Validates: Requirements 11.1, 11.2, 11.3, 11.4, 11.5**

### Property 9: Polling fallback activation
*For any* WebSocket disconnection event, polling should start within 1 second and stop immediately when WebSocket reconnects
**Validates: Requirements 12.2**

### Property 10: Filter state persistence
*For any* filter selection, the filter state should persist during the session until explicitly changed by the user
**Validates: Requirements 2.4**

### Property 11: Empty state handling
*For any* empty conversation list (no conversations), the UI should display "No conversations yet" message
**Validates: Requirements 1.1** (implicit)

### Property 12: Search result filtering
*For any* search query, the displayed conversations should contain the query string in either the conversation name or last message content
**Validates: Requirements 5.2**

## Error Handling

### API Errors

**401 Unauthorized**
- **Cause**: Invalid or expired token
- **Handling**: Redirect to login screen, clear local auth state
- **UI**: Show toast "Session expired, please login again"

**403 Forbidden**
- **Cause**: User doesn't have access to conversation
- **Handling**: Remove conversation from list, show error
- **UI**: Show toast "You don't have access to this conversation"

**404 Not Found**
- **Cause**: Conversation doesn't exist
- **Handling**: Remove conversation from list
- **UI**: Show toast "Conversation not found"

**400 Bad Request**
- **Cause**: Invalid request parameters (e.g., DIRECT with multiple participants)
- **Handling**: Show validation error to user
- **UI**: Show dialog with error details

**429 Rate Limit Exceeded**
- **Cause**: Too many requests
- **Handling**: Implement exponential backoff, show retry option
- **UI**: Show toast "Too many requests, please try again later"

**500 Server Error**
- **Cause**: Backend server error
- **Handling**: Show generic error, allow retry
- **UI**: Show toast "Server error, please try again"

### Network Errors

**Connection Timeout**
- **Handling**: Retry with exponential backoff (3 attempts)
- **UI**: Show loading indicator, then error if all retries fail

**No Internet Connection**
- **Handling**: Show offline indicator, enable polling when connection restored
- **UI**: Show banner "No internet connection"

### WebSocket Errors

**Connection Failed**
- **Handling**: Retry connection with exponential backoff, enable polling fallback
- **UI**: Show subtle indicator "Connecting..." in app bar

**Connection Lost**
- **Handling**: Attempt reconnection, enable polling fallback
- **UI**: Show subtle indicator "Reconnecting..." in app bar

**Message Parse Error**
- **Handling**: Log error, ignore malformed message
- **UI**: No user-facing error (silent failure)

### State Errors

**Empty Conversation List**
- **Handling**: Show empty state UI
- **UI**: Display "No conversations yet" with illustration

**Failed to Load Conversations**
- **Handling**: Show error state with retry button
- **UI**: Display error message with "Retry" button

**Filter Returns No Results**
- **Handling**: Show empty state for filter
- **UI**: Display "Không tìm thấy tin nhắn nào"

## Testing Strategy

### Unit Tests

**ConversationsNotifier Tests**
- Test initial state loading
- Test filter application
- Test WebSocket event handling
- Test polling start/stop logic
- Test error handling

**FilterNotifier Tests**
- Test filter state changes
- Test filter persistence

**Use Case Tests**
- Test GetConversationsUseCase with different filters
- Test GetOnlineUsersUseCase
- Test CreateConversationUseCase validation

**Mapper Tests**
- Test DTO to Entity conversion
- Test null field handling (NON_NULL serialization)
- Test enum mapping

**Utility Tests**
- Test ConversationUtils methods
- Test timestamp formatting
- Test conversation title generation

### Property-Based Tests

We will use the `test` package with custom property-based testing utilities for Dart/Flutter. Each property test will run a minimum of 100 iterations with randomly generated inputs.

**Property Test 1: Conversation ordering**
```dart
// Feature: chat-screen-production, Property 1: Conversation list ordering consistency
test('conversations should always be ordered by updatedAt descending', () {
  // Generate random conversations with random timestamps
  // Verify they are sorted correctly
});
```

**Property Test 2: Filter correctness**
```dart
// Feature: chat-screen-production, Property 2: Filter application correctness
test('filtered conversations should match filter criteria', () {
  // Generate random conversations with various properties
  // Apply each filter and verify results
});
```

**Property Test 3: Online indicator logic**
```dart
// Feature: chat-screen-production, Property 4: Online indicator accuracy
test('online indicator should show for DIRECT conversations with online participant', () {
  // Generate random DIRECT conversations
  // Verify online indicator logic
});
```

**Property Test 4: Unread badge visibility**
```dart
// Feature: chat-screen-production, Property 5: Unread count visibility
test('unread badge should show when unreadCount > 0', () {
  // Generate random conversations with various unread counts
  // Verify badge visibility logic
});
```

**Property Test 5: Timestamp formatting**
```dart
// Feature: chat-screen-production, Property 8: Timestamp formatting consistency
test('timestamp formatting should match time difference rules', () {
  // Generate random timestamps at various time differences
  // Verify formatting matches rules
});
```

### Integration Tests

**Conversation List Flow**
- Test loading conversations from API
- Test applying filters
- Test navigation to chat detail
- Test creating new conversation

**WebSocket Integration**
- Test receiving message events
- Test receiving conversation updates
- Test receiving user status changes
- Test connection/disconnection handling

**Polling Fallback**
- Test polling starts when WebSocket disconnects
- Test polling stops when WebSocket reconnects
- Test data freshness with polling

### Widget Tests

**ChatListPage Widget**
- Test rendering conversation list
- Test filter chip interactions
- Test search bar tap
- Test floating action button tap
- Test empty state display
- Test error state display

**ConversationListItem Widget**
- Test rendering conversation details
- Test online indicator display
- Test unread badge display
- Test tap navigation

**OnlineUserItem Widget**
- Test rendering user avatar
- Test online indicator display
- Test note/story display
- Test tap navigation

## UI/UX Specifications

### Design System

**Colors**
- Primary: `Colors.blueAccent`
- Background (Light): `Colors.white`
- Background (Dark): `Colors.black`
- Surface (Light): `Color(0xFFF3F4F6)`
- Surface (Dark): `Color(0xFF1C1C1E)`
- Online Indicator: `Color(0xFF31A24C)`
- Unread Badge: `Colors.blueAccent`

**Typography**
- App Bar Title: 30px, FontWeight.w800
- Conversation Name: 16px, FontWeight.w700
- Last Message: 14px, FontWeight.normal
- Timestamp: 12px, FontWeight.normal
- Filter Chip: 14px, FontWeight.w600

**Spacing**
- Horizontal Padding: 16px
- Vertical Padding: 8px
- Item Spacing: 12px
- Avatar Radius: 24px (conversation list), 30px (online users)

**Animations**
- Filter Chip Selection: 200ms
- List Item Fade In: 300ms
- Scroll Physics: BouncingScrollPhysics

### Layout Structure

```
┌─────────────────────────────────────────┐
│  Chats                          [+]     │ ← SliverAppBar (pinned)
├─────────────────────────────────────────┤
│  🔍 Search                              │ ← Search Bar
├─────────────────────────────────────────┤
│  [Tất cả] [Chưa đọc] [Nhóm]            │ ← Filter Chips
├─────────────────────────────────────────┤
│  ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○        │ ← Online Users (horizontal)
│  Tin  A  B  C  D  E  F  G  H  I  J     │
├─────────────────────────────────────────┤
│  ┌───┐                                  │
│  │ A │  Alberne                    2m   │ ← Conversation Item
│  └───┘  Tối nay đi ăn không?       (3) │
├─────────────────────────────────────────┤
│  ┌───┐                                  │
│  │ H │  Hồng Nhung                Now  │
│  └───┘  Đang soạn tin...                │
├─────────────────────────────────────────┤
│  ┌───┐                                  │
│  │ D │  Dev Team 🚀                1h   │
│  └───┘  Long: Đã merge code...    (12) │
└─────────────────────────────────────────┘
```

### Interaction Patterns

**Tap Conversation**
- Action: Navigate to chat detail screen
- Feedback: InkWell ripple effect
- Animation: Slide transition

**Tap Filter Chip**
- Action: Apply filter, update conversation list
- Feedback: Background color change (200ms)
- Animation: Smooth color transition

**Tap Online User**
- Action: Navigate to conversation with user (create if needed)
- Feedback: Scale animation (0.95x)
- Animation: Bounce back

**Tap Search Bar**
- Action: Navigate to search screen
- Feedback: Highlight search bar
- Animation: Fade transition

**Tap New Chat Button**
- Action: Navigate to new chat screen
- Feedback: FAB scale animation
- Animation: Slide up transition

**Pull to Refresh**
- Action: Refresh conversation list
- Feedback: Loading indicator
- Animation: Bounce physics

## Implementation Notes

### Existing Code Reuse

**Keep:**
- `ConversationsNotifier` - Already implements WebSocket integration and polling
- `ChatWebSocketDataSource` - Already handles WebSocket connection
- `ConversationUtils` - Utility methods for conversation display
- `UserAvatar` widget - Reusable avatar component

**Modify:**
- `ChatListPage` - Replace simple list with demo-style UI
- Add filter chips UI
- Add online users horizontal list
- Add search bar UI
- Improve styling to match demo

**Add:**
- `FilterNotifier` - New state management for filters
- `OnlineUserItem` widget - New component for online users
- `ConversationListItem` widget - Enhanced conversation item
- `FilterChip` widget - New filter chip component

### API Integration

**Endpoints to Use:**
- `GET /v1/conversations?filter={filter}&page={page}&size={size}` - Get conversations
- `POST /v1/conversations` - Create conversation
- `GET /v1/contacts` - Get contacts for online users list (filter by `online=true`)

**WebSocket Events to Handle:**
- `chat.message` - Update last message
- `conversation.update` - Refresh conversation
- `user.status` - Update online status
- `typing.indicator` - Show typing indicator

### Performance Considerations

**Optimization Strategies:**
1. **Pagination**: Load 20 conversations at a time
2. **Lazy Loading**: Load more on scroll
3. **Caching**: Cache conversation list in memory
4. **Debouncing**: Debounce search input (300ms)
5. **Memoization**: Memoize conversation title/avatar calculations
6. **Efficient Rebuilds**: Use `const` constructors where possible
7. **Image Caching**: Use `CachedNetworkImage` for avatars

**Memory Management:**
1. Dispose controllers in `ref.onDispose()`
2. Cancel stream subscriptions on dispose
3. Limit online users list to 50 items
4. Clear old conversations from cache (keep last 100)

### Accessibility

**Screen Reader Support:**
- Semantic labels for all interactive elements
- Announce conversation updates
- Announce filter changes

**Keyboard Navigation:**
- Tab through conversations
- Enter to open conversation
- Arrow keys for filter selection

**Visual Accessibility:**
- High contrast mode support
- Large text support
- Color blind friendly indicators (not just color)

## Future Enhancements

### Phase 2 Features

1. **User Notes/Stories**
   - API endpoint for creating/updating notes
   - Display notes above avatars in online users list
   - "Tin của bạn" functionality

2. **Advanced Search**
   - Search by message content
   - Search by date range
   - Search by media type

3. **Conversation Actions**
   - Swipe to archive
   - Swipe to delete
   - Long press for context menu

4. **Pinned Conversations**
   - Pin important conversations to top
   - Visual indicator for pinned conversations

5. **Conversation Settings**
   - Mute notifications
   - Custom nicknames
   - Theme customization

6. **Read Receipts**
   - Show read status in conversation list
   - Display avatars of users who read

7. **Message Previews**
   - Show media thumbnails in last message
   - Show voice message duration
   - Show document file names

### Technical Improvements

1. **Offline Support**
   - Cache conversations locally
   - Queue actions when offline
   - Sync when connection restored

2. **Performance Optimization**
   - Virtual scrolling for large lists
   - Image lazy loading
   - Background data refresh

3. **Analytics**
   - Track conversation open rate
   - Track filter usage
   - Track search queries

4. **Testing**
   - Increase test coverage to 90%
   - Add E2E tests
   - Add performance tests
