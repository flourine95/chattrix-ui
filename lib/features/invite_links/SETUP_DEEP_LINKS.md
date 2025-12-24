# Setup Deep Links với uni_links (Ngrok)

Hướng dẫn đơn giản để setup deep links cho development với ngrok.

## 📦 Package đã chọn: `uni_links`

**Lý do chọn:**
- ✅ Đơn giản, dễ setup
- ✅ Hoạt động tốt với custom scheme (`chattrix://`)
- ✅ Không cần domain thật (phù hợp với ngrok)
- ✅ Test được ngay trên emulator/simulator
- ✅ Ổn định, ít bug

## 🚀 Bước 1: Cài đặt package

Package đã được thêm vào `pubspec.yaml`:

```yaml
dependencies:
  uni_links: ^0.5.1
```

Chạy:
```bash
flutter pub get
```

## 📱 Bước 2: Config Android

Mở `android/app/src/main/AndroidManifest.xml` và thêm intent filter:

```xml
<activity
    android:name=".MainActivity"
    android:exported="true"
    android:launchMode="singleTop"
    android:theme="@style/LaunchTheme"
    android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
    android:hardwareAccelerated="true"
    android:windowSoftInputMode="adjustResize">
    
    <!-- Existing intent filters -->
    <intent-filter>
        <action android:name="android.intent.action.MAIN"/>
        <category android:name="android.intent.category.LAUNCHER"/>
    </intent-filter>
    
    <!-- 🔗 THÊM PHẦN NÀY: Deep Link cho invite links -->
    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <!-- Custom scheme: chattrix://invite/{token} -->
        <data
            android:scheme="chattrix"
            android:host="invite" />
    </intent-filter>
</activity>
```

## 🍎 Bước 3: Config iOS

Mở `ios/Runner/Info.plist` và thêm:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLName</key>
        <string>com.chattrix.app</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>chattrix</string>
        </array>
    </dict>
</array>

<!-- Cho phép HTTP (ngrok) -->
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

## 💻 Bước 4: Integrate vào main.dart

Mở `lib/main.dart` và thêm deep link handler:

```dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/services/deep_link_handler.dart';
import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  DeepLinkHandler? _deepLinkHandler;

  @override
  void initState() {
    super.initState();
    // Initialize deep link handler after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initDeepLinks();
    });
  }

  void _initDeepLinks() {
    final router = AppRouter.router(ref);
    _deepLinkHandler = DeepLinkHandler();
    _deepLinkHandler!.initialize(router);
  }

  @override
  void dispose() {
    _deepLinkHandler?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.router(ref);

    return MaterialApp.router(
      title: 'Chattrix',
      routerConfig: router,
      // ... other config
    );
  }
}
```

## 🧪 Bước 5: Test Deep Links

### Test trên Android Emulator

```bash
# Test custom scheme
adb shell am start -W -a android.intent.action.VIEW -d "chattrix://invite/abc123token"

# Hoặc với token thật từ app
adb shell am start -W -a android.intent.action.VIEW -d "chattrix://invite/d7fcc2cfcc1f4a4a"
```

### Test trên iOS Simulator

```bash
# Test custom scheme
xcrun simctl openurl booted "chattrix://invite/abc123token"

# Hoặc với token thật
xcrun simctl openurl booted "chattrix://invite/d7fcc2cfcc1f4a4a"
```

### Test trong Browser (Real Device)

Tạo file HTML để test:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Test Chattrix Deep Links</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            max-width: 600px;
            margin: 0 auto;
        }
        .link-box {
            background: #f0f0f0;
            padding: 20px;
            margin: 20px 0;
            border-radius: 8px;
        }
        a {
            display: inline-block;
            background: #007AFF;
            color: white;
            padding: 15px 30px;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
        }
        a:hover {
            background: #0051D5;
        }
    </style>
