# 🚀 Quick Start - Deep Links với uni_links

## TL;DR - 3 bước đơn giản

### 1️⃣ Config Platform (5 phút)

**Android:** `android/app/src/main/AndroidManifest.xml`
```xml
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="chattrix" android:host="invite" />
</intent-filter>
```

**iOS:** `ios/Runner/Info.plist`
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>chattrix</string>
        </array>
    </dict>
</array>
```

### 2️⃣ Integrate vào main.dart (2 phút)

```dart
import 'core/services/deep_link_handler.dart';

class _MyAppState extends ConsumerState<MyApp> {
  DeepLinkHandler? _deepLinkHandler;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final router = AppRouter.router(ref);
      _deepLinkHandler = DeepLinkHandler();
      _deepLinkHandler!.initialize(router);
    });
  }

  @override
  void dispose() {
    _deepLinkHandler?.dispose();
    super.dispose();
  }
}
```

### 3️⃣ Test (1 phút)

```bash
# Android
adb shell am start -W -a android.intent.action.VIEW -d "chattrix://invite/abc123"

# iOS
xcrun simctl openurl booted "chattrix://invite/abc123"
```

## ✅ Done!

Link format: `chattrix://invite/{token}`

Xem chi tiết: [SETUP_DEEP_LINKS.md](./SETUP_DEEP_LINKS.md)
