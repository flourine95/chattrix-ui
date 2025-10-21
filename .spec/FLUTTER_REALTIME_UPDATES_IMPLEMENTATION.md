# 🔄 Flutter Real-time Updates Implementation

## 📋 Tổng quan

Đã implement real-time updates cho **Last Seen** và **Last Message** trong Flutter app, tương ứng với backend WebSocket implementation.

## ✨ Tính năng đã thêm

### 1. **Conversation Updates (Last Message)**
- Listen to `conversation.update` events từ WebSocket
- Tự động refresh conversations list khi có message mới
- Hiển thị last message trong conversation list

### 2. **User Status Updates (Last Seen)**
- Listen to `user.status` events từ WebSocket
- Cập nhật online/offline status real-time
- Hiển thị last seen time

### 3. **Heartbeat Support**
- Gửi heartbeat để maintain WebSocket connection
- Nhận heartbeat acknowledgment từ server

## 🏗️ Implementation Details

### **File**: `lib/features/chat/data/services/chat_websocket_service.dart`

#### **1. Added WebSocket Event Types**

```dart
/// WebSocket events from server to client
class ChatWebSocketResponse {
  static const String chatMessage = 'chat.message';
  static const String typingIndicator = 'typing.indicator';
  static const String userStatus = 'user.status';
  static const String conversationUpdate = 'conversation.update';  // ← NEW
  static const String heartbeatAck = 'heartbeat.ack';              // ← NEW
}
```

#### **2. Added Stream Controllers**

```dart
class ChatWebSocketService {
  // ... existing controllers
  final _conversationUpdateController = StreamController<ConversationUpdate>.broadcast();
  
  Stream<ConversationUpdate> get conversationUpdateStream => 
      _conversationUpdateController.stream;
}
```

#### **3. Added Message Handling**

```dart
switch (type) {
  // ... existing cases
  
  case ChatWebSocketResponse.conversationUpdate:
    final update = ConversationUpdate.fromJson(payload);
    _conversationUpdateController.add(update);
    debugPrint('💬 Conversation update: ${update.conversationId}');
    break;

  case ChatWebSocketResponse.heartbeatAck:
    debugPrint('💓 Heartbeat acknowledged');
    break;
}
```

#### **4. Added Heartbeat Method**

```dart
/// Send heartbeat to keep connection alive
void sendHeartbeat() {
  if (_channel == null) return;

  final payload = {
    'type': 'heartbeat',
    'payload': {},
  };

  _channel!.sink.add(jsonEncode(payload));
  debugPrint('💓 Sent heartbeat');
}
```

#### **5. Added Models**

```dart
/// Conversation update model (for lastMessage updates)
class ConversationUpdate {
  final int conversationId;
  final String updatedAt;
  final LastMessageInfo? lastMessage;

  ConversationUpdate({
    required this.conversationId,
    required this.updatedAt,
    this.lastMessage,
  });

  factory ConversationUpdate.fromJson(Map<String, dynamic> json) {
    return ConversationUpdate(
      conversationId: json['conversationId'] as int,
      updatedAt: json['updatedAt'] as String,
      lastMessage: json['lastMessage'] != null
          ? LastMessageInfo.fromJson(json['lastMessage'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Last message info model
class LastMessageInfo {
  final int id;
  final String content;
  final int senderId;
  final String senderUsername;
  final String sentAt;
  final String type;

  LastMessageInfo({
    required this.id,
    required this.content,
    required this.senderId,
    required this.senderUsername,
    required this.sentAt,
    required this.type,
  });

  factory LastMessageInfo.fromJson(Map<String, dynamic> json) {
    return LastMessageInfo(
      id: json['id'] as int,
      content: json['content'] as String,
      senderId: json['senderId'] as int,
      senderUsername: json['senderUsername'] as String,
      sentAt: json['sentAt'] as String,
      type: json['type'] as String,
    );
  }
}
```

### **File**: `lib/features/chat/providers/chat_providers.dart`

#### **Updated Conversations Provider**

```dart
/// Provider for conversations list state with real-time updates
final conversationsProvider = FutureProvider((ref) async {
  final usecase = ref.watch(getConversationsUsecaseProvider);
  final result = await usecase();

  // Listen to WebSocket for conversation updates (lastMessage changes)
  final wsService = ref.watch(chatWebSocketServiceProvider);
  wsService.conversationUpdateStream.listen((update) {
    debugPrint('🔄 Conversation ${update.conversationId} updated, refreshing list');
    // Invalidate provider to trigger refresh
    ref.invalidateSelf();
  });

  return result.fold(
    (failure) => throw Exception(failure.message),
    (conversations) => conversations,
  );
});
```

## 📡 WebSocket Events

### **1. conversation.update** (Server → Client)

**When**: Khi có message mới trong conversation

**Payload**:
```json
{
  "type": "conversation.update",
  "payload": {
    "conversationId": 15,
    "updatedAt": "2025-10-20T10:30:00Z",
    "lastMessage": {
      "id": 100,
      "content": "Hello everyone!",
      "senderId": 5,
      "senderUsername": "john_doe",
      "sentAt": "2025-10-20T10:30:00Z",
      "type": "TEXT"
    }
  }
}
```

