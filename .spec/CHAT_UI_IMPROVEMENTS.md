# 💬 Chat UI Improvements - Conversation Display & Scroll Behavior

## 📋 Tổng quan

Đã cập nhật màn hình chat và danh sách hội thoại với các tính năng mới:
- Hiển thị tên đoạn chat theo quy tắc (GROUP vs DIRECT với nickname fallback)
- Hiển thị tin nhắn cuối cùng với format đặc biệt
- Hiển thị trạng thái online/offline và last seen
- Cải thiện scroll behavior trong chat view

## ✨ Tính năng đã thêm

### 1. **Conversation Title Display Rules**

#### **GROUP Conversations**:
- **Ưu tiên 1**: Hiển thị `conversation.name` nếu có
- **Fallback**: Gộp tên thành viên (tối đa 3 người, cách nhau bằng dấu phẩy)

#### **DIRECT Conversations**:
- **Ưu tiên 1**: `contact.nickname` (nếu có)
- **Ưu tiên 2**: `contactUser.fullName` (nếu không có nickname)
- **Ưu tiên 3**: `contactUser.username` (nếu không có fullName)

### 2. **Last Message Display**

#### **Format Rules**:
- Nếu tin nhắn từ chính user → thêm tiền tố **"Bạn:"**
- Nếu tin nhắn là ảnh → hiển thị **"📷 Ảnh"**
- Nếu tin nhắn là file → hiển thị **"📎 Tệp"**
- Ngược lại → hiển thị nội dung tin nhắn

#### **Display Logic**:
- **DIRECT**: Hiển thị last message hoặc last seen status (nếu không có message)
- **GROUP**: Hiển thị last message

### 3. **User Status Display**

#### **Online Indicator**:
- Chấm xanh nhỏ bên cạnh avatar (chỉ cho DIRECT conversations)
- Hiển thị khi `contactUser.isOnline = true`

#### **Last Seen**:
- Nếu online: **"Đang hoạt động"**
- Nếu offline: **"Hoạt động X phút/giờ/ngày trước"**
- Tính dựa trên `lastSeen` timestamp

### 4. **Chat View Scroll Improvements**

#### **No Auto-Scroll on Open**:
- Không tự động scroll xuống khi mở chat
- User có thể xem tin nhắn cũ ngay lập tức

#### **Scroll on New Message**:
- Chỉ scroll xuống khi có tin mới **VÀ** user đang ở gần cuối (trong vòng 200px)
- Không scroll nếu user đang xem tin cũ

#### **Floating Scroll Button**:
- Hiển thị nút "cuộn xuống" khi user scroll lên > 100px
- Click để scroll xuống cuối với animation mượt

## 🏗️ Implementation Details

### **1. Updated Entities**

#### **Conversation Entity**:
```dart
@freezed
abstract class Conversation with _$Conversation {
  const factory Conversation({
    required int id,
    String? name,
    required String type,
    required DateTime createdAt,
    required DateTime updatedAt,
    required List<Participant> participants,
    Message? lastMessage,  // ← NEW
  }) = _Conversation;
}
```

#### **Participant Entity**:
```dart
@freezed
abstract class Participant with _$Participant {
  const factory Participant({
    required int userId,
    required String username,
    required String fullName,
    required String role,
    String? email,        // ← NEW
    String? nickname,     // ← NEW
    bool? isOnline,       // ← NEW
    DateTime? lastSeen,   // ← NEW
  }) = _Participant;
}
```

### **2. Utility Functions**

Created `lib/features/chat/presentation/utils/conversation_utils.dart`:

#### **getConversationTitle()**:
```dart
static String getConversationTitle(Conversation conversation, User? currentUser) {
  if (conversation.type.toUpperCase() == 'GROUP') {
    // Use conversation.name or combine participant names
    if (conversation.name != null && conversation.name!.isNotEmpty) {
      return conversation.name!;
    }
    
    final otherParticipants = conversation.participants
        .where((p) => p.userId != currentUser?.id)
        .take(3)
        .toList();
    
    return otherParticipants
        .map((p) => p.fullName.isNotEmpty ? p.fullName : p.username)
        .join(', ');
  } else {
    // DIRECT: nickname → fullName → username
    final otherParticipant = conversation.participants.firstWhere(
      (p) => p.userId != currentUser?.id,
      orElse: () => conversation.participants.first,
    );
    
    if (otherParticipant.nickname != null && otherParticipant.nickname!.isNotEmpty) {
      return otherParticipant.nickname!;
    }
    
    if (otherParticipant.fullName.isNotEmpty) {
      return otherParticipant.fullName;
    }
    
    return otherParticipant.username;
  }
}
```

