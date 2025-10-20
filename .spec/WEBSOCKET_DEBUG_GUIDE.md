# 🐛 WebSocket Debug Guide

## 🔍 Vấn đề hiện tại

**Lỗi**: `type 'Null' is not a subtype of type 'String' in type cast`

**Nguyên nhân**: Server đang gửi WebSocket message với format không khớp với Flutter mong đợi.

## 📊 Expected vs Actual Format

### **Flutter mong đợi** (Wrapped format):
```json
{
  "type": "chat.message",
  "payload": {
    "id": 123,
    "content": "Hello",
    "type": "TEXT",
    "createdAt": "2025-10-20T10:30:00Z",
    "conversationId": "6",
    "sender": {
      "id": 10,
      "username": "philong",
      "fullName": "Phi Long"
    }
  }
}
```

### **Server có thể đang gửi** (Direct format):
```json
{
  "id": 123,
  "content": "Hello",
  "type": "TEXT",
  "createdAt": "2025-10-20T10:30:00Z",
  "conversationId": "6",
  "senderId": 10,
  "senderUsername": "philong",
  "senderFullName": "Phi Long"
}
```

## ✅ Giải pháp đã áp dụng

### 1. **Enhanced Error Handling**

Thêm debug logs để xem raw message từ server:

```dart
void _handleMessage(dynamic message) {
  try {
    debugPrint('📥 Raw WebSocket message: $message');
    
    final data = jsonDecode(message as String) as Map<String, dynamic>;
    debugPrint('📦 Parsed data: $data');
    
    final type = data['type'] as String?;
    if (type == null) {
      debugPrint('⚠️ Message has no type field, treating as direct message');
      // Server might be sending message directly without wrapper
      final messageModel = MessageModel.fromApi(data);
      _messageController.add(messageModel);
      debugPrint('📨 Received direct message: ${messageModel.id}');
      return;
    }
    
    // ... rest of the code
  } catch (e, stackTrace) {
    debugPrint('❌ Error handling WebSocket message: $e');
    debugPrint('Stack trace: $stackTrace');
  }
}
```

### 2. **Support Both Formats**

- **Wrapped format**: `{ "type": "...", "payload": {...} }`
- **Direct format**: `{ "id": ..., "content": ..., ... }`

### 3. **Use `MessageModel.fromApi()`**

Sử dụng `fromApi()` thay vì `fromJson()` để handle nhiều format khác nhau:

```dart
// fromApi() can handle:
// - sender as object: { "sender": { "id": 10, ... } }
// - sender as flat fields: { "senderId": 10, "senderUsername": "...", ... }
// - different field names: id/messageId, createdAt/sentAt, etc.
final messageModel = MessageModel.fromApi(payload);
```

## 🧪 Testing Steps

### 1. **Run the app**
```bash
flutter run
```

### 2. **Send a message**
- Open a conversation
- Send a message
- Check Flutter logs

### 3. **Check logs for raw message**
```
📥 Raw WebSocket message: {"id":123,"content":"Hello",...}
📦 Parsed data: {id: 123, content: Hello, ...}
```

### 4. **Identify the format**

#### **If you see**:
```
📥 Raw WebSocket message: {"type":"chat.message","payload":{...}}
```
→ Server is using **wrapped format** ✅

#### **If you see**:
```
📥 Raw WebSocket message: {"id":123,"content":"Hello",...}
⚠️ Message has no type field, treating as direct message
```
→ Server is using **direct format** ✅ (now supported)

## 🔧 Backend Configuration Needed

### **Option 1: Update Backend to use Wrapped Format** (Recommended)

