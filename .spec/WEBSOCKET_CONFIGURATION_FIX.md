# 🔧 WebSocket Configuration Fix

## 🐛 Vấn đề

WebSocket connection bị lỗi với thông báo:
```
RESTEASY003210: Could not find resource for full path: 
http://172.19.240.1:8080/chattrix-api/api/v1/chat?token=...
```

### Nguyên nhân:
- **Backend WebSocket endpoint**: `/ws/chat` (Jakarta WebSocket `@ServerEndpoint`)
- **Flutter đang kết nối đến**: `/api/v1/chat` (REST API endpoint - không tồn tại)
- **Sự không khớp**: Flutter đang cố gắng kết nối đến một REST endpoint thay vì WebSocket endpoint

## ✅ Giải pháp

### 1. **Backend Configuration** (Jakarta EE WebSocket)

```java
@ApplicationScoped
@ServerEndpoint(
    value = "/ws/chat",
    configurator = CdiAwareConfigurator.class,
    encoders = MessageEncoder.class,
    decoders = MessageDecoder.class
)
public class ChatServerEndpoint {
    // WebSocket implementation
}
```

**WebSocket URL**: `ws://host:port/chattrix-api/ws/chat`

### 2. **Flutter Configuration** (FIXED)

#### **Before (Incorrect)**:
```dart
// lib/core/constants/api_constants.dart
static String get wsBaseUrl {
  final httpUrl = baseUrl;  // http://172.19.240.1:8080/chattrix-api/api
  final wsUrl = httpUrl.replaceFirst('http://', 'ws://');
  return wsUrl;  // ws://172.19.240.1:8080/chattrix-api/api ❌
}

static const String chatWebSocket = 'v1/chat';  // ❌
```

**Kết quả**: `ws://172.19.240.1:8080/chattrix-api/api/v1/chat` ❌

#### **After (Correct)**:
```dart
// lib/core/constants/api_constants.dart
static String get wsBaseUrl {
  // WebSocket base URL: ws://host:port/chattrix-api
  if (kIsWeb) {
    return 'ws://$localhostHost:$port/chattrix-api';
  } else {
    return 'ws://$lanIpAddress:$port/chattrix-api';
  }
}

static const String chatWebSocket = 'ws/chat';  // ✅
```

**Kết quả**: `ws://172.19.240.1:8080/chattrix-api/ws/chat` ✅

### 3. **WebSocket Service Usage**

```dart
// lib/features/chat/data/services/chat_websocket_service.dart
Future<void> connect(String accessToken) async {
  final wsUrl = '${ApiConstants.wsBaseUrl}/${ApiConstants.chatWebSocket}?token=$accessToken';
  // wsUrl = ws://172.19.240.1:8080/chattrix-api/ws/chat?token=...
  
  _channel = WebSocketChannel.connect(Uri.parse(wsUrl));
  // ...
}
```

## 📊 URL Comparison

| Component | Before (❌) | After (✅) |
|-----------|------------|-----------|
| **Protocol** | `ws://` | `ws://` |
| **Host** | `172.19.240.1:8080` | `172.19.240.1:8080` |
| **Base Path** | `/chattrix-api/api` | `/chattrix-api` |
| **Endpoint** | `v1/chat` | `ws/chat` |
| **Full URL** | `ws://172.19.240.1:8080/chattrix-api/api/v1/chat` | `ws://172.19.240.1:8080/chattrix-api/ws/chat` |
| **Match Backend?** | ❌ No | ✅ Yes |

## 🔍 Debugging Tips

### 1. **Check WebSocket URL in Flutter Logs**
```
🔌 Connecting to WebSocket: ws://172.19.240.1:8080/chattrix-api/ws/chat?token=...
```

### 2. **Check Backend Logs**
- **Success**: WebSocket connection established
- **Error**: `Could not find resource for full path: http://...` → URL mismatch

### 3. **Test WebSocket Endpoint**
```bash
# Using wscat (npm install -g wscat)
wscat -c "ws://172.19.240.1:8080/chattrix-api/ws/chat?token=YOUR_TOKEN"
```

### 4. **Common Mistakes**

#### ❌ **Mistake 1**: Including `/api` in WebSocket base URL
```dart
// WRONG
static String get wsBaseUrl {
  return 'ws://$lanIpAddress:$port/chattrix-api/api';  // ❌ /api should not be here
}
```

#### ❌ **Mistake 2**: Using REST API path for WebSocket
```dart
// WRONG
static const String chatWebSocket = 'v1/chat';  // ❌ This is REST API path
```

#### ✅ **Correct**: Separate paths for REST and WebSocket
```dart
// REST API base: http://host:port/chattrix-api/api
static const String apiPrefix = '/chattrix-api/api';

// WebSocket base: ws://host:port/chattrix-api
static String get wsBaseUrl {
  return 'ws://$lanIpAddress:$port/chattrix-api';  // ✅ No /api
}

// WebSocket endpoint: ws/chat
static const String chatWebSocket = 'ws/chat';  // ✅ Matches backend
```

## 🎯 Key Differences: REST vs WebSocket

| Aspect | REST API | WebSocket |
|--------|----------|-----------|
| **Protocol** | `http://` or `https://` | `ws://` or `wss://` |
| **Base Path** | `/chattrix-api/api` | `/chattrix-api` |
| **Endpoint Pattern** | `/v1/resource` | `/ws/endpoint` |
| **Example** | `http://host/chattrix-api/api/v1/conversations` | `ws://host/chattrix-api/ws/chat` |
| **Authentication** | `Authorization: Bearer token` | Query param `?token=...` |
| **Communication** | Request-Response | Bidirectional |

## 🚀 Testing

### 1. **Run the app**
```bash
flutter run
```

### 2. **Check logs for WebSocket connection**
```
🔌 Connecting to WebSocket: ws://172.19.240.1:8080/chattrix-api/ws/chat?token=...
✅ WebSocket connected
```

### 3. **Test sending a message**
```
📤 Sent message to conversation: 123
📨 Received message: 456
```

### 4. **Check backend logs**
- Should see WebSocket connection established
- Should NOT see "Could not find resource" error

## 📝 Summary

**Problem**: Flutter was trying to connect to REST API endpoint instead of WebSocket endpoint

**Root Cause**: 
- WebSocket base URL included `/api` path
- WebSocket endpoint used REST API pattern (`v1/chat` instead of `ws/chat`)

**Solution**:
- Remove `/api` from WebSocket base URL
- Change endpoint from `v1/chat` to `ws/chat` to match backend

**Result**: WebSocket connection now works correctly! ✅

---

**Fixed by**: Augment Agent  
**Date**: 2025-10-20  
**Files Modified**: `lib/core/constants/api_constants.dart`