#### **formatLastMessage()**:
```dart
static String formatLastMessage(Message? lastMessage, User? currentUser) {
  if (lastMessage == null) {
    return 'No messages yet';
  }
  
  String content;
  
  // Check message type
  if (lastMessage.type.toUpperCase() == 'IMAGE') {
    content = '📷 Ảnh';
  } else if (lastMessage.type.toUpperCase() == 'FILE') {
    content = '📎 Tệp';
  } else {
    content = lastMessage.content;
  }
  
  // Add "Bạn: " prefix if message is from current user
  if (currentUser != null && lastMessage.sender.id == currentUser.id) {
    return 'Bạn: $content';
  }
  
  return content;
}
```

#### **formatTimeAgo()**:
```dart
static String formatTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  
  if (difference.inSeconds < 60) {
    return 'Vừa xong';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} phút trước';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} giờ trước';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} ngày trước';
  } else if (difference.inDays < 30) {
    final weeks = (difference.inDays / 7).floor();
    return '$weeks tuần trước';
  } else if (difference.inDays < 365) {
    final months = (difference.inDays / 30).floor();
    return '$months tháng trước';
  } else {
    final years = (difference.inDays / 365).floor();
    return '$years năm trước';
  }
}
```

#### **formatLastSeen()**:
```dart
static String formatLastSeen(bool isOnline, DateTime? lastSeen) {
  if (isOnline) {
    return 'Đang hoạt động';
  }
  
  if (lastSeen == null) {
    return 'Offline';
  }
  
  return 'Hoạt động ${formatTimeAgo(lastSeen)}';
}
```

### **3. Updated Chat List Page**

File: `lib/features/chat/presentation/pages/chat_list_page.dart`

#### **Key Changes**:

1. **Use ConversationUtils for title**:
```dart
final title = ConversationUtils.getConversationTitle(c, me);
```

2. **Format last message**:
```dart
final lastMessageText = ConversationUtils.formatLastMessage(c.lastMessage, me);
```

3. **Check online status**:
```dart
final isOnline = ConversationUtils.isUserOnline(c, me);
final lastSeen = ConversationUtils.getLastSeen(c, me);
```

4. **Display subtitle based on type**:
```dart
String subtitle;
if (c.type.toUpperCase() == 'DIRECT') {
  if (c.lastMessage != null) {
    subtitle = lastMessageText;
  } else {
    subtitle = ConversationUtils.formatLastSeen(isOnline, lastSeen);
  }
} else {
  subtitle = lastMessageText;
}
```

5. **Online indicator**:
```dart
leading: Stack(
  children: [
    CircleAvatar(...),
    // Online indicator for DIRECT conversations
    if (c.type.toUpperCase() == 'DIRECT' && isOnline)
      Positioned(
        right: 0,
        bottom: 0,
        child: Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).scaffoldBackgroundColor,
              width: 2,
            ),
          ),
        ),
      ),
  ],
),
```

6. **Time ago in trailing**:
```dart
trailing: c.lastMessage != null
    ? Text(
        ConversationUtils.formatTimeAgo(c.lastMessage!.createdAt),
        style: textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      )
    : null,
```

### **4. Updated Chat View Page**

File: `lib/features/chat/presentation/pages/chat_view_page.dart`

#### **Key Changes**:

1. **Added scroll controller and state**:
```dart
final scrollController = useScrollController();
final showScrollButton = useState(false);
final previousMessageCount = useRef(0);
```

2. **Listen to scroll position**:
```dart
useEffect(() {
  void onScroll() {
    if (scrollController.hasClients) {
      final isAtBottom = scrollController.position.pixels >= 
          scrollController.position.maxScrollExtent - 100;
      showScrollButton.value = !isAtBottom;
    }
  }
  
  scrollController.addListener(onScroll);
  return () => scrollController.removeListener(onScroll);
}, [scrollController]);
```

3. **Scroll only on new message (if near bottom)**:
```dart
useEffect(() {
  messagesAsync.whenData((messages) {
    if (messages.length > previousMessageCount.value && scrollController.hasClients) {
      // Only scroll if we're already near the bottom
      final isNearBottom = scrollController.position.pixels >= 
          scrollController.position.maxScrollExtent - 200;
      
      if (isNearBottom) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    }
    previousMessageCount.value = messages.length;
  });
  return null;
}, [messagesAsync]);
```