```java
// ChatServerEndpoint.java
@OnMessage
public void onMessage(String message, Session session) {
    // Parse incoming message
    JsonObject incoming = Json.createReader(new StringReader(message)).readObject();
    String type = incoming.getString("type");
    JsonObject payload = incoming.getJsonObject("payload");
    
    if ("chat.message".equals(type)) {
        // Process message
        Message savedMessage = messageService.save(...);
        
        // Send to all participants with WRAPPED format
        JsonObject response = Json.createObjectBuilder()
            .add("type", "chat.message")
            .add("payload", Json.createObjectBuilder()
                .add("id", savedMessage.getId())
                .add("content", savedMessage.getContent())
                .add("type", savedMessage.getType())
                .add("createdAt", savedMessage.getCreatedAt().toString())
                .add("conversationId", savedMessage.getConversationId())
                .add("sender", Json.createObjectBuilder()
                    .add("id", savedMessage.getSender().getId())
                    .add("username", savedMessage.getSender().getUsername())
                    .add("fullName", savedMessage.getSender().getFullName())
                )
            )
            .build();
        
        broadcast(response.toString(), conversationId);
    }
}
```

### **Option 2: Keep Direct Format** (Current Flutter code supports this)

```java
// ChatServerEndpoint.java
@OnMessage
public void onMessage(String message, Session session) {
    // Process message
    Message savedMessage = messageService.save(...);
    
    // Send to all participants with DIRECT format
    JsonObject response = Json.createObjectBuilder()
        .add("id", savedMessage.getId())
        .add("content", savedMessage.getContent())
        .add("type", savedMessage.getType())
        .add("createdAt", savedMessage.getCreatedAt().toString())
        .add("conversationId", savedMessage.getConversationId())
        .add("senderId", savedMessage.getSender().getId())
        .add("senderUsername", savedMessage.getSender().getUsername())
        .add("senderFullName", savedMessage.getSender().getFullName())
        .build();
    
    broadcast(response.toString(), conversationId);
}
```

## 📝 Common Issues

### Issue 1: `type 'Null' is not a subtype of type 'String'`

**Cause**: Server sending message without `type` or `payload` field

**Solution**: ✅ Already fixed - Flutter now handles both formats

### Issue 2: `type 'int' is not a subtype of type 'String'`

**Cause**: Field type mismatch (e.g., `id` is int but Flutter expects String)

**Solution**: Use `MessageModel.fromApi()` which handles type conversion:
```dart
id: (json['id'] ?? json['messageId'] ?? '').toString(),
conversationId: (json['conversationId'] ?? '').toString(),
```

### Issue 3: Missing sender information

**Cause**: Server not sending sender data

**Solution**: Backend must include sender info:
```json
{
  "sender": {
    "id": 10,
    "username": "philong",
    "fullName": "Phi Long"
  }
}
```
Or flat format:
```json
{
  "senderId": 10,
  "senderUsername": "philong",
  "senderFullName": "Phi Long"
}
```

## 🎯 Next Steps

1. **Run the app** and send a message
2. **Check Flutter logs** to see raw WebSocket message format
3. **Share the logs** with me if you still see errors
4. **Update backend** if needed to match expected format

## 📊 Log Examples

### **Success - Wrapped Format**:
```
📥 Raw WebSocket message: {"type":"chat.message","payload":{"id":123,...}}
📦 Parsed data: {type: chat.message, payload: {id: 123, ...}}
📨 Received message: 123
```

### **Success - Direct Format**:
```
📥 Raw WebSocket message: {"id":123,"content":"Hello",...}
📦 Parsed data: {id: 123, content: Hello, ...}
⚠️ Message has no type field, treating as direct message
📨 Received direct message: 123
```

### **Error - Missing Fields**:
```
📥 Raw WebSocket message: {"content":"Hello"}
📦 Parsed data: {content: Hello}
❌ Error handling WebSocket message: type 'Null' is not a subtype of type 'int'
Stack trace: ...
```

## 🚀 Testing Checklist

- [ ] Run app and connect to WebSocket
- [ ] Send a message
- [ ] Check Flutter logs for raw message
- [ ] Verify message appears in UI
- [ ] Check if sender info is correct
- [ ] Test with multiple users
- [ ] Test typing indicators
- [ ] Test user status updates

---

**Created by**: Augment Agent  
**Date**: 2025-10-20  
**Files Modified**: `lib/features/chat/data/services/chat_websocket_service.dart`

