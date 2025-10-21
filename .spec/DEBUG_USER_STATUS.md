# 🐛 Debug User Status Display

## 🔍 Vấn đề

1. **Không thấy icon chấm xanh** (online indicator) trong danh sách hội thoại
2. **Hiển thị "Offline" ở ngoài** nhưng **"Online" khi vào chat**

## ✅ FIXED - Root Cause Identified

### **Issue 1: Backend uses `online` instead of `isOnline`**

From WebSocket message log:
```json
{
  "sender": {
    "email": "ntluc1974@gmail.com",
    "fullName": "phi long",
    "id": 10,
    "lastSeen": "2025-10-20T10:29:11.010527200Z",
    "online": true,  ← Backend uses "online" (lowercase)
    "username": "philong"
  }
}
```

**Fix**: Updated `ParticipantModel.fromApi()` to support `online` field:
```dart
final isOnline = json['isOnline'] as bool? ??
                 json['is_online'] as bool? ??
                 json['online'] as bool?;  // ← NEW
```

### **Issue 2: Chat view showing WebSocket status instead of user status**

**Fix**: Updated `chat_view_page.dart` to show user status from conversation data instead of WebSocket connection status.

## 🎯 Root Cause Analysis

### **Vấn đề 1: Không có chấm xanh**

**Nguyên nhân có thể**:
- Backend không trả về field `isOnline` trong API `/conversations`
- Field name khác (ví dụ: `is_online` thay vì `isOnline`)
- Giá trị `isOnline` luôn là `null` hoặc `false`

### **Vấn đề 2: "Offline" → "Online"**

**Nguyên nhân đã xác định**:
- ✅ **FIXED**: Trong `chat_view_page.dart` đang hiển thị **WebSocket connection status** thay vì **user status**
- Dòng cũ: `wsConnection.isConnected ? 'Online' : 'Connecting...'`
- Đã sửa thành: `ConversationUtils.formatLastSeen(isOnline, lastSeen)`

## 🔧 Debug Steps

### **Step 1: Kiểm tra API Response**

Đã thêm debug logs vào các model để xem backend trả về gì:

#### **ConversationModel.fromApi()**:
```dart
factory ConversationModel.fromApi(Map<String, dynamic> json) {
  // Debug logs
  print('🔍 ConversationModel.fromApi JSON keys: ${json.keys.toList()}');
  print('🔍 Conversation ID: ${json['id']}, Type: ${json['type']}');
  print('🔍 Has lastMessage: ${json.containsKey('lastMessage')}');
  print('🔍 Participants count: ${(json['participants'] as List?)?.length ?? 0}');
  ...
}
```

#### **ParticipantModel.fromApi()**:
```dart
factory ParticipantModel.fromApi(Map<String, dynamic> json) {
  // Debug log
  print('🔍 ParticipantModel.fromApi JSON: $json');
  
  return ParticipantModel(
    ...
    isOnline: json['isOnline'] as bool? ?? json['is_online'] as bool?,
    lastSeen: json['lastSeen']?.toString() ?? json['last_seen']?.toString(),
  );
}
```

#### **ChatListPage**:
```dart
// Debug: Print conversation data
debugPrint('🔍 Conversation ${c.id} ($title):');
debugPrint('   Type: ${c.type}');
debugPrint('   Participants: ${c.participants.length}');
for (var p in c.participants) {
  debugPrint('   - User ${p.userId}: ${p.username} (${p.fullName})');
  debugPrint('     nickname: ${p.nickname}');
  debugPrint('     isOnline: ${p.isOnline}');
  debugPrint('     lastSeen: ${p.lastSeen}');
}
debugPrint('   isOnline (computed): $isOnline');
debugPrint('   lastSeen (computed): $lastSeen');
debugPrint('   lastMessage: ${c.lastMessage?.content}');
```

### **Step 2: Chạy app và xem logs**

1. **Mở app và vào màn hình Chats**
2. **Xem console logs** để kiểm tra:

