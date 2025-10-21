# 🔄 WebSocket Auto-Reconnect & Heartbeat Fix

## 🐛 Vấn đề

### **Backend Timeout Error**:
```
WebSocket error for user 3: UT000199: Read timed out after 90065 milliseconds.
org.xnio.channels.ReadTimeoutException: UT000199: Read timed out after 90065 milliseconds.
```

### **Root Cause**:
1. ❌ Backend timeout WebSocket connection sau **90 giây** vì không nhận được data từ client
2. ❌ Flutter không gửi **heartbeat** để maintain connection
3. ❌ Flutter không **auto-reconnect** khi WebSocket bị disconnect

### **Impact**:
- User phải refresh app để reconnect WebSocket
- Mất real-time updates sau 90 giây idle
- Không nhận được messages khi connection bị đứt

## ✅ Giải pháp

### **1. Automatic Heartbeat**
- Gửi heartbeat mỗi **30 giây** để maintain connection
- Backend timeout là 90 giây → 30s heartbeat đảm bảo connection alive

### **2. Auto-Reconnect**
- Tự động reconnect khi WebSocket bị disconnect
- Retry sau **5 giây** nếu connection failed
- Không reconnect nếu user manually disconnect (logout)

## 🏗️ Implementation

### **File**: `lib/features/chat/data/services/chat_websocket_service.dart`

#### **1. Added State Variables**

```dart
class ChatWebSocketService {
  WebSocketChannel? _channel;
  Timer? _heartbeatTimer;           // ← NEW: Timer for heartbeat
  Timer? _reconnectTimer;           // ← NEW: Timer for reconnect
  String? _lastAccessToken;         // ← NEW: Store token for reconnect
  bool _isManualDisconnect = false; // ← NEW: Track manual disconnect
  
  // ... existing code
}
```

#### **2. Updated `connect()` Method**

```dart
Future<void> connect(String accessToken) async {
  if (_channel != null) {
    debugPrint('⚠️ WebSocket already connected');
    return;
  }

  try {
    _lastAccessToken = accessToken;      // ← Store token
    _isManualDisconnect = false;         // ← Reset flag
    
    final wsUrl = '${ApiConstants.wsBaseUrl}/${ApiConstants.chatWebSocket}?token=$accessToken';
    debugPrint('🔌 Connecting to WebSocket: $wsUrl');

    _channel = WebSocketChannel.connect(Uri.parse(wsUrl));
    _connectionController.add(true);
    debugPrint('✅ WebSocket connected');

    // Start heartbeat timer ← NEW
    _startHeartbeat();

    _channel!.stream.listen(
      (message) {
        _handleMessage(message);
      },
      onError: (error) {
        debugPrint('❌ WebSocket error: $error');
        _handleDisconnect();  // ← Changed: Handle disconnect
      },
      onDone: () {
        debugPrint('🔌 WebSocket connection closed');
        _handleDisconnect();  // ← Changed: Handle disconnect
      },
    );
  } catch (e) {
    debugPrint('❌ Failed to connect WebSocket: $e');
    _connectionController.add(false);
    _channel = null;
    _scheduleReconnect();  // ← NEW: Schedule reconnect
  }
}
```

#### **3. Added `_handleDisconnect()` Method**

```dart
/// Handle disconnect and attempt reconnect
void _handleDisconnect() {
  _connectionController.add(false);
  _stopHeartbeat();
  _channel = null;

  // Auto-reconnect if not manually disconnected
  if (!_isManualDisconnect && _lastAccessToken != null) {
    _scheduleReconnect();
  }
}
```

**Logic**:
- Stop heartbeat timer
- Clear channel
- Emit connection status = false
- Schedule reconnect **only if** not manual disconnect

#### **4. Added `_scheduleReconnect()` Method**

```dart
/// Schedule reconnect attempt
void _scheduleReconnect() {
  _reconnectTimer?.cancel();
  
  debugPrint('🔄 Scheduling reconnect in 5 seconds...');
  _reconnectTimer = Timer(const Duration(seconds: 5), () {
    if (_lastAccessToken != null && !_isManualDisconnect) {
      debugPrint('🔄 Attempting to reconnect...');
      connect(_lastAccessToken!);
    }
  });
}
```

**Logic**:
- Cancel existing reconnect timer
- Wait **5 seconds**
- Reconnect using stored token
- Only reconnect if token exists and not manual disconnect

