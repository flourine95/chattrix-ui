# 🔍 Tính năng Tìm kiếm Người dùng (User Search Feature)

## 📋 Tổng quan

Tính năng tìm kiếm người dùng cho phép bạn tìm kiếm bất kỳ người dùng nào trong hệ thống và bắt đầu cuộc trò chuyện với họ. Tính năng này được tích hợp vào trang **New Chat** với khả năng tìm kiếm real-time, debounce, và hiển thị thông tin chi tiết về người dùng.

## ✨ Tính năng chính

### 1. **Tìm kiếm Global**
- Tìm kiếm người dùng theo tên, username, hoặc email
- Kết quả tìm kiếm real-time với debounce 500ms
- Giới hạn 20 kết quả mỗi lần tìm kiếm

### 2. **Thông tin người dùng**
- **Avatar**: Hiển thị avatar hoặc chữ cái đầu với màu sắc ngẫu nhiên
- **Tên đầy đủ**: Hiển thị tên đầy đủ hoặc username
- **Username**: Hiển thị @username
- **Online Status**: Chấm xanh cho người dùng đang online
- **Contact Badge**: Hiển thị badge "Contact" nếu đã là liên hệ
- **Conversation Status**: Hiển thị "Already chatting" nếu đã có cuộc trò chuyện

### 3. **Smart Navigation**
- Nếu đã có cuộc trò chuyện → Navigate đến cuộc trò chuyện hiện có
- Nếu chưa có → Tạo cuộc trò chuyện mới (DIRECT)

### 4. **UI States**
- **Empty Query**: Hiển thị hướng dẫn tìm kiếm
- **Loading**: Hiển thị loading indicator
- **Error**: Hiển thị thông báo lỗi
- **No Results**: Hiển thị "No users found"
- **Results**: Hiển thị danh sách người dùng

## 🎯 Cách sử dụng

### Bước 1: Mở trang New Chat
1. Mở app và đăng nhập
2. Ở **Chat List Page**, nhấn nút **FAB** (biểu tượng bút) góc dưới phải
3. Trang **New Chat** sẽ mở ra

### Bước 2: Tìm kiếm người dùng
1. Nhập từ khóa vào ô tìm kiếm (tên, username, hoặc email)
2. Đợi 500ms → Kết quả tìm kiếm sẽ hiển thị
3. Xem danh sách người dùng phù hợp

### Bước 3: Bắt đầu chat
1. Nhấn vào người dùng bạn muốn chat
2. Nếu đã có cuộc trò chuyện → Mở cuộc trò chuyện hiện có
3. Nếu chưa có → Tạo cuộc trò chuyện mới và mở

## 🏗️ Kiến trúc kỹ thuật

### 1. **API Endpoint**

```
GET /api/v1/users/search
```

**Query Parameters:**
- `query` (required): Từ khóa tìm kiếm
- `limit` (optional): Số kết quả tối đa (default: 20, max: 50)

**Response:**
```json
{
  "data": [
    {
      "id": 1,
      "username": "john_doe",
      "email": "john@example.com",
      "fullName": "John Doe",
      "avatarUrl": "https://...",
      "online": true,
      "lastSeen": "2025-10-20T10:30:00Z",
      "contact": true,
      "hasConversation": true,
      "conversationId": 123
    }
  ]
}
```

### 2. **Clean Architecture Layers**

#### **Domain Layer**
- **Entity**: `SearchUser` (lib/features/chat/domain/entities/search_user.dart)
  - Chứa thông tin người dùng từ kết quả tìm kiếm
  - Bao gồm: id, username, email, fullName, avatarUrl, isOnline, lastSeen, contact, hasConversation, conversationId

- **Repository Interface**: `ChatRepository.searchUsers()`
  - Abstract method để tìm kiếm người dùng

- **Use Case**: `SearchUsersUsecase` (lib/features/chat/domain/usecases/search_users_usecase.dart)
  - Business logic cho tìm kiếm người dùng
  - Gọi repository và trả về kết quả

#### **Data Layer**
- **Model**: `SearchUserModel` (lib/features/chat/data/models/search_user_model.dart)
  - Data model với JSON serialization
  - Map từ JSON response sang Entity

- **Datasource**: `ChatRemoteDatasource.searchUsers()`
  - Gọi API endpoint
  - Parse response thành `SearchUserModel`

- **Repository Implementation**: `ChatRepositoryImpl.searchUsers()`
  - Implement interface từ domain layer
  - Gọi datasource và handle errors

#### **Presentation Layer**
- **Page**: `NewChatPage` (lib/features/chat/presentation/pages/new_chat_page.dart)
  - HookConsumerWidget với search functionality
  - Sử dụng hooks: `useTextEditingController`, `useState`, `useEffect`
  - Debounce search với 500ms delay

