# Chat Architecture - Real-time Messaging System

## 📋 Overview

Clean, maintainable real-time chat system using Flutter, Riverpod, and WebSocket.

---

## 🏗️ Architecture Layers

### 1. **Data Layer**
- `ChatRepository` - Handles API calls and data transformation
- `ChatWebSocketService` - Manages WebSocket connection and message streaming
- Models: `MessageModel`, `ConversationModel`

### 2. **Domain Layer**
- Entities: `Message`, `Conversation`, `User`
- Use Cases: `GetMessagesUsecase`, `SendMessageUsecase`, `GetConversationsUsecase`

### 3. **Presentation Layer**
- **State Management**: Riverpod with code generation
- **Notifiers**: 
  - `MessagesNotifier` - Manages messages for a conversation
  - `ConversationsNotifier` - Manages conversation list
- **Pages**:
  - `ChatViewPage` - Individual chat room
  - `ChatListPage` - List of conversations

---

## 🔄 Real-time Update Flow

### Message Flow (WebSocket)

```
1. User sends message
   ↓
2. Send via WebSocket (or HTTP fallback)
   ↓
3. Backend broadcasts message to all participants
   ↓
4. WebSocket receives message
   ↓
5. MessagesNotifier listens to stream
   ↓
6. Auto-refresh messages for matching conversation
   ↓
7. UI updates automatically (Riverpod reactivity)
   ↓
8. Auto-scroll if user is at bottom
```

### Key Components

#### **MessagesNotifier** (`messages_notifier.dart`)
```dart
@riverpod
class MessagesNotifier extends _$MessagesNotifier {
  @override
  FutureOr<List<Message>> build(String conversationId) async {
    // Listen to WebSocket for real-time updates
    final wsService = ref.read(chatWebSocketServiceProvider);
    
    final subscription = wsService.messageStream.listen((message) {
      if (message.conversationId.toString() == conversationId.toString()) {
        refresh(); // Auto-refresh when new message arrives
      }
    });

    ref.onDispose(subscription.cancel);
    return _fetchMessages(conversationId);
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() => _fetchMessages(conversationId));
  }
}
```

**Responsibilities:**
- ✅ Listen to WebSocket message stream
- ✅ Auto-refresh when new message arrives for this conversation
- ✅ Fetch messages from API
- ✅ Manage loading/error states

#### **ConversationsNotifier** (`conversations_notifier.dart`)
```dart
@riverpod
class ConversationsNotifier extends _$ConversationsNotifier {
  @override
  FutureOr<List<Conversation>> build() async {
    final wsService = ref.read(chatWebSocketServiceProvider);
    
    // Listen to both conversation updates and new messages
    final conversationSub = wsService.conversationUpdateStream.listen((_) => refresh());
    final messageSub = wsService.messageStream.listen((_) => refresh());

    ref.onDispose(() {
      conversationSub.cancel();
      messageSub.cancel();
    });

    return _fetchConversations();
  }
}
```

**Responsibilities:**
- ✅ Listen to conversation updates
- ✅ Listen to new messages (to update last message)
- ✅ Auto-refresh conversation list
- ✅ Manage loading/error states

#### **ChatViewPage** (`chat_view_page.dart`)

**Key Features:**
1. **Smart Message Detection** - Detects new messages by comparing first message ID (works even when message count stays at page size limit)
2. **Auto-scroll Logic** - Scrolls to bottom when new message arrives (only if user is already at bottom)
3. **New Message Indicator** - Shows "Tin mới" badge when user is reading old messages
4. **WebSocket/HTTP Fallback** - Uses WebSocket when connected, falls back to HTTP

```dart
// Detect new message by ID (not just count)
final hasNewMessage = (oldFirstId != null && 
                       newFirstId != null && 
                       newFirstId != oldFirstId) ||
                      (newCount > oldCount && oldCount > 0);

if (hasNewMessage) {
  if (shouldAutoScroll.value) {
    // Auto-scroll to new message
  } else {
    // Show "New Message" indicator
  }
}
```

---

## 🎯 Design Decisions

### ✅ What We Do

