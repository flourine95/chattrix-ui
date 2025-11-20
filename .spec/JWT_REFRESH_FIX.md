# 🔧 JWT Refresh Token - Fix Infinite Loop

## 🔴 Vấn đề đã phát hiện

### Triệu chứng:
- Access token set 1 phút
- Sau khi token hết hạn, app **fetch liên tục** (infinite loop)
- Backend logs hiển thị nhiều "Invalid or expired token" warnings
- Sau vài phút, app dừng fetch nhưng **không logout user**
- **KHÔNG CÓ logs `🔴 [JWT] 401 Unauthorized`** → onError không được gọi!

### Nguyên nhân:

#### ⚠️ VẤN ĐỀ CHÍNH: `validateStatus` sai cấu hình

**File:** `lib/core/network/dio_client.dart`

```dart
validateStatus: (status) => status != null && status < 500
```

→ **401 KHÔNG được coi là error** → `onError` interceptor KHÔNG được trigger!

#### Các vấn đề khác:

**1. Infinite Loop khi Refresh Token thất bại hoặc retry fails**

1. Request gửi đi với access token cũ
2. Token hết hạn → Backend trả 401
3. AuthInterceptor bắt 401 → gọi refresh token
4. Nếu refresh thành công → retry request gốc
5. **VẤN ĐỀ:** Nếu retry request lại trả 401 (token mới cũng hết hạn) → trigger interceptor lại → **Infinite loop**

**2. Không có lock mechanism**
- Nhiều requests cùng lúc có thể trigger multiple refresh calls
- Gây race condition và duplicate refresh attempts

**3. Retry không có error handling**
- Khi retry request fails, không clear tokens
- Không logout user khi cần thiết

**4. Không có parse error handling**
- Nếu response format sai, app crash hoặc loop

## ✅ Giải pháp đã implement

### 0. **FIX CHÍNH: Sửa `validateStatus` để 401 trigger onError**

**File:** `lib/core/network/dio_client.dart`

```dart
// BEFORE (SAI):
validateStatus: (status) => status != null && status < 500

// AFTER (ĐÚNG):
validateStatus: (status) => status != null && status >= 200 && status < 300
```

**Lợi ích:**
- 401 bây giờ được coi là error
- `onError` interceptor được trigger
- Refresh token flow hoạt động đúng

**File:** `lib/core/network/auth_interceptor.dart`

```dart
// _refreshDio cũng cần update:
validateStatus: (status) => true  // Allow all status to handle manually
```

### 1. Thêm Lock Mechanism (`_isRefreshing` flag)

```dart
bool _isRefreshing = false;

// Trong onError:
if (_isRefreshing) {
  // Wait và retry với token mới nếu có
  await Future.delayed(const Duration(milliseconds: 500));
  final currentToken = await tokenCacheService.getAccessToken();
  if (currentToken != null && currentToken != oldToken) {
    // Retry với token mới
  }
  return handler.next(err);
}
```

**Lợi ích:**
- Chỉ 1 refresh call tại một thời điểm
- Các requests khác đợi và reuse token mới
- Tránh race condition

### 2. Thêm Error Handling cho Retry

```dart
try {
  final response = await dio.fetch(err.requestOptions);
  return handler.resolve(response);
} catch (retryError) {
  // Nếu retry fails → clear tokens và logout
  await _clearTokens();
  return handler.next(err);
}
```

**Lợi ích:**
- Nếu retry fails → clear tokens ngay
- User được logout đúng cách
- Không còn infinite loop

### 3. Thêm Parse Error Handling

```dart
try {
  final data = response.data['data'];
  final newAccessToken = data['accessToken'] as String;
  final newRefreshToken = data['refreshToken'] as String;
  // ...
} catch (parseError) {
  print('❌ [JWT] Failed to parse refresh response: $parseError');
  await _clearTokens();
  return null;
}
```

**Lợi ích:**
- Nếu response format sai → clear tokens
- Không crash app
- Log chi tiết để debug

### 4. Thêm Finally Block