**Flutter Handling**:
- Parse thành `ConversationUpdate` object
- Emit qua `conversationUpdateStream`
- `conversationsProvider` listen và invalidate để refresh

### **2. user.status** (Server → Client)

**When**: Khi user online/offline status thay đổi

**Payload**:
```json
{
  "type": "user.status",
  "payload": {
    "userId": "5",
    "username": "john_doe",
    "displayName": "John Doe",
    "isOnline": true,
    "lastSeen": "2025-10-20T10:30:00Z"
  }
}
```

**Flutter Handling**:
- Parse thành `UserStatusUpdate` object
- Emit qua `userStatusStream`
- UI components có thể listen để update status

### **3. heartbeat** (Client → Server)

**When**: Mỗi 30 giây để maintain connection

**Payload**:
```json
{
  "type": "heartbeat",
  "payload": {}
}
```

**Flutter Code**:
```dart
// Send heartbeat every 30 seconds
Timer.periodic(Duration(seconds: 30), (timer) {
  wsService.sendHeartbeat();
});
```

### **4. heartbeat.ack** (Server → Client)

**When**: Server response to heartbeat

**Payload**:
```json
{
  "type": "heartbeat.ack",
  "payload": {
    "userId": "5",
    "timestamp": "2025-10-20T10:30:00Z"
  }
}
```

**Flutter Handling**:
- Log acknowledgment
- Confirm connection is alive

## 🎯 Usage Examples

### **1. Listen to Conversation Updates**

```dart
final wsService = ref.watch(chatWebSocketServiceProvider);

wsService.conversationUpdateStream.listen((update) {
  print('Conversation ${update.conversationId} updated');
  print('Last message: ${update.lastMessage?.content}');
  print('Sent by: ${update.lastMessage?.senderUsername}');
  
  // Update UI
  setState(() {
    // Refresh conversation list or update specific conversation
  });
});
```

### **2. Listen to User Status Updates**

```dart
final wsService = ref.watch(chatWebSocketServiceProvider);

wsService.userStatusStream.listen((status) {
  print('User ${status.username} is ${status.isOnline ? "online" : "offline"}');
  if (!status.isOnline && status.lastSeen != null) {
    print('Last seen: ${status.lastSeen}');
  }
  
  // Update UI
  setState(() {
    // Update user status indicator
  });
});
```

### **3. Send Heartbeat**

```dart
// In a StatefulWidget or HookWidget
Timer? _heartbeatTimer;

@override
void initState() {
  super.initState();
  
  final wsService = ref.read(chatWebSocketServiceProvider);
  
  // Start heartbeat timer
  _heartbeatTimer = Timer.periodic(Duration(seconds: 30), (timer) {
    wsService.sendHeartbeat();
  });
}

@override
void dispose() {
  _heartbeatTimer?.cancel();
  super.dispose();
}
```

## 📊 Data Flow

### **Conversation Update Flow**:

```
User A sends message
    ↓
Backend saves message
    ↓
Backend updates conversation.lastMessage
    ↓
Backend broadcasts "conversation.update" via WebSocket
    ↓
Flutter receives event
    ↓
Parse to ConversationUpdate object
    ↓
Emit to conversationUpdateStream
    ↓
conversationsProvider listens
    ↓
Invalidate provider
    ↓
Fetch fresh conversations
    ↓
UI updates with new lastMessage
```

### **User Status Update Flow**:

```
User connects/disconnects WebSocket
    ↓
Backend updates user.isOnline & user.lastSeen
    ↓
Backend broadcasts "user.status" via WebSocket
    ↓
Flutter receives event
    ↓
Parse to UserStatusUpdate object
    ↓
Emit to userStatusStream
    ↓
UI components listen
    ↓
Update online indicator & last seen text
```

## 🐛 Debugging

### **Check WebSocket Logs**:

```
📥 Raw WebSocket message: {"type":"conversation.update",...}
📦 Parsed data: {type: conversation.update, payload: {...}}
💬 Conversation update: 15
```

```
📥 Raw WebSocket message: {"type":"user.status",...}
📦 Parsed data: {type: user.status, payload: {...}}
👤 User status: 5 - true
```

```
💓 Sent heartbeat
📥 Raw WebSocket message: {"type":"heartbeat.ack",...}
💓 Heartbeat acknowledged
```

## ✅ Testing Checklist

- [ ] Connect to WebSocket successfully
- [ ] Receive `conversation.update` when message sent
- [ ] Conversations list refreshes automatically
- [ ] Receive `user.status` when user connects/disconnects
- [ ] User status updates in UI
- [ ] Heartbeat sent every 30 seconds
- [ ] Heartbeat acknowledgment received
- [ ] WebSocket reconnects after disconnect
- [ ] All events logged correctly

## 📝 Notes

- ✅ WebSocket URL: `ws://host:port/chattrix-api/ws/chat` (NO `/api` in path)
- ✅ Supports both wrapped and direct message formats
- ✅ Auto-invalidates providers for real-time UI updates
- ✅ Proper error handling and logging
- ✅ Clean disposal of stream controllers

---

**Implemented by**: Augment Agent  
**Date**: 2025-10-20  
**Files Modified**: 
- `lib/features/chat/data/services/chat_websocket_service.dart`
- `lib/features/chat/providers/chat_providers.dart`
- `REALTIME_UPDATES_DOCUMENTATION.md`