#### **5. Added `_startHeartbeat()` Method**

```dart
/// Start heartbeat timer
void _startHeartbeat() {
  _stopHeartbeat();
  
  _heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
    sendHeartbeat();
  });
  
  debugPrint('💓 Heartbeat timer started (30s interval)');
}
```

**Logic**:
- Stop existing heartbeat timer
- Create periodic timer (30 seconds)
- Send heartbeat every 30 seconds

#### **6. Added `_stopHeartbeat()` Method**

```dart
/// Stop heartbeat timer
void _stopHeartbeat() {
  _heartbeatTimer?.cancel();
  _heartbeatTimer = null;
}
```

#### **7. Updated `disconnect()` Method**

```dart
Future<void> disconnect() async {
  _isManualDisconnect = true;  // ← NEW: Mark as manual
  _stopHeartbeat();            // ← NEW: Stop heartbeat
  _reconnectTimer?.cancel();   // ← NEW: Cancel reconnect
  _lastAccessToken = null;     // ← NEW: Clear token
  
  if (_channel != null) {
    await _channel!.sink.close();
    _channel = null;
    _connectionController.add(false);
    debugPrint('🔌 WebSocket disconnected');
  }
}
```

**Logic**:
- Set `_isManualDisconnect = true` to prevent auto-reconnect
- Stop heartbeat timer
- Cancel reconnect timer
- Clear stored token
- Close WebSocket channel

#### **8. Updated `dispose()` Method**

```dart
void dispose() {
  _stopHeartbeat();          // ← NEW: Stop heartbeat
  _reconnectTimer?.cancel(); // ← NEW: Cancel reconnect
  disconnect();
  _messageController.close();
  _typingController.close();
  _userStatusController.close();
  _conversationUpdateController.close();
  _connectionController.close();
}
```

## 📊 Flow Diagrams

### **Heartbeat Flow**:

```
WebSocket connected
    ↓
Start heartbeat timer (30s interval)
    ↓
Every 30 seconds:
    ↓
Send heartbeat to server
    ↓
Server receives heartbeat
    ↓
Server resets timeout counter
    ↓
Server sends heartbeat.ack
    ↓
Flutter logs acknowledgment
    ↓
Connection stays alive ✅
```

### **Auto-Reconnect Flow**:

```
WebSocket disconnected (error/timeout)
    ↓
_handleDisconnect() called
    ↓
Stop heartbeat timer
    ↓
Check: Is manual disconnect?
    ↓
NO → Schedule reconnect in 5s
    ↓
Wait 5 seconds
    ↓
Attempt reconnect with stored token
    ↓
Success? → Start heartbeat again ✅
    ↓
Failed? → Schedule reconnect again 🔄
```

### **Manual Disconnect Flow**:

```
User logs out
    ↓
disconnect() called
    ↓
Set _isManualDisconnect = true
    ↓
Stop heartbeat timer
    ↓
Cancel reconnect timer
    ↓
Clear stored token
    ↓
Close WebSocket
    ↓
NO auto-reconnect ✅
```

## 🎯 Testing

### **Test Case 1: Heartbeat Prevents Timeout**

**Steps**:
1. Login to app
2. WebSocket connects
3. Wait 2 minutes (idle, no messages)
4. Send a message

**Expected**:
```
✅ WebSocket connected
💓 Heartbeat timer started (30s interval)
💓 Sent heartbeat
💓 Heartbeat acknowledged
💓 Sent heartbeat
💓 Heartbeat acknowledged
📤 Sent message to conversation: 6
```

**Result**: ✅ Connection stays alive, no timeout

### **Test Case 2: Auto-Reconnect on Network Error**

**Steps**:
1. Login to app
2. WebSocket connects
3. Turn off WiFi for 10 seconds
4. Turn on WiFi

**Expected**:
```
✅ WebSocket connected
❌ WebSocket error: ...
🔌 WebSocket connection closed
🔄 Scheduling reconnect in 5 seconds...
🔄 Attempting to reconnect...
🔌 Connecting to WebSocket: ...
✅ WebSocket connected
💓 Heartbeat timer started (30s interval)
```

**Result**: ✅ Auto-reconnects after 5 seconds

### **Test Case 3: Auto-Reconnect on Backend Restart**

**Steps**:
1. Login to app
2. WebSocket connects
3. Restart backend server
4. Wait 10 seconds

