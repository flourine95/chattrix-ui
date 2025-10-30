# Hướng Dẫn Sử Dụng Reply và Reactions

## 🎯 Tính Năng Đã Hoàn Thành

### 1. **Reply (Trả lời tin nhắn)**
Cho phép bạn trả lời một tin nhắn cụ thể trong cuộc trò chuyện.

### 2. **Reactions (Biểu cảm)**
Cho phép bạn thêm emoji phản ứng vào tin nhắn.

---

## 📱 Cách Sử Dụng

### **Reply - Trả lời tin nhắn**

1. **Nhấn giữ** (long press) vào tin nhắn bạn muốn trả lời
2. Chọn **"Reply"** từ menu hiện ra
3. Một preview của tin nhắn sẽ xuất hiện phía trên ô nhập tin
4. Gõ nội dung trả lời của bạn
5. Nhấn gửi
6. Tin nhắn của bạn sẽ hiển thị kèm theo tin nhắn được trả lời (quoted message)

**Hủy reply:**
- Nhấn nút **X** trên preview để hủy reply

---

### **Reactions - Thêm biểu cảm**

#### Cách 1: Từ menu
1. **Nhấn giữ** (long press) vào tin nhắn
2. Chọn **"Add Reaction"**
3. Chọn emoji từ danh sách
4. Emoji sẽ xuất hiện dưới tin nhắn

#### Cách 2: Nhấn vào reaction có sẵn
1. Nếu tin nhắn đã có reactions
2. **Nhấn vào emoji** để toggle (thêm/xóa) reaction của bạn

**Lưu ý:**
- Mỗi người có thể react nhiều emoji khác nhau
- Số lượng người react sẽ hiển thị bên cạnh emoji
- Nhấn vào emoji đã react để xóa reaction

---

## 🔧 Chi Tiết Kỹ Thuật

### Cấu trúc Code

```
lib/features/chat/
├── domain/
│   ├── usecases/
│   │   └── toggle_reaction_usecase.dart    # Use case cho reactions
│   ├── repositories/
│   │   └── chat_repository.dart            # Interface với methods mới
│   └── datasources/
│       └── chat_remote_datasource.dart     # Interface datasource
│
├── data/
│   ├── repositories/
│   │   └── chat_repository_impl.dart       # Implementation repository
│   └── datasources/
│       └── chat_remote_datasource_impl.dart # Implementation datasource
│
└── presentation/
    ├── pages/
    │   └── chat_view_page.dart             # UI chính với reply/reaction
    ├── widgets/
    │   ├── message_bubble.dart             # Message bubble với callbacks
    │   ├── message_reactions.dart          # Widget hiển thị reactions
    │   └── reply_message_preview.dart      # Widget preview reply
    └── providers/
        └── chat_usecase_provider.dart      # Providers cho use cases
```

### API Endpoints Đã Thêm

```dart
// lib/core/constants/api_constants.dart

// POST/GET reactions
static String messageReactions(String messageId) =>
    '$messagesBase/$messageId/reactions';

// DELETE reaction
static String deleteReaction(String messageId, String emoji) =>
    '$messagesBase/$messageId/reactions/$emoji';
```

### WebSocket Support

```dart
// lib/features/chat/data/services/chat_websocket_service.dart

void sendMessage(
  String conversationId,
  String content, {
  int? replyToMessageId,  // ✅ Đã thêm support cho reply
})
```

---

## 🎨 UI Components

### 1. **BaseBubbleContainer**
- Xử lý long-press gesture
- Hiển thị menu options (Reply, Add Reaction)
- Hiển thị quoted message khi reply
- Hiển thị reactions dưới message

### 2. **MessageReactions Widget**
- Parse JSON reactions: `{"👍": [1, 2, 3], "❤️": [4, 5]}`
- Hiển thị emoji với số lượng người react
- Highlight emoji mà user đã react
- Callback khi tap vào reaction

### 3. **ReplyMessagePreview Widget**
- Hiển thị preview tin nhắn đang reply
- Nút cancel để hủy reply
- Tự động scroll khi có reply