4. **Floating scroll button**:
```dart
body: Stack(
  children: [
    Column(
      children: [
        Expanded(
          child: messagesAsync.when(
            data: (messages) {
              return ListView.builder(
                controller: scrollController,  // ← Added controller
                ...
              );
            },
            ...
          ),
        ),
        _InputBar(...),
      ],
    ),
    // Floating scroll to bottom button
    if (showScrollButton.value)
      Positioned(
        right: 16,
        bottom: 80,
        child: FloatingActionButton.small(
          onPressed: scrollToBottom,
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          child: const Icon(Icons.keyboard_arrow_down),
        ),
      ),
  ],
),
```

## 📊 UI Examples

### **Conversation List**:

```
┌─────────────────────────────────────┐
│ Chats                               │
├─────────────────────────────────────┤
│ 🟢 [A] Phi Long                     │ 5 phút trước
│     Bạn: 📷 Ảnh                     │
├─────────────────────────────────────┤
│    [G] Team Project                 │ 2 giờ trước
│     John: Let's meet tomorrow       │
├─────────────────────────────────────┤
│    [H] Hoàng Thảo                   │
│     Hoạt động 3 ngày trước          │
└─────────────────────────────────────┘
```

### **Chat View with Scroll Button**:

```
┌─────────────────────────────────────┐
│ ← [A] Phi Long                      │
│    Đang hoạt động                   │
├─────────────────────────────────────┤
│                                     │
│  Hello!                             │
│                                     │
│                     How are you? ▐  │
│                                     │
│  I'm good, thanks!                  │
│                                     │
│                                  ⬇  │ ← Scroll button
│                                     │
├─────────────────────────────────────┤
│ 📎  [Type a message...]         ✈  │
└─────────────────────────────────────┘
```

## 🎯 Testing Checklist

### **Conversation List**:
- [ ] GROUP với name hiển thị đúng name
- [ ] GROUP không có name hiển thị tên thành viên (max 3)
- [ ] DIRECT hiển thị nickname nếu có
- [ ] DIRECT fallback sang fullName nếu không có nickname
- [ ] DIRECT fallback sang username nếu không có fullName
- [ ] Last message từ user hiển thị "Bạn: ..."
- [ ] Last message là ảnh hiển thị "📷 Ảnh"
- [ ] Last message là file hiển thị "📎 Tệp"
- [ ] Online indicator hiển thị cho DIRECT conversations
- [ ] Last seen hiển thị đúng format
- [ ] Time ago hiển thị đúng

### **Chat View**:
- [ ] Không auto-scroll khi mở chat
- [ ] Scroll xuống khi gửi tin nhắn
- [ ] Scroll xuống khi nhận tin mới (nếu đang ở cuối)
- [ ] Không scroll khi nhận tin mới (nếu đang xem tin cũ)
- [ ] Scroll button hiển thị khi scroll lên
- [ ] Scroll button ẩn khi ở cuối
- [ ] Click scroll button scroll xuống mượt

## 📝 Files Modified

1. `lib/features/chat/domain/entities/conversation.dart` - Added lastMessage field
2. `lib/features/chat/domain/entities/participant.dart` - Added email, nickname, isOnline, lastSeen
3. `lib/features/chat/data/models/conversation_model.dart` - Added lastMessage parsing
4. `lib/features/chat/data/models/participant_model.dart` - Added new fields parsing
5. `lib/features/chat/presentation/utils/conversation_utils.dart` - **NEW** utility functions
6. `lib/features/chat/presentation/pages/chat_list_page.dart` - Updated UI with new display logic
7. `lib/features/chat/presentation/pages/chat_view_page.dart` - Added scroll improvements

## 📚 Related Documentation

- `FLUTTER_REALTIME_UPDATES_IMPLEMENTATION.md` - WebSocket real-time updates
- `WEBSOCKET_AUTO_RECONNECT_FIX.md` - Auto-reconnect and heartbeat
- `REALTIME_UPDATES_DOCUMENTATION.md` - Backend WebSocket documentation

---

**Implemented by**: Augment Agent  
**Date**: 2025-10-20  
**Features**: Conversation display rules, last message formatting, user status, scroll improvements

