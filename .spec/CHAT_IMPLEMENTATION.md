# Chat Feature Implementation

## Overview

Tính năng chat đã được triển khai theo Clean Architecture với đầy đủ các layer:

### Cấu trúc thư mục

```
lib/features/chat/
├── domain/
│   ├── entities/          # Business entities
│   │   ├── conversation.dart
│   │   ├── message.dart
│   │   ├── message_sender.dart
│   │   ├── participant.dart
│   │   └── user_status.dart
│   ├── repositories/      # Repository interfaces
│   │   ├── chat_repository.dart
│   │   └── user_status_repository.dart
│   ├── datasources/       # Datasource interfaces
│   │   └── chat_remote_datasource.dart
│   └── usecases/          # Business logic
│       ├── create_conversation_usecase.dart
│       ├── get_conversation_usecase.dart
│       ├── get_conversations_usecase.dart
│       ├── get_messages_usecase.dart
│       ├── get_online_users_usecase.dart
│       └── get_user_status_usecase.dart
├── data/
│   ├── models/            # Data models với JSON serialization
│   │   ├── conversation_model.dart
│   │   ├── message_model.dart
│   │   ├── message_sender_model.dart
│   │   ├── participant_model.dart
│   │   └── user_status_model.dart
│   ├── datasources/       # API implementation
│   │   └── chat_remote_datasource_impl.dart
│   ├── repositories/      # Repository implementation
│   │   ├── chat_repository_impl.dart
│   │   └── user_status_repository_impl.dart
│   └── services/          # WebSocket service
│       └── chat_websocket_service.dart
├── presentation/
│   ├── pages/             # UI screens
│   └── providers/         # Riverpod providers
└── providers/
    └── chat_providers.dart # Main providers file
```

## Các bước để hoàn tất

### 1. Cài đặt dependencies

```bash
flutter pub get
```

### 2. Generate code cho Freezed và JSON Serializable

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Lệnh này sẽ tạo các file:
- `*.freezed.dart` - Code generation cho Freezed (immutable classes)
- `*.g.dart` - Code generation cho JSON serialization

### 3. Kiểm tra errors

Sau khi generate code, kiểm tra xem có lỗi nào không:

```bash
flutter analyze
```

## API Endpoints được implement

### REST API

1. **Conversations**
   - `POST /v1/conversations` - Tạo conversation mới
   - `GET /v1/conversations` - Lấy danh sách conversations
   - `GET /v1/conversations/{id}` - Lấy chi tiết conversation
   - `GET /v1/conversations/{id}/messages` - Lấy messages trong conversation

2. **User Status**
   - `GET /v1/users/status/online` - Lấy danh sách users online
   - `GET /v1/users/status/online/conversation/{id}` - Users online trong conversation
   - `GET /v1/users/status/{userId}` - Trạng thái của user cụ thể

### WebSocket API

- **Endpoint**: `ws://<server>/v1/chat?token=<JWT_TOKEN>`
- **Events từ client**:
  - `chat.message` - Gửi tin nhắn
  - `typing.start` - Bắt đầu typing
  - `typing.stop` - Dừng typing
  
- **Events từ server**:
  - `chat.message` - Nhận tin nhắn mới
  - `typing.indicator` - Ai đó đang typing
  - `user.status` - Cập nhật trạng thái user

## Sử dụng trong code

### 1. Lấy danh sách conversations

```dart
final conversationsAsync = ref.watch(conversationsProvider);

conversationsAsync.when(
  data: (conversations) => ListView.builder(
    itemCount: conversations.length,
    itemBuilder: (context, index) {
      final conv = conversations[index];
      return ListTile(title: Text(conv.name ?? 'Direct Chat'));
    },
  ),
  loading: () => CircularProgressIndicator(),
  error: (err, stack) => Text('Error: $err'),
);
```

### 2. Lấy messages trong conversation

```dart
final messagesAsync = ref.watch(messagesProvider('conversation-id'));

messagesAsync.when(
  data: (messages) => ListView.builder(
    itemCount: messages.length,
    itemBuilder: (context, index) {
      final msg = messages[index];
      return Text('${msg.sender.fullName}: ${msg.content}');
    },
  ),
  loading: () => CircularProgressIndicator(),
  error: (err, stack) => Text('Error: $err'),
);
```

### 3. Sử dụng WebSocket

```dart
// Trong widget hoặc provider
final wsService = ref.watch(chatWebSocketServiceProvider);

// Connect
await wsService.connect(accessToken);

// Listen to messages
wsService.messageStream.listen((message) {
  print('New message: ${message.content}');
});

// Send message
wsService.sendMessage('conversation-id', 'Hello!');

// Send typing indicator
wsService.sendTypingStart('conversation-id');

// Disconnect
await wsService.disconnect();
```

### 4. Tạo conversation mới

```dart
final createUsecase = ref.watch(createConversationUsecaseProvider);

final result = await createUsecase(
  type: 'DIRECT', // hoặc 'GROUP'
  participantIds: ['user-id-1', 'user-id-2'],
  name: 'Group Name', // optional, cho GROUP
);

result.fold(
  (failure) => print('Error: ${failure.message}'),
  (conversation) => print('Created: ${conversation.id}'),
);
```

## Lưu ý

1. **Authentication**: Tất cả các API requests đều cần JWT token, được tự động thêm vào header bởi `AuthDioClient`

2. **WebSocket**: Token được truyền qua query parameter khi connect WebSocket

3. **Error Handling**: Sử dụng `Either<Failure, T>` từ package `dartz` để handle errors một cách functional

4. **State Management**: Sử dụng Riverpod với `FutureProvider` cho async data và `Provider` cho dependencies

5. **Code Generation**: Luôn chạy build_runner sau khi thay đổi models hoặc entities

## TODO

- [ ] Implement UI cho chat list page
- [ ] Implement UI cho chat detail page
- [ ] Implement UI cho create conversation
- [ ] Add pagination cho messages
- [ ] Add local caching với Hive hoặc Drift
- [ ] Add notification handling
- [ ] Add file/image upload support
- [ ] Add message read receipts

