# Video Call Feature

Feature call video/audio đơn giản sử dụng Agora RTC Engine.

## Cấu trúc

```
video_call/
├── models/
│   └── call_models.dart        # Models cho call (CallInfo, CallConnection, etc.)
├── services/
│   ├── call_api_service.dart   # API service để gọi backend
│   └── agora_service.dart      # Agora RTC service
├── providers/
│   └── call_provider.dart      # Provider quản lý state
└── screens/
    └── call_screen.dart        # UI cho call
```

## Setup

### 1. Thêm AGORA_APP_ID vào .env

```.env
AGORA_APP_ID=your_agora_app_id_here
```

### 2. Setup Provider với Dio instance

Trong `call_provider.dart`, cần inject Dio instance:

```dart
final callApiServiceProvider = Provider<CallApiService>((ref) {
  final dio = ref.watch(dioProvider); // Your Dio provider
  return CallApiService(dio);
});
```

## Sử dụng

### Initiate Call (Gọi điện)

```dart
// Navigate to call screen với calleeId
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => CallScreen(
      calleeId: 123,
      callType: CallType.video, // hoặc CallType.audio
    ),
  ),
);

// Hoặc sử dụng controller trực tiếp
ref.read(callControllerProvider.notifier).initiateCall(
  calleeId: 123,
  callType: CallType.video,
);
```

### Accept Incoming Call (Nhận cuộc gọi)

```dart
// Khi nhận event từ WebSocket
void onCallIncoming(Map<String, dynamic> data) {
  final invitation = CallInvitation.fromJson(data);
  
  // Show call screen
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

### WebSocket Integration

Integrate với WebSocket để nhận các events:

```dart
// In your WebSocket handler
void handleWebSocketMessage(Map<String, dynamic> message) {
  final type = message['type'] as String;
  final payload = message['payload'] as Map<String, dynamic>;
  
  switch (type) {
    case 'call.incoming':
      final invitation = CallInvitation.fromJson(payload);
      _handleIncomingCall(invitation);
      break;
      
    case 'call.accepted':
      final accept = CallAccept.fromJson(payload);
      ref.read(callControllerProvider.notifier).handleCallAccepted();
      break;
      
    case 'call.rejected':
      final reject = CallReject.fromJson(payload);
      ref.read(callControllerProvider.notifier).handleCallEnded();
      break;
      
    case 'call.ended':
      final end = CallEnd.fromJson(payload);
      ref.read(callControllerProvider.notifier).handleCallEnded();
      break;
      
    case 'call.timeout':
      final timeout = CallTimeout.fromJson(payload);
      ref.read(callControllerProvider.notifier).handleCallEnded();
      break;
  }
}
```

## API Endpoints

Dựa trên `api-spec.yaml`:

- `POST /v1/calls/initiate` - Bắt đầu cuộc gọi
- `POST /v1/calls/{callId}/accept` - Chấp nhận cuộc gọi
- `POST /v1/calls/{callId}/reject` - Từ chối cuộc gọi
- `POST /v1/calls/{callId}/end` - Kết thúc cuộc gọi

## Call Flow

### Người gọi (Caller):
1. User nhấn nút gọi
2. App gọi `initiateCall(calleeId, callType)`
3. API trả về `CallConnection` với token
4. Join Agora channel với token
5. Chờ người nhận accept (nhận event qua WebSocket)
6. Khi accepted, bắt đầu call

### Người nhận (Callee):
1. Nhận event `call.incoming` từ WebSocket
2. Hiển thị CallScreen với invitation
3. User nhấn Accept hoặc Decline
4. Nếu Accept: gọi API accept, nhận token, join channel
5. Bắt đầu call

## Controls

Trong call screen có các nút điều khiển:

- **Mute/Unmute**: Tắt/bật microphone
- **Camera On/Off**: Bật/tắt camera (video call)
- **Switch Camera**: Chuyển camera trước/sau (video call)
- **Speaker On/Off**: Bật/tắt loa
- **End Call**: Kết thúc cuộc gọi

## Permissions

Feature tự động request permissions:
- **Microphone**: Cho tất cả các loại call
- **Camera**: Chỉ cho video call

## Logger

Feature sử dụng `appLogger` từ `core/utils/app_logger.dart` để log thay vì print:

```dart
appLogger.i('Info message');
appLogger.d('Debug message');
appLogger.w('Warning message');
appLogger.e('Error message', error: error, stackTrace: stackTrace);
```

## Notes

- Code đơn giản, không dùng freezed để tránh phức tạp
- Dùng lại các thư viện đã có trong pubspec
- Compatible với Agora RTC Engine 6.3.2
- State management với Riverpod (ChangeNotifier)

