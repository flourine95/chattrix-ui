# Hướng dẫn sử dụng WebSocket trong Chattrix UI

## Tổng quan

WebSocket đã được tích hợp vào ứng dụng Chattrix UI để hỗ trợ giao tiếp real-time. Hệ thống WebSocket tự động kết nối khi người dùng đăng nhập và lắng nghe các sự kiện từ server.

## Cấu trúc

### 1. WebSocket Service (`lib/features/chat/data/services/chat_websocket_service.dart`)

Service này quản lý kết nối WebSocket và xử lý các sự kiện:

**Các Stream có sẵn:**
- `messageStream`: Stream các tin nhắn mới
- `typingStream`: Stream các chỉ báo đang gõ
- `userStatusStream`: Stream trạng thái người dùng (online/offline)
- `connectionStream`: Stream trạng thái kết nối

**Các phương thức:**
- `connect(String accessToken)`: Kết nối WebSocket với access token
- `disconnect()`: Ngắt kết nối WebSocket
- `sendMessage(String conversationId, String content)`: Gửi tin nhắn
- `sendTypingStart(String conversationId)`: Gửi sự kiện bắt đầu gõ
- `sendTypingStop(String conversationId)`: Gửi sự kiện dừng gõ

### 2. WebSocket Connection Provider (`lib/features/chat/providers/chat_providers.dart`)

Provider quản lý trạng thái kết nối WebSocket:

```dart
final webSocketConnectionProvider = StateNotifierProvider<WebSocketConnectionNotifier, WebSocketConnectionState>((ref) {
  return WebSocketConnectionNotifier(ref);
});
```

**WebSocketConnectionState:**
- `isConnected`: Trạng thái kết nối (true/false)
- `error`: Thông báo lỗi (nếu có)

### 3. Messages Provider với Real-time Updates

Provider `messagesProvider` đã được nâng cấp để tự động cập nhật khi có tin nhắn mới từ WebSocket:

```dart
final messagesProvider = StateNotifierProvider.family<MessagesNotifier, AsyncValue<List<Message>>, String>((ref, conversationId) {
  return MessagesNotifier(ref, conversationId);
});
```

## Cách sử dụng

### 1. Trong Chat View Page

WebSocket đã được tích hợp sẵn trong `ChatViewPage`:

```dart
// Lấy trạng thái kết nối
final wsConnection = ref.watch(webSocketConnectionProvider);

// Lấy WebSocket service
final wsService = ref.watch(chatWebSocketServiceProvider);

// Kiểm tra trạng thái kết nối
if (wsConnection.isConnected) {
  // WebSocket đã kết nối
  wsService.sendMessage(chatId, text);
} else {
  // Sử dụng HTTP fallback
  final usecase = ref.read(sendMessageUsecaseProvider);
  await usecase(conversationId: chatId, content: text);
}
```

### 2. Hiển thị trạng thái kết nối

```dart
Text(
  wsConnection.isConnected ? 'Online' : 'Connecting...',
  style: textTheme.bodySmall?.copyWith(
    color: wsConnection.isConnected ? Colors.green : Colors.grey,
  ),
)
```

### 3. Lắng nghe tin nhắn real-time

Messages provider tự động lắng nghe và cập nhật khi có tin nhắn mới:

```dart
final messagesAsync = ref.watch(messagesProvider(chatId));

messagesAsync.when(
  data: (messages) {
    // Hiển thị danh sách tin nhắn
    // Tự động cập nhật khi có tin nhắn mới từ WebSocket
  },
  loading: () => CircularProgressIndicator(),
  error: (e, st) => Text('Error: $e'),
)
```

### 4. Gửi typing indicator

```dart
// Khi bắt đầu gõ
wsService.sendTypingStart(conversationId);

// Khi dừng gõ
wsService.sendTypingStop(conversationId);
```

### 5. Lắng nghe typing indicator

```dart
useEffect(() {
  final subscription = wsService.typingStream.listen((indicator) {
    if (indicator.conversationId == chatId) {
      // Hiển thị "User is typing..."
      print('${indicator.typingUsers.length} users are typing');
    }
  });
  
  return () => subscription.cancel();
}, []);
```

### 6. Lắng nghe user status

```dart
useEffect(() {
  final subscription = wsService.userStatusStream.listen((status) {
    print('${status.username} is ${status.isOnline ? "online" : "offline"}');
  });
  
  return () => subscription.cancel();
}, []);
```