### 4. **QuotedMessageWidget**
- Hiển thị tin nhắn được quote trong bubble
- Hiển thị tên người gửi và preview nội dung
- Support tất cả loại message (text, image, video, etc.)

---

## 🔄 Flow Hoạt Động

### Reply Flow:
```
User long-press message
    ↓
Show bottom sheet menu
    ↓
User tap "Reply"
    ↓
Set replyToMessage state
    ↓
Show ReplyMessagePreview above input
    ↓
User type & send
    ↓
Send via WebSocket/HTTP with replyToMessageId
    ↓
Message displayed with QuotedMessageWidget
```

### Reaction Flow:
```
User long-press message
    ↓
Show bottom sheet menu
    ↓
User tap "Add Reaction"
    ↓
Show emoji picker
    ↓
User select emoji
    ↓
Call toggleReaction API
    ↓
Refresh messages
    ↓
Reactions displayed below message
```

---

## ✅ Tính Năng Đã Implement

- ✅ Reply tin nhắn (text, image, video, audio, document, location)
- ✅ Hiển thị quoted message trong bubble
- ✅ Preview reply trước khi gửi
- ✅ Hủy reply
- ✅ Add reaction (emoji picker)
- ✅ Toggle reaction (add/remove)
- ✅ Hiển thị reactions với count
- ✅ Highlight reaction của user
- ✅ WebSocket support cho reply
- ✅ HTTP fallback
- ✅ Real-time updates
- ✅ Long-press gesture
- ✅ Bottom sheet menu
- ✅ Error handling
- ✅ Clean Architecture
- ✅ State management với Riverpod

---

## 🐛 Troubleshooting

### Vấn đề: Nhấn giữ tin nhắn không có gì xảy ra

**Giải pháp:**
- Đảm bảo bạn đang **nhấn giữ** (long press), không phải nhấn thường
- Kiểm tra xem callbacks (onReply, onAddReaction) đã được truyền vào MessageBubble chưa
- Kiểm tra console log xem có lỗi gì không

### Vấn đề: Reactions không hiển thị

**Nguyên nhân:** API trả về reactions dưới dạng object `{"👍": [1, 5]}`, nhưng code cũ convert sai thành string.

**Đã sửa:**
- ✅ Thêm `_convertReactionsToJson()` trong `MessageModel.fromApi()`
- ✅ Convert reactions object thành JSON string đúng format
- ✅ Parse JSON string trong `MessageReactions` widget
- ✅ Hiển thị reactions với emoji và count

**Kiểm tra:**
- Xem console log: `MessageReactions - reactions: {"👍": [1, 5]}`
- Xem console log: `MessageReactions - reactionsMap: {👍: [1, 5]}`
- Nếu thấy logs này thì reactions đang hoạt động

### Vấn đề: Reply không gửi được

**Giải pháp:**
- Kiểm tra WebSocket connection
- Kiểm tra HTTP fallback
- Kiểm tra replyToMessageId có được truyền đúng không
- Xem console log để debug

---

## 📝 Notes

- Tất cả message bubbles đều support reply và reactions
- Reactions được lưu dưới dạng JSON string: `"{\"👍\": [1, 5]}"`
- API trả về reactions dưới dạng object, được convert thành JSON string trong `MessageModel.fromApi()`
- Reply message được tìm trong danh sách messages hiện tại
- Nếu không tìm thấy replied message, sẽ không hiển thị quoted widget
- Long-press gesture hoạt động trên toàn bộ message bubble
- Bottom sheet menu tự động đóng sau khi chọn action
- Debug logs được thêm vào để kiểm tra reactions parsing

---

## 🚀 Cải Tiến Trong Tương Lai

- [ ] Fetch replied message từ API nếu không có trong list
- [ ] Animation khi thêm/xóa reaction
- [ ] Scroll to replied message khi tap vào quoted widget
- [ ] Custom emoji picker
- [ ] Reaction statistics
- [ ] Reply chain (thread)
- [ ] Edit/Delete reactions
- [ ] Reaction notifications

---

**Tác giả:** AI Assistant  
**Ngày cập nhật:** 2025-10-30  
**Version:** 1.0.0

