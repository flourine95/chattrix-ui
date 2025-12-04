# Error Handling Improvements - Call Feature

## 📋 Tóm tắt

Đã cải thiện xử lý và hiển thị lỗi trong call feature để người dùng nhận được thông báo rõ ràng khi có lỗi xảy ra.

---

## ✅ Các cải tiến đã thực hiện

### 1. **Toast Notifications cho tất cả lỗi**

Trước đây lỗi chỉ được log và set state, giờ đã thêm toast notification:

#### a) **Lỗi khởi tạo cuộc gọi (initiateCall)**
```dart
// ❌ BEFORE: Chỉ set state
state = CallState.error(message: failure.message);

// ✅ AFTER: Hiển thị toast + set state
ref.read(toastControllerProvider).show(
  title: failure.userMessage,  // Sử dụng userMessage từ Failure extension
  type: ToastType.error,
);
state = CallState.error(message: failure.userMessage);
```

#### b) **Lỗi chấp nhận cuộc gọi (acceptCall)**
```dart
ref.read(toastControllerProvider).show(
  title: failure.userMessage,
  type: ToastType.error,
);
```

#### c) **Lỗi Agora (join channel)**
```dart
// Lỗi khi join Agora channel trong initiateCall hoặc acceptCall
ref.read(toastControllerProvider).show(
  title: 'Failed to join call. Please check your connection and try again.',
  type: ToastType.error,
);
```

#### d) **Lỗi generic (catch blocks)**
```dart
// initiateCall catch
ref.read(toastControllerProvider).show(
  title: 'Failed to start call. Please try again.',
  type: ToastType.error,
);

// acceptCall catch
ref.read(toastControllerProvider).show(
  title: 'Failed to accept call. Please try again.',
  type: ToastType.error,
);
```

---

### 2. **Sử dụng `failure.userMessage` Extension**

Tận dụng extension đã được định nghĩa trong `failures.dart`:

```dart
extension FailureMessage on Failure {
  String get userMessage {
    return when(
      // Các message thân thiện với người dùng
      server: (message, errorCode) => 'Server error. Please try again later.',
      network: (message) => 'Network error. Please check your internet connection.',
      agoraEngine: (message, code) => 'Failed to join call. Please check your connection and try again.',
      // ...
    );
  }
}
```

Giờ mọi lỗi đều hiển thị message thân thiện thay vì technical error messages.

---

### 3. **Cleanup khi Agora fail**

Khi join Agora channel thất bại, tự động cleanup call trên backend:

```dart
try {
  // Initialize and join Agora
  await agoraService.initialize();
  await agoraService.joinChannel(...);
  
  state = CallState.connecting(...);
} catch (agoraError) {
  // Show error to user
  ref.read(toastControllerProvider).show(
    title: 'Failed to join call...',
    type: ToastType.error,
  );
  
  // ✅ Cleanup call on backend
  try {
    await ref.read(endCallUseCaseProvider).call(
      callId: connection.callInfo.id,
      reason: CallEndReason.networkError,
    );
  } catch (_) {
    // Ignore cleanup errors
  }
}
```

---

## 📁 Files đã thay đổi

### 1. `lib/features/call/presentation/state/call_notifier.dart`

**Thêm imports:**
```dart
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/toast/toast_controller.dart';
import 'package:chattrix_ui/core/toast/toast_type.dart';
```

**Cập nhật error handling trong:**
- ✅ `initiateCall()` - API error + Agora error + generic error
- ✅ `acceptCall()` - API error + Agora error + generic error

### 2. `lib/features/call/domain/entities/call_end_reason.dart`

Không thay đổi (giữ nguyên các enum values hiện tại)

---

## 🎯 Error Flow mới

```
User Action (initiate/accept call)
    ↓
API Call (via UseCase)
    ↓
    ├─ ✅ Success
    │   ↓
    │   Initialize Agora
    │   ↓
    │   ├─ ✅ Success → CallState.connecting
    │   │
    │   └─ ❌ Agora Error
    │       ↓
    │       1. Show toast to user
    │       2. Set CallState.error
    │       3. Cleanup call on backend
    │
    └─ ❌ API Error (Failure)
        ↓
        1. Show failure.userMessage in toast
        2. Set CallState.error
```

---

## 🧪 Testing Scenarios

Kiểm tra các trường hợp sau:

### ✅ Initiate Call Errors
- [ ] Server error → Toast: "Server error. Please try again later."
- [ ] Network error → Toast: "Network error. Please check your internet connection."
- [ ] User not found → Toast: "Resource not found. Please try again."
- [ ] Agora init/join fails → Toast: "Failed to join call. Please check your connection..."

### ✅ Accept Call Errors
- [ ] Server error → Toast hiển thị
- [ ] Network error → Toast hiển thị
- [ ] Call already ended → Toast hiển thị
- [ ] Agora init/join fails → Toast hiển thị + cleanup backend

### ✅ UI Display
- [ ] Toast xuất hiện ở bottom-right
- [ ] Toast có màu đỏ (error type)
- [ ] Toast tự động ẩn sau 3.4s
- [ ] State chuyển về idle hoặc error state
- [ ] Router redirect về home page khi error

---

## 💡 Best Practices được áp dụng

1. ✅ **User-friendly messages**: Sử dụng `failure.userMessage` thay vì technical errors
2. ✅ **Consistent error handling**: Tất cả errors đều hiển thị toast
3. ✅ **Cleanup on failure**: Backend call được cleanup khi Agora fails
4. ✅ **Proper error types**: Sử dụng `ToastType.error` cho tất cả errors
5. ✅ **Logging**: Vẫn giữ `appLogger.e()` cho debugging
6. ✅ **State management**: CallState.error được set đúng cách

---

## 📊 Error Messages Mapping

| Failure Type | User Message |
|-------------|-------------|
| `ServerFailure` | "Server error. Please try again later." |
| `NetworkFailure` | "Network error. Please check your internet connection." |
| `NotFoundFailure` | "Resource not found. Please try again." |
| `AgoraEngineFailure` | "Failed to join call. Please check your connection and try again." |
| `WebSocketNotConnectedFailure` | "Connection lost. Please check your internet connection." |
| Generic catch | "Failed to start/accept call. Please try again." |

---

## 🔍 Related Files

- `lib/core/errors/failures.dart` - Failure types & userMessage extension
- `lib/core/toast/toast_controller.dart` - Toast API
- `lib/features/call/presentation/state/call_notifier.dart` - Main error handling logic
- `lib/features/call/presentation/pages/incoming_call_page.dart` - Displays error state
- `lib/features/call/presentation/pages/outgoing_call_page.dart` - Displays error state
- `lib/features/call/presentation/pages/call_page.dart` - Displays error state

---

**Status:** ✅ Complete & Ready for Testing  
**Date:** December 3, 2025