**Expected**:
```
✅ WebSocket connected
🔌 WebSocket connection closed
🔄 Scheduling reconnect in 5 seconds...
🔄 Attempting to reconnect...
❌ Failed to connect WebSocket: ...
🔄 Scheduling reconnect in 5 seconds...
🔄 Attempting to reconnect...
✅ WebSocket connected
```

**Result**: ✅ Keeps retrying until backend is back

### **Test Case 4: No Reconnect on Logout**

**Steps**:
1. Login to app
2. WebSocket connects
3. Logout

**Expected**:
```
✅ WebSocket connected
🔌 WebSocket disconnected
✅ All app state cleared
```

**NO reconnect attempts** ✅

**Result**: ✅ No auto-reconnect after manual disconnect

## 📝 Logs to Monitor

### **Normal Operation**:
```
🔌 Connecting to WebSocket: ws://172.19.240.1:8080/chattrix-api/ws/chat?token=...
✅ WebSocket connected
💓 Heartbeat timer started (30s interval)
💓 Sent heartbeat
💓 Heartbeat acknowledged
💓 Sent heartbeat
💓 Heartbeat acknowledged
```

### **Connection Lost**:
```
❌ WebSocket error: WebSocketChannelException: ...
🔌 WebSocket connection closed
🔄 Scheduling reconnect in 5 seconds...
🔄 Attempting to reconnect...
🔌 Connecting to WebSocket: ...
✅ WebSocket connected
💓 Heartbeat timer started (30s interval)
```

### **Manual Disconnect**:
```
🔌 WebSocket disconnected
✅ All app state cleared
```

## ⚙️ Configuration

### **Heartbeat Interval**: 30 seconds
```dart
_heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
  sendHeartbeat();
});
```

**Why 30s?**
- Backend timeout: 90 seconds
- 30s × 3 = 90s → Safe margin
- Not too frequent (saves bandwidth)
- Not too slow (prevents timeout)

### **Reconnect Delay**: 5 seconds
```dart
_reconnectTimer = Timer(const Duration(seconds: 5), () {
  connect(_lastAccessToken!);
});
```

**Why 5s?**
- Not too fast (avoid spamming server)
- Not too slow (quick recovery)
- Good balance for user experience

## 🔧 Customization

### **Change Heartbeat Interval**:
```dart
// Change from 30s to 20s
_heartbeatTimer = Timer.periodic(const Duration(seconds: 20), (timer) {
  sendHeartbeat();
});
```

### **Change Reconnect Delay**:
```dart
// Change from 5s to 3s
_reconnectTimer = Timer(const Duration(seconds: 3), () {
  connect(_lastAccessToken!);
});
```

### **Add Max Reconnect Attempts**:
```dart
int _reconnectAttempts = 0;
static const int maxReconnectAttempts = 10;

void _scheduleReconnect() {
  if (_reconnectAttempts >= maxReconnectAttempts) {
    debugPrint('❌ Max reconnect attempts reached');
    return;
  }
  
  _reconnectAttempts++;
  _reconnectTimer?.cancel();
  
  debugPrint('🔄 Reconnect attempt $_reconnectAttempts/$maxReconnectAttempts');
  _reconnectTimer = Timer(const Duration(seconds: 5), () {
    if (_lastAccessToken != null && !_isManualDisconnect) {
      connect(_lastAccessToken!);
    }
  });
}

// Reset on successful connect
Future<void> connect(String accessToken) async {
  // ... existing code
  _reconnectAttempts = 0;  // ← Reset counter
  // ... existing code
}
```

## ✅ Benefits

1. **No More Timeouts**: Heartbeat keeps connection alive
2. **Automatic Recovery**: Auto-reconnect on network issues
3. **Better UX**: Users don't need to refresh app
4. **Real-time Updates**: Always receive messages
5. **Smart Disconnect**: No reconnect on logout

## 📚 Related Files

- `lib/features/chat/data/services/chat_websocket_service.dart` - WebSocket service
- `lib/features/auth/presentation/providers/auth_providers.dart` - Logout handling
- `lib/features/chat/providers/chat_providers.dart` - WebSocket connection provider

---

**Implemented by**: Augment Agent  
**Date**: 2025-10-20  
**Issue**: Backend WebSocket timeout after 90 seconds  
**Solution**: Auto-heartbeat (30s) + Auto-reconnect (5s delay)