## Cấu hình WebSocket URL

WebSocket URL được cấu hình trong `lib/core/constants/api_constants.dart`:

```dart
static String get wsBaseUrl {
  final httpUrl = baseUrl;
  final wsUrl = httpUrl.replaceFirst('http://', 'ws://');
  return wsUrl;
}

static const String chatWebSocket = '$apiVersion/chat';
```

**URL kết nối:** `ws://localhost:8080/chattrix-api/api/v1/chat?token={accessToken}`

## Format tin nhắn WebSocket

### Client → Server

**Gửi tin nhắn:**
```json
{
  "type": "chat.message",
  "payload": {
    "conversationId": "123",
    "content": "Hello!"
  }
}
```

**Typing indicator:**
```json
{
  "type": "typing.start",
  "payload": {
    "conversationId": "123"
  }
}
```

### Server → Client

**Tin nhắn mới:**
```json
{
  "type": "chat.message",
  "payload": {
    "id": 456,
    "content": "Hello!",
    "conversationId": "123",
    "sender": {
      "id": "user-id",
      "username": "john",
      "fullName": "John Doe"
    },
    "createdAt": "2024-01-01T00:00:00Z"
  }
}
```

**Typing indicator:**
```json
{
  "type": "typing.indicator",
  "payload": {
    "conversationId": "123",
    "typingUsers": [
      {
        "id": "user-id",
        "username": "john",
        "fullName": "John Doe"
      }
    ]
  }
}
```

**User status:**
```json
{
  "type": "user.status",
  "payload": {
    "userId": "user-id",
    "username": "john",
    "displayName": "John Doe",
    "isOnline": true,
    "lastSeen": "2024-01-01T00:00:00Z"
  }
}
```

## Xử lý lỗi

WebSocket service tự động xử lý lỗi và cập nhật trạng thái:

```dart
// Kiểm tra lỗi
if (wsConnection.error != null) {
  print('WebSocket error: ${wsConnection.error}');
}

// Thử kết nối lại
ref.read(webSocketConnectionProvider.notifier).reconnect();
```

## Auto-reconnect

Hiện tại WebSocket chưa có auto-reconnect. Bạn có thể thêm logic này vào `WebSocketConnectionNotifier`:

```dart
void _listenToConnection() {
  wsService.connectionStream.listen((isConnected) {
    if (!isConnected) {
      // Thử kết nối lại sau 5 giây
      Future.delayed(Duration(seconds: 5), () {
        reconnect();
      });
    }
  });
}
```

## Testing

Để test WebSocket:

1. Đảm bảo server WebSocket đang chạy
2. Đăng nhập vào ứng dụng
3. Mở chat view - WebSocket sẽ tự động kết nối
4. Gửi tin nhắn - tin nhắn sẽ được gửi qua WebSocket nếu đã kết nối
5. Kiểm tra console để xem logs kết nối

## Logs

WebSocket service có các logs để debug:

- `🔌 Connecting to WebSocket: {url}` - Đang kết nối
- `✅ WebSocket connected` - Kết nối thành công
- `📤 Sent message to conversation: {id}` - Đã gửi tin nhắn
- `📨 Received message: {id}` - Nhận được tin nhắn
- `⌨️ Typing indicator: {conversationId}` - Nhận typing indicator
- `👤 User status: {userId} - {isOnline}` - Nhận user status
- `❌ WebSocket error: {error}` - Lỗi WebSocket
- `🔌 WebSocket connection closed` - Kết nối đã đóng

## Tối ưu hóa

1. **Tránh duplicate messages**: Messages provider tự động kiểm tra và loại bỏ tin nhắn trùng lặp
2. **Auto-dispose**: WebSocket service tự động dispose khi provider bị dispose
3. **Broadcast streams**: Sử dụng broadcast streams để nhiều listeners có thể lắng nghe cùng lúc

## Troubleshooting

**WebSocket không kết nối:**
- Kiểm tra access token có hợp lệ không
- Kiểm tra server WebSocket có đang chạy không
- Kiểm tra URL WebSocket trong api_constants.dart

**Tin nhắn không real-time:**
- Kiểm tra `wsConnection.isConnected` có true không
- Kiểm tra logs trong console
- Thử refresh messages provider: `ref.read(messagesProvider(chatId).notifier).refresh()`

**Duplicate messages:**
- Messages provider đã có logic kiểm tra duplicate
- Nếu vẫn bị, kiểm tra message ID có unique không