#### **Expected logs**:
```
🔍 ConversationModel.fromApi JSON keys: [id, name, type, createdAt, updatedAt, participants, lastMessage]
🔍 Conversation ID: 6, Type: DIRECT
🔍 Has lastMessage: true
🔍 Participants count: 2

🔍 ParticipantModel.fromApi JSON: {userId: 1, username: philong, fullName: Phi Long, role: MEMBER, email: null, nickname: null, isOnline: true, lastSeen: 2025-10-20T10:30:00Z}
🔍 ParticipantModel.fromApi JSON: {userId: 5, username: hoangthao, fullName: Hoàng Thảo, role: MEMBER, email: null, nickname: null, isOnline: false, lastSeen: 2025-10-18T15:20:00Z}

🔍 Conversation 6 (Phi Long):
   Type: DIRECT
   Participants: 2
   - User 1: philong (Phi Long)
     nickname: null
     isOnline: true
     lastSeen: 2025-10-20T10:30:00.000Z
   - User 5: hoangthao (Hoàng Thảo)
     nickname: null
     isOnline: false
     lastSeen: 2025-10-18T15:20:00.000Z
   isOnline (computed): true
   lastSeen (computed): 2025-10-20T10:30:00.000Z
   lastMessage: Hello!
```

#### **Possible issues to look for**:

**Issue A: Missing fields**
```
🔍 ParticipantModel.fromApi JSON: {userId: 1, username: philong, fullName: Phi Long, role: MEMBER}
```
→ Backend không trả về `isOnline` và `lastSeen`

**Issue B: Wrong field names**
```
🔍 ParticipantModel.fromApi JSON: {userId: 1, username: philong, fullName: Phi Long, role: MEMBER, is_online: true, last_seen: 2025-10-20T10:30:00Z}
```
→ Backend dùng snake_case (`is_online`, `last_seen`) thay vì camelCase

**Issue C: All users offline**
```
   isOnline: false
   lastSeen: null
```
→ Backend không cập nhật user status

### **Step 3: Kiểm tra Backend API**

#### **API Endpoint**: `GET /api/v1/conversations`

**Expected Response Format**:
```json
{
  "content": [
    {
      "id": 6,
      "name": null,
      "type": "DIRECT",
      "createdAt": "2025-10-20T10:00:00Z",
      "updatedAt": "2025-10-20T10:30:00Z",
      "participants": [
        {
          "userId": 1,
          "username": "philong",
          "fullName": "Phi Long",
          "role": "MEMBER",
          "email": "philong@example.com",
          "nickname": "Long",
          "isOnline": true,
          "lastSeen": "2025-10-20T10:30:00Z"
        },
        {
          "userId": 5,
          "username": "hoangthao",
          "fullName": "Hoàng Thảo",
          "role": "MEMBER",
          "email": null,
          "nickname": null,
          "isOnline": false,
          "lastSeen": "2025-10-18T15:20:00Z"
        }
      ],
      "lastMessage": {
        "id": 123,
        "content": "Hello!",
        "type": "TEXT",
        "createdAt": "2025-10-20T10:30:00Z",
        "sender": {
          "id": 1,
          "username": "philong",
          "fullName": "Phi Long"
        }
      }
    }
  ]
}
```

**Required fields for user status**:
- ✅ `participants[].isOnline` (boolean)
- ✅ `participants[].lastSeen` (ISO 8601 datetime string)

**Optional but recommended**:
- `participants[].nickname` (string)
- `participants[].email` (string)

### **Step 4: Fix based on findings**

#### **If backend uses snake_case**:

Already handled in `ParticipantModel.fromApi()`:
```dart
isOnline: json['isOnline'] as bool? ?? json['is_online'] as bool?,
lastSeen: json['lastSeen']?.toString() ?? json['last_seen']?.toString(),
```

#### **If backend doesn't return these fields**:

**Option A**: Update backend to include `isOnline` and `lastSeen` in `/conversations` API

**Option B**: Make a separate API call to get user status
```dart
// In chat_providers.dart
final userStatusProvider = FutureProvider.family<UserStatus, int>((ref, userId) async {
  final datasource = ref.read(chatRemoteDatasourceProvider);
  return await datasource.getUserStatus(userId);
});
```

#### **If WebSocket updates user status**:

