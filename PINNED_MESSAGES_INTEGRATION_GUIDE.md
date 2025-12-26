# Hướng dẫn tích hợp Pin Messages vào Chat View Page

## Các bước cần làm trong `lib/features/chat/presentation/pages/chat_view_page.dart`:

### 1. Thêm imports
```dart
import 'package:chattrix_ui/features/chat/presentation/widgets/pinned_messages_banner.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/pinned_messages_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
```

### 2. Trong build method, thêm watch pinnedMessages
Tìm dòng:
```dart
final conversationsAsync = ref.watch(conversationsProvider);
```

Thêm sau đó:
```dart
final pinnedMessagesAsync = ref.watch(pinnedMessagesProvider(chatId));
```

### 3. Thêm handler cho pin/unpin
Tìm function `handleConversationInfo()` và thêm sau đó:

```dart
Future<void> handlePinMessage(Message message) async {
  try {
    if (message.pinned) {
      // Unpin message
      await ref.read(unpinMessageUsecaseProvider)(
        conversationId: chatId,
        messageId: message.id.toString(),
      );
    } else {
      // Pin message
      await ref.read(pinMessageUsecaseProvider)(
        conversationId: chatId,
        messageId: message.id.toString(),
      );
    }

    // Refresh both messages and pinned messages
    ref.read(messagesProvider(chatId).notifier).refresh();
    ref.invalidate(pinnedMessagesProvider(chatId));

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Text(
              message.pinned ? 'Message unpinned' : 'Message pinned',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.grey.shade900,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
      ),
    );
  } catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text('Failed: $e', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: Colors.grey.shade900,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
```

### 4. Thêm PinnedMessagesBanner vào UI
Tìm phần body của Scaffold, sau AppBar. Tìm:
```dart
body: GestureDetector(
  onTap: () { ... },
  child: Column(
    children: [
      Expanded(
```

Thay đổi thành:
```dart
body: GestureDetector(
  onTap: () { ... },
  child: Column(
    children: [
      // Pinned Messages Banner
      if (pinnedMessagesAsync.hasValue && pinnedMessagesAsync.value!.isNotEmpty)
        PinnedMessagesBanner(
          pinnedMessages: pinnedMessagesAsync.value!,
          conversationId: chatId,
        ),
      Expanded(
```

### 5. Thêm onPin callback vào _MessageList
Tìm nơi gọi `_MessageList` (khoảng dòng 780):
```dart
_MessageList(
  messagesAsync: messagesAsync,
  me: me,
  conversation: conversation,
  scrollController: scrollController,
  typingIndicator: typingIndicator,
  highlightedMessageId: highlightedMessageId.value,
  onReply: (m) => replyToMessage.value = m,
  onReactionTap: (m, e) async { ... },
  onAddReaction: (m) => showReactionPicker(...),
  onEdit: (m) async { ... },
  onDelete: (m) async { ... },
),
```

Thêm:
```dart
onPin: handlePinMessage,
```

### 6. Cập nhật _MessageList class
Tìm class `_MessageList` (khoảng dòng 1085):

Thêm field:
```dart
final Function(Message) onPin;
```

Thêm vào constructor:
```dart
const _MessageList({
  required this.messagesAsync,
  required this.me,
  required this.conversation,
  required this.scrollController,
  required this.typingIndicator,
  this.highlightedMessageId,
  required this.onReply,
  required this.onReactionTap,
  required this.onAddReaction,
  required this.onEdit,
  required this.onDelete,
  required this.onPin,  // <-- THÊM DÒNG NÀY
});
```

### 7. Truyền onPin vào MessageBubble
Tìm nơi tạo MessageBubble trong _MessageList (có nhiều chỗ), thêm:
```dart
onPin: () => onPin(m),
```

Ví dụ:
```dart
MessageBubble(
  message: m,
  isMe: isMe,
  currentUserId: me?.id,
  replyToMessage: m.replyToMessage,
  onReply: () => onReply(m),
  onReactionTap: (e) => onReactionTap(m, e),
  onAddReaction: () => onAddReaction(m),
  onEdit: isMe && m.type.toUpperCase() == 'TEXT' ? () => onEdit(m) : null,
  onDelete: isMe ? () => onDelete(m) : null,
  onPin: () => onPin(m),  // <-- THÊM DÒNG NÀY
  isGroup: isGroup,
  isLastMessage: isLastMessageFromMe,
  isHighlighted: m.id == highlightedMessageId,
),
```

## WebSocket Integration

Để handle WebSocket events cho pin/unpin messages, thêm vào WebSocket message handler:

```dart
case 'message.pin':
  final payload = data['payload'] as Map<String, dynamic>;
  final type = payload['type'] as String;
  
  if (type == 'MESSAGE_PINNED' || type == 'MESSAGE_UNPINNED') {
    // Refresh messages and pinned messages
    ref.read(messagesProvider(conversationId).notifier).refresh();
    ref.invalidate(pinnedMessagesProvider(conversationId));
  }
  break;
```

## Testing

1. Long press vào tin nhắn → Chọn "Pin"
2. Kiểm tra banner hiển thị ở dưới header
3. Click vào banner → Xem danh sách pinned messages
4. Unpin message từ danh sách
5. Kiểm tra giới hạn 3 tin nhắn (API sẽ trả lỗi nếu vượt quá)
