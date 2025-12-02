# Video Call Feature - Setup Guide

## ✅ Đã hoàn thành

Feature call video/audio đã được tạo xong với các components:

### 📁 Cấu trúc
```
lib/features/video_call/
├── models/call_models.dart          # Models đơn giản (không dùng freezed)
├── services/
│   ├── call_api_service.dart        # API service
│   └── agora_service.dart           # Agora RTC service
├── providers/call_provider.dart     # State management với ChangeNotifier
├── screens/call_screen.dart         # UI màn hình call
├── example/call_example.dart        # Ví dụ sử dụng
├── README.md                        # Documentation chi tiết
└── video_call.dart                  # Export file

lib/core/utils/app_logger.dart       # Logger utility (dùng thay print)
```

## 🔧 Cần setup

### 1. Thêm AGORA_APP_ID vào file .env

```env
AGORA_APP_ID=your_agora_app_id_here
```

### 2. Setup Dio Provider

Tìm file provider của Dio trong project (thường trong `lib/core/network/` hoặc `lib/core/providers/`) và update:

```dart
// Trong call_provider.dart, dòng 18-21
final callApiServiceProvider = Provider<CallApiService>((ref) {
  final dio = ref.watch(yourDioProvider); // Thay yourDioProvider bằng provider thực tế
  return CallApiService(dio);
});
```

### 3. Import vào main.dart hoặc router

Không cần import vào main.dart, chỉ cần import khi sử dụng:

```dart
import 'package:chattrix_ui/features/video_call/video_call.dart';
```

## 📝 Cách sử dụng

### Initiate Call (Bắt đầu gọi)

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => CallScreen(
      calleeId: userId,
      callType: CallType.video, // hoặc CallType.audio
    ),
  ),
);
```

### Handle Incoming Call (Nhận cuộc gọi)

```dart
// Khi nhận WebSocket event 'call.incoming'
void handleIncomingCall(Map<String, dynamic> payload) {
  final invitation = CallInvitation.fromJson(payload);
  
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => CallScreen(
        invitation: invitation,
        callType: invitation.callType,
      ),
    ),
  );
}
```

## 🔗 WebSocket Events cần handle

Trong WebSocket handler của bạn, cần listen các events sau:

```dart
void handleWebSocketMessage(Map<String, dynamic> message) {
  final type = message['type'] as String;
  final payload = message['payload'] as Map<String, dynamic>;
  
  switch (type) {
    case 'call.incoming':      // Có cuộc gọi đến
      final invitation = CallInvitation.fromJson(payload);
      showIncomingCallScreen(invitation);
      break;
      
    case 'call.accepted':      // Cuộc gọi được chấp nhận
      // CallController tự động handle
      break;
      
    case 'call.rejected':      // Cuộc gọi bị từ chối
    case 'call.ended':         // Cuộc gọi kết thúc
    case 'call.timeout':       // Cuộc gọi timeout
      // Close call screen, show notification
      break;
  }
}
```

## 🎨 Features

- ✅ Video call / Audio call
- ✅ Mute/Unmute microphone
- ✅ Camera on/off
- ✅ Switch camera (front/back)
- ✅ Speaker on/off
- ✅ Beautiful UI with overlay controls
- ✅ Incoming call screen với Accept/Reject
- ✅ Auto request permissions
- ✅ Logger thay vì print
- ✅ Error handling

## 📚 API Endpoints (từ api-spec.yaml)

- `POST /v1/calls/initiate` - Bắt đầu cuộc gọi
- `POST /v1/calls/{callId}/accept` - Chấp nhận cuộc gọi
- `POST /v1/calls/{callId}/reject` - Từ chối cuộc gọi  
- `POST /v1/calls/{callId}/end` - Kết thúc cuộc gọi

## 🔍 Testing

1. Đảm bảo backend đã implement các API endpoints trên
2. Đảm bảo có AGORA_APP_ID hợp lệ trong .env
3. Test trên thiết bị thật (không test trên emulator vì cần camera/mic)
4. Cần 2 devices để test full flow

## ⚠️ Notes

- Code đơn giản, không dùng kiến trúc phức tạp
- Không dùng freezed để tránh phức tạp
- Dùng lại các thư viện đã có trong pubspec.yaml:
  - agora_rtc_engine: ^6.3.2
  - permission_handler: ^12.0.1
  - logger: ^2.6.2
  - hooks_riverpod: ^3.0.3
- Compatible với Flutter SDK ^3.9.2

## 🐛 Known Issues

Nếu gặp lỗi IDE về undefined getters, chạy lệnh:
```bash
flutter clean
flutter pub get
```

IDE sẽ tự refresh và lỗi sẽ biến mất.

## 📖 Documentation

Xem thêm chi tiết trong:
- `lib/features/video_call/README.md` - Full documentation
- `lib/features/video_call/example/call_example.dart` - Code examples