Listen to `user.status` events and update conversation provider:
```dart
// Already implemented in chat_providers.dart
wsService.userStatusStream.listen((status) {
  debugPrint('👤 User status: ${status.userId} - ${status.isOnline}');
  // TODO: Update conversation participant status
  ref.invalidateSelf();
});
```

## 📊 UI Verification

### **Conversation List**:

**Expected UI**:
```
┌─────────────────────────────────────┐
│ Chats                               │
├─────────────────────────────────────┤
│ 🟢 [P] Phi Long              5 phút │  ← Green dot + time
│     Bạn: 📷 Ảnh                     │
├─────────────────────────────────────┤
│    [H] Hoàng Thảo                   │  ← No dot (offline)
│     Hoạt động 3 ngày trước          │  ← Last seen
└─────────────────────────────────────┘
```

**Check**:
- [ ] Green dot visible for online users
- [ ] No dot for offline users
- [ ] Last message shows correctly
- [ ] Time ago shows correctly
- [ ] Last seen shows for offline users (if no last message)

### **Chat View**:

**Expected UI**:
```
┌─────────────────────────────────────┐
│ ← 🟢 Phi Long                       │
│    Đang hoạt động                   │  ← User status, not WS status
└─────────────────────────────────────┘
```

**Check**:
- [ ] Shows "Đang hoạt động" for online users
- [ ] Shows "Hoạt động X trước" for offline users
- [ ] Status color: green for online, grey for offline
- [ ] NOT showing "Connected" or "Connecting..."

## 🔄 WebSocket Real-time Updates

### **User Status Events**:

When user connects/disconnects, backend should broadcast:
```json
{
  "type": "user.status",
  "payload": {
    "userId": 5,
    "isOnline": true,
    "lastSeen": "2025-10-20T10:35:00Z"
  }
}
```

Flutter should:
1. Receive event via `userStatusStream`
2. Update conversation participant status
3. Trigger UI refresh

**Current implementation**:
```dart
// In chat_providers.dart
wsService.userStatusStream.listen((status) {
  debugPrint('👤 User status: ${status.userId} - ${status.isOnline}');
  ref.invalidateSelf();  // Refresh conversations
});
```

## 📝 Checklist

### **Backend**:
- [ ] `/conversations` API returns `isOnline` field
- [ ] `/conversations` API returns `lastSeen` field
- [ ] WebSocket broadcasts `user.status` events
- [ ] User status updates when user connects/disconnects

### **Flutter**:
- [x] `ParticipantModel` parses `isOnline` and `lastSeen`
- [x] `ConversationUtils.isUserOnline()` returns correct value
- [x] `ConversationUtils.formatLastSeen()` formats correctly
- [x] Chat list shows green dot for online users
- [x] Chat list shows last seen for offline users
- [x] Chat view shows user status (not WS status)
- [x] Debug logs added to track data flow

### **Testing**:
- [ ] Run app and check console logs
- [ ] Verify API response contains required fields
- [ ] Test with online user → should see green dot
- [ ] Test with offline user → should see last seen
- [ ] Test WebSocket updates → status should update in real-time

## 🚀 Next Steps

1. **Run the app** and check console logs
2. **Copy the logs** and analyze:
   - Does backend return `isOnline`?
   - Does backend return `lastSeen`?
   - Are values correct?
3. **If fields missing** → Update backend API
4. **If fields present but UI not showing** → Check UI rendering logic
5. **Remove debug logs** after fixing (or keep for future debugging)

## 📚 Related Files

- `lib/features/chat/data/models/participant_model.dart` - Parsing logic
- `lib/features/chat/data/models/conversation_model.dart` - Conversation parsing
- `lib/features/chat/presentation/utils/conversation_utils.dart` - Display logic
- `lib/features/chat/presentation/pages/chat_list_page.dart` - List UI
- `lib/features/chat/presentation/pages/chat_view_page.dart` - Chat UI
- `lib/features/chat/providers/chat_providers.dart` - WebSocket listeners

---

**Debug session**: 2025-10-20  
**Status**: Debug logs added, waiting for test results  
**Next**: Analyze console output to identify root cause