```dart
try {
  _isRefreshing = true;
  // ... refresh logic
} finally {
  _isRefreshing = false;
}
```

**Lợi ích:**
- Đảm bảo flag được reset dù có lỗi hay không
- Tránh deadlock

## 🧪 Cách test

### Bước 1: Set access token 1 phút
```bash
# File: chattrix-api/.env
JWT_ACCESS_EXPIRATION_MINUTES=1

# Restart backend
cd chattrix-api
docker-compose restart
```

### Bước 2: Chạy app và login
```bash
cd chattrix-ui
flutter run
```

### Bước 3: Đợi 2 phút và thử gọi API

**Kết quả mong đợi:**

#### ✅ Nếu refresh token còn hạn:
```
🔴 [JWT] 401 Unauthorized: GET /v1/users/me
🔄 [JWT] Attempting token refresh...
🔄 [JWT] Calling refresh API...
✅ [JWT] New tokens received
✅ [JWT] Token refreshed, retrying request...
✅ [JWT] Retry successful: 200
```
→ **User KHÔNG bị logout, app hoạt động bình thường**

#### ❌ Nếu refresh token hết hạn:
```
🔴 [JWT] 401 Unauthorized: GET /v1/users/me
🔄 [JWT] Attempting token refresh...
🔄 [JWT] Calling refresh API...
❌ [JWT] Refresh failed with status: 401
🗑️  [JWT] Clearing tokens from cache and storage
❌ [JWT] Token refresh failed, user will be logged out
```
→ **User BỊ logout (đúng!)**

#### ✅ Nếu nhiều requests cùng lúc:
```
🔴 [JWT] 401 Unauthorized: GET /v1/conversations
🔄 [JWT] Attempting token refresh...
🔴 [JWT] 401 Unauthorized: GET /v1/users/me
⏳ [JWT] Refresh already in progress, waiting...
✅ [JWT] New tokens received
✅ [JWT] Token refreshed, retrying request...
✅ [JWT] Retry successful: 200
✅ [JWT] Retry successful: 200
```
→ **Chỉ 1 refresh call, các requests khác đợi và reuse token**

## 📊 So sánh Before/After

| Tình huống | Before | After |
|------------|--------|-------|
| **401 Response** | Không trigger onError | Trigger onError đúng |
| **Token hết hạn** | Infinite loop fetch | Refresh 1 lần, retry thành công |
| **Refresh fails** | Loop mãi, không logout | Clear tokens, logout ngay |
| **Multiple requests** | Multiple refresh calls | 1 refresh call, others wait |
| **Parse error** | Crash hoặc loop | Clear tokens, logout |
| **Retry fails** | Loop lại | Clear tokens, logout |

## 🎯 Kết luận

### Vấn đề đã fix:
✅ **validateStatus sai cấu hình** (FIX CHÍNH)  
✅ Infinite loop khi refresh token  
✅ Race condition với multiple requests  
✅ Không logout khi cần thiết  
✅ Parse error handling  
✅ Retry error handling  

### Code changes:

#### File 1: `chattrix-ui/lib/core/network/dio_client.dart` ⭐ **FIX CHÍNH**
- **Sửa:** `validateStatus` từ `< 500` → `>= 200 && < 300`
- **Lý do:** Cho phép 401 trigger onError interceptor

#### File 2: `chattrix-ui/lib/core/network/auth_interceptor.dart`
- **Thêm:** `_isRefreshing` flag
- **Thêm:** Lock mechanism để tránh multiple refresh
- **Thêm:** Error handling cho retry
- **Thêm:** Parse error handling
- **Thêm:** Finally block để reset flag
- **Sửa:** `_refreshDio` validateStatus → `true` (allow all)

### Next steps:
1. Test với access token 1 phút
2. Verify không còn infinite loop
3. Verify user được logout đúng khi refresh token hết hạn
4. Test với multiple requests cùng lúc

---

**Ngày fix:** 2024
**File changed:** `lib/core/network/auth_interceptor.dart`