- **Provider**: `searchUsersUsecaseProvider`
  - Provide `SearchUsersUsecase` instance

### 3. **Code Structure**

```
lib/features/chat/
├── domain/
│   ├── entities/
│   │   ├── search_user.dart
│   │   └── search_user.freezed.dart
│   ├── repositories/
│   │   └── chat_repository.dart (searchUsers method)
│   └── usecases/
│       └── search_users_usecase.dart
├── data/
│   ├── models/
│   │   ├── search_user_model.dart
│   │   ├── search_user_model.freezed.dart
│   │   └── search_user_model.g.dart
│   ├── datasources/
│   │   ├── chat_remote_datasource.dart (searchUsers method)
│   │   └── chat_remote_datasource_impl.dart
│   └── repositories/
│       └── chat_repository_impl.dart (searchUsers implementation)
├── presentation/
│   └── pages/
│       └── new_chat_page.dart (with search UI)
└── providers/
    └── chat_providers.dart (searchUsersUsecaseProvider)
```

## 🎨 UI Components

### 1. **Search TextField**
- Placeholder: "Search users..."
- Clear button (X) khi có text
- Auto-focus khi mở trang

### 2. **User Tile**
- **Avatar**: Circle avatar với màu sắc ngẫu nhiên (10 màu)
- **Title**: Tên đầy đủ hoặc username
- **Subtitle**: @username
- **Trailing**: 
  - Online indicator (chấm xanh)
  - Contact badge (chip màu xanh)
  - "Already chatting" text (màu xám)

### 3. **Empty States**
- **Empty Query**: Icon search + "Search for users" + "Enter a name, username, or email"
- **No Results**: Icon person_search + "No users found" + "Try a different search term"
- **Error**: Icon error_outline + "Search failed" + error message

## 🔧 Technical Details

### 1. **Debounce Implementation**
```dart
useEffect(() {
  final timer = Timer(const Duration(milliseconds: 500), () {
    if (query.isNotEmpty) {
      _performSearch(ref, query, isSearching, searchResults, error);
    }
  });
  return timer.cancel;
}, [query]);
```

### 2. **Smart Navigation Logic**
```dart
if (user.hasConversation && user.conversationId != null) {
  // Navigate to existing conversation
  context.push('/chat/${user.conversationId}');
} else {
  // Create new conversation
  final result = await createConversationUsecase(
    CreateConversationParams(
      type: ConversationType.direct,
      participantIds: [user.id],
    ),
  );
  // Navigate to new conversation
}
```

### 3. **Avatar Color Generation**
```dart
Color _avatarColor(BuildContext context, int userId) {
  final colors = [
    Colors.blue, Colors.green, Colors.orange, Colors.purple,
    Colors.pink, Colors.teal, Colors.indigo, Colors.cyan,
    Colors.amber, Colors.deepOrange,
  ];
  return colors[userId % colors.length];
}
```

## 📝 Testing Checklist

- [ ] Tìm kiếm với từ khóa hợp lệ
- [ ] Tìm kiếm với từ khóa không tồn tại
- [ ] Tìm kiếm với query rỗng
- [ ] Debounce hoạt động đúng (500ms)
- [ ] Hiển thị online status chính xác
- [ ] Hiển thị contact badge chính xác
- [ ] Hiển thị "Already chatting" chính xác
- [ ] Navigate đến conversation hiện có
- [ ] Tạo conversation mới thành công
- [ ] Handle lỗi API
- [ ] Handle lỗi network
- [ ] Clear search query
- [ ] Loading state hiển thị đúng
- [ ] Empty states hiển thị đúng

## 🚀 Future Enhancements

1. **Pagination**: Thêm infinite scroll cho kết quả tìm kiếm
2. **Filters**: Lọc theo online status, contacts only, etc.
3. **Recent Searches**: Lưu lịch sử tìm kiếm
4. **Search Suggestions**: Gợi ý tìm kiếm dựa trên lịch sử
5. **Advanced Search**: Tìm kiếm theo nhiều tiêu chí
6. **Search Highlights**: Highlight từ khóa trong kết quả
7. **Voice Search**: Tìm kiếm bằng giọng nói
8. **QR Code Scan**: Quét QR code để thêm người dùng

## 🐛 Known Issues

- Không có

## 📚 Related Documentation

- [WebSocket Integration](WEBSOCKET_GUIDE.md)
- [New Chat Feature](NEW_CHAT_FEATURE.md)
- [API Documentation](USER_SEARCH_API_TEST_EXAMPLES.md)

---

**Tác giả**: Augment Agent  
**Ngày tạo**: 2025-10-20  
**Phiên bản**: 1.0.0

