# Deep Link Integration Guide

This guide explains how to integrate deep link handling for invite links in the Chattrix UI app.

## Overview

The `DeepLinkService` is ready to handle invite link deep links in two formats:
- Custom scheme: `chattrix://invite/{token}`
- Universal link: `https://chattrix.app/invite/{token}`

## Platform Configuration

### Android

1. **Add intent filters to `android/app/src/main/AndroidManifest.xml`:**

```xml
<activity
    android:name=".MainActivity"
    ...>
    
    <!-- Existing intent filters -->
    
    <!-- Deep Link: chattrix://invite/{token} -->
    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data
            android:scheme="chattrix"
            android:host="invite" />
    </intent-filter>
    
    <!-- Universal Link: https://chattrix.app/invite/{token} -->
    <intent-filter android:autoVerify="true">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data
            android:scheme="https"
            android:host="chattrix.app"
            android:pathPrefix="/invite" />
    </intent-filter>
</activity>
```

2. **For App Links (Universal Links), host the Digital Asset Links file:**

Create `https://chattrix.app/.well-known/assetlinks.json`:

```json
[{
  "relation": ["delegate_permission/common.handle_all_urls"],
  "target": {
    "namespace": "android_app",
    "package_name": "com.chattrix.app",
    "sha256_cert_fingerprints": [
      "YOUR_APP_SHA256_FINGERPRINT"
    ]
  }
}]
```

Get your SHA256 fingerprint:
```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

### iOS

1. **Add URL schemes to `ios/Runner/Info.plist`:**

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
```

2. **For Universal Links, add Associated Domains:**

In Xcode:
- Select your target
- Go to "Signing & Capabilities"
- Add "Associated Domains" capability
- Add domain: `applinks:chattrix.app`

3. **Host the Apple App Site Association file:**

Create `https://chattrix.app/.well-known/apple-app-site-association`:

```json
{
  "applinks": {
    "apps": [],
    "details": [
      {
        "appID": "TEAM_ID.com.chattrix.app",
        "paths": ["/invite/*"]
      }
    ]
  }
}
```

## Flutter Integration

### Option 1: Using `uni_links` package (Recommended)

1. **Add dependency to `pubspec.yaml`:**

```yaml
dependencies:
  uni_links: ^0.5.1
```

2. **Initialize in `main.dart`:**

```dart
import 'package:uni_links/uni_links.dart';
import 'dart:async';
import 'package:chattrix_ui/core/services/deep_link_service.dart';

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    
    // Initialize deep link handling
    _initDeepLinkListener(router);
    
    return MaterialApp.router(
      routerConfig: router,
      // ...
    );
  }
  
  void _initDeepLinkListener(GoRouter router) {
    // Handle initial link (app opened from deep link)
    _handleInitialLink(router);
    
    // Handle links while app is running
    _handleIncomingLinks(router);
  }
  
  Future<void> _handleInitialLink(GoRouter router) async {
    try {
      final initialUri = await getInitialUri();
      if (initialUri != null) {
        final route = DeepLinkService.handleDeepLink(initialUri);
        if (route != null) {
          router.go(route);
        }
      }
    } catch (e) {
      debugPrint('Error handling initial link: $e');
    }
  }
  
  void _handleIncomingLinks(GoRouter router) {
    uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        final route = DeepLinkService.handleDeepLink(uri);
        if (route != null) {
          router.go(route);
        }
      }
    }, onError: (err) {
      debugPrint('Error handling incoming link: $err');
    });
  }
}
```

### Option 2: Using `app_links` package (Modern Alternative)

1. **Add dependency to `pubspec.yaml`:**

```yaml
dependencies:
  app_links: ^3.5.0
```

2. **Initialize in `main.dart`:**

```dart
import 'package:app_links/app_links.dart';
import 'package:chattrix_ui/core/services/deep_link_service.dart';

class MyApp extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  
  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }
  
  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }
  
  Future<void> _initDeepLinks() async {
    _appLinks = AppLinks();
    
    // Handle initial link
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      _handleDeepLink(initialUri);
    }
    
    // Handle links while app is running
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      _handleDeepLink(uri);
    });
  }
  
  void _handleDeepLink(Uri uri) {
    final router = ref.read(routerProvider);
    final route = DeepLinkService.handleDeepLink(uri);
    if (route != null) {
      router.go(route);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      routerConfig: router,
      // ...
    );
  }
}
```

## Testing

### Test Custom Scheme (chattrix://)

**Android:**
```bash
adb shell am start -W -a android.intent.action.VIEW -d "chattrix://invite/abc123token"
```

**iOS:**
```bash
xcrun simctl openurl booted "chattrix://invite/abc123token"
```

### Test Universal Link (https://)

**Android:**
```bash
adb shell am start -W -a android.intent.action.VIEW -d "https://chattrix.app/invite/abc123token"
```

**iOS:**
```bash
xcrun simctl openurl booted "https://chattrix.app/invite/abc123token"
```

### Test in Browser

Create a test HTML file:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Test Deep Links</title>
</head>
<body>
    <h1>Chattrix Invite Link Test</h1>
    
    <h2>Custom Scheme</h2>
    <a href="chattrix://invite/abc123token">Open in App (Custom Scheme)</a>
    
    <h2>Universal Link</h2>
    <a href="https://chattrix.app/invite/abc123token">Open in App (Universal Link)</a>
</body>
</html>
```

## Verification

### Android App Links Verification

```bash
adb shell pm get-app-links com.chattrix.app
```

### iOS Universal Links Verification

Use Apple's validator:
https://search.developer.apple.com/appsearch-validation-tool/

## Troubleshooting

### Android

1. **App Links not working:**
   - Verify `assetlinks.json` is accessible at `https://chattrix.app/.well-known/assetlinks.json`
   - Check SHA256 fingerprint matches
   - Clear app data and reinstall

2. **Deep links open in browser:**
   - Check intent filter priority
   - Verify `android:autoVerify="true"` is set

### iOS

1. **Universal Links not working:**
   - Verify `apple-app-site-association` is accessible
   - Check Associated Domains capability is enabled
   - Test on a real device (simulator may have issues)

2. **Custom scheme not working:**
   - Verify URL scheme is registered in Info.plist
   - Check for conflicts with other apps

## Security Considerations

1. **Token Validation:**
   - The invite link token is validated by the backend API
   - Invalid tokens will show an error page

2. **Authentication:**
   - Public invite link info page doesn't require authentication
   - Joining a group requires authentication
   - Unauthenticated users will be redirected to login

3. **Rate Limiting:**
   - Backend API implements rate limiting for invite link endpoints
   - Prevents abuse of invite link system

## Next Steps

1. Choose a deep link package (`uni_links` or `app_links`)
2. Add platform-specific configuration
3. Implement deep link listener in `main.dart`
4. Test on both Android and iOS
5. Deploy web files for universal links
6. Test with real invite links from the app