</head>
<body>
    <h1>🔗 Test Chattrix Deep Links</h1>
    
    <div class="link-box">
        <h2>Test Link 1</h2>
        <p>Token: abc123token</p>
        <a href="chattrix://invite/abc123token">Mở trong App</a>
    </div>
    
    <div class="link-box">
        <h2>Test Link 2</h2>
        <p>Token: d7fcc2cfcc1f4a4a</p>
        <a href="chattrix://invite/d7fcc2cfcc1f4a4a">Mở trong App</a>
    </div>
    
    <div class="link-box">
        <h2>Test Link 3 (Custom)</h2>
        <p>Nhập token của bạn:</p>
        <input type="text" id="tokenInput" placeholder="Nhập token..." style="width: 100%; padding: 10px; margin: 10px 0;">
        <button onclick="openLink()" style="padding: 10px 20px; background: #007AFF; color: white; border: none; border-radius: 5px; cursor: pointer;">
            Mở Link
        </button>
    </div>
    
    <script>
        function openLink() {
            const token = document.getElementById('tokenInput').value;
            if (token) {
                window.location.href = `chattrix://invite/${token}`;
            } else {
                alert('Vui lòng nhập token!');
            }
        }
    </script>
</body>
</html>
```

Host file này trên ngrok hoặc local server, rồi mở trên điện thoại thật.

## 🎯 Workflow với Ngrok

### 1. Tạo invite link trong app

```
1. Mở group chat
2. Vào Chat Info
3. Tap "Invite Links"
4. Tap FAB để tạo link mới
5. Copy token (ví dụ: d7fcc2cfcc1f4a4a)
```

### 2. Test deep link

**Cách 1: Dùng ADB/xcrun (Emulator/Simulator)**
```bash
adb shell am start -W -a android.intent.action.VIEW -d "chattrix://invite/d7fcc2cfcc1f4a4a"
```

**Cách 2: Dùng HTML file (Real Device)**
- Host HTML file trên ngrok
- Mở link trên điện thoại
- Tap vào link test

**Cách 3: Share link từ app**
- Trong app, tap "Share" trên invite link card
- Gửi qua message/email
- Tap vào link → App sẽ mở

### 3. Verify

App sẽ:
1. Mở InviteLinkInfoPage
2. Hiển thị thông tin nhóm
3. Cho phép join group

## 🐛 Troubleshooting

### Android: Deep link không hoạt động

**Kiểm tra:**
```bash
# Xem intent filters
adb shell dumpsys package com.chattrix.app | grep -A 5 "android.intent.action.VIEW"

# Clear app data và thử lại
adb shell pm clear com.chattrix.app
```

**Giải pháp:**
- Verify intent filter trong AndroidManifest.xml
- Rebuild app: `flutter clean && flutter run`
- Restart emulator

### iOS: Deep link không hoạt động

**Kiểm tra:**
- Verify CFBundleURLSchemes trong Info.plist
- Rebuild app: `flutter clean && flutter run`
- Restart simulator

### App không navigate đến đúng page

**Debug:**
```dart
// Trong DeepLinkHandler, check logs:
debugPrint('📱 Incoming deep link: $uri');
debugPrint('✅ Navigating to: $route');
```

**Giải pháp:**
- Check DeepLinkService.handleDeepLink() logic
- Verify route path trong route_config.dart
- Check token format

## 📝 Notes

### Với Ngrok

- ✅ Custom scheme (`chattrix://`) hoạt động tốt
- ✅ Không cần config domain
- ✅ Test được ngay
- ❌ Universal links (`https://`) không hoạt động (cần domain thật)

### Production

Khi deploy production với domain thật:
1. Giữ nguyên custom scheme config
2. Thêm universal links config (optional)
3. Host verification files nếu dùng universal links

## ✅ Checklist

- [ ] Thêm `uni_links` vào pubspec.yaml
- [ ] Config AndroidManifest.xml
- [ ] Config Info.plist
- [ ] Integrate DeepLinkHandler vào main.dart
- [ ] Test với adb/xcrun
- [ ] Test với HTML file
- [ ] Test share link từ app
- [ ] Verify navigation đến InviteLinkInfoPage
- [ ] Test join group flow

## 🎉 Kết quả

Sau khi setup xong:
- Tap vào link `chattrix://invite/{token}` → App mở
- App navigate đến InviteLinkInfoPage
- Hiển thị thông tin nhóm
- Cho phép join group

**Đơn giản, nhanh, không cần domain thật!** 🚀