1. **Single Source of Truth**
   - WebSocket listener in Notifier (not in UI)
   - UI watches Riverpod state
   - No duplicate listeners

2. **Clean Separation**
   - Notifiers handle business logic
   - UI handles presentation only
   - WebSocket service handles connection

3. **Smart Message Detection**
   - Compare first message ID (newest message)
   - Works even when message count stays same (page size limit)
   - Fallback to count comparison

4. **No Loading Indicators on Refresh**
   - Use `AsyncValue.guard` without setting loading state
   - Prevents UI flicker during real-time updates

5. **Automatic Cleanup**
   - Use `ref.onDispose` to cancel subscriptions
   - Prevents memory leaks

### ❌ What We Don't Do

1. **No Periodic Polling**
   - WebSocket provides real-time updates
   - No need for periodic API calls

2. **No Duplicate Listeners**
   - Only one listener per stream in Notifier
   - UI doesn't listen directly to WebSocket

3. **No Manual Refresh After Send**
   - WebSocket broadcasts message back
   - Notifier auto-refreshes on receive

4. **No Excessive Logging**
   - Keep logs minimal in production code
   - Only log critical events

---

## 🔧 Key Technical Details

### Message Ordering
- API returns messages in **DESC** order (newest first)
- UI reverses to **ASC** for display (oldest at top, newest at bottom)
- First message in list = newest message

### Page Size Limit
- Default: 50 messages per page
- When conversation has 50+ messages:
  - Count stays at 50
  - But first message ID changes
  - Smart detection catches this

### WebSocket Connection
- Auto-connect on app start
- Reconnect on disconnect
- Fallback to HTTP if not connected

### State Management
- Riverpod with code generation
- `@riverpod` annotation for providers
- `AsyncValue` for loading/error states
- `ref.watch` in UI, `ref.read` in logic

---

## 📱 User Experience

### Sending Message
1. User types message
2. Presses send
3. Message sent via WebSocket
4. Input cleared immediately
5. Message appears in chat (via WebSocket broadcast)
6. Auto-scroll to bottom

### Receiving Message
1. WebSocket receives message
2. Notifier auto-refreshes
3. UI updates automatically
4. If user at bottom → auto-scroll
5. If user reading old messages → show "Tin mới" indicator

### Scroll Behavior
- **At bottom**: Auto-scroll to new messages
- **Scrolled up**: Show "Tin mới" indicator
- **Click indicator**: Scroll to bottom and clear indicator

---

## 🚀 Performance Optimizations

1. **Efficient State Updates**
   - Only refresh when message matches conversation
   - No unnecessary rebuilds

2. **Smart Scroll Detection**
   - Track scroll position
   - Only auto-scroll when appropriate

3. **Lazy Loading**
   - Messages loaded on demand
   - Pagination support (50 messages per page)

4. **Memory Management**
   - Auto-dispose subscriptions
   - Clean up on page exit

---

## 🧪 Testing Checklist

- [ ] Send message via WebSocket
- [ ] Receive message in real-time
- [ ] Auto-scroll when at bottom
- [ ] Show indicator when scrolled up
- [ ] Fallback to HTTP when WebSocket disconnected
- [ ] Last message updates in conversation list
- [ ] Multiple conversations work independently
- [ ] No memory leaks (check subscriptions)

---

## 📝 Future Improvements

1. **Optimistic Updates** - Show message immediately before server confirmation
2. **Message Status** - Sent, delivered, read indicators
3. **Typing Indicators** - Show when other user is typing
4. **Message Reactions** - Like, love, etc.
5. **File Attachments** - Images, videos, documents
6. **Message Search** - Search within conversation
7. **Infinite Scroll** - Load more messages on scroll up

---

## 🔗 Related Files

- `lib/features/chat/presentation/state/messages_notifier.dart`
- `lib/features/chat/presentation/state/conversations_notifier.dart`
- `lib/features/chat/presentation/pages/chat_view_page.dart`
- `lib/features/chat/presentation/pages/chat_list_page.dart`
- `lib/features/chat/data/services/chat_websocket_service.dart`
- `lib/features/chat/data/repositories/chat_repository_impl.dart`

