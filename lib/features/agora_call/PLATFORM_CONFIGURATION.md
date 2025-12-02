# Platform-Specific Configuration for Agora Calls

This document describes the platform-specific configurations required for Agora RTC Engine integration in the Chattrix UI application.

## Android Configuration

### 1. Permissions (AndroidManifest.xml)

The following permissions have been added to `android/app/src/main/AndroidManifest.xml`:

#### Core Permissions (Already Present)
- `CAMERA` - Required for video calls
- `RECORD_AUDIO` - Required for audio and video calls
- `INTERNET` - Required for network communication

#### Agora-Specific Permissions (Added)
- `MODIFY_AUDIO_SETTINGS` - Allows Agora SDK to adjust audio settings during calls
- `ACCESS_NETWORK_STATE` - Enables network quality monitoring
- `ACCESS_WIFI_STATE` - Enables WiFi network quality monitoring
- `BLUETOOTH` (maxSdkVersion="30") - For Bluetooth audio devices on older Android versions
- `BLUETOOTH_CONNECT` - For Bluetooth audio devices on Android 12+

#### Hardware Features
```xml
<uses-feature android:name="android.hardware.camera" android:required="false" />
<uses-feature android:name="android.hardware.camera.autofocus" android:required="false" />
<uses-feature android:name="android.hardware.microphone" android:required="false" />
```

These are marked as `required="false"` to allow installation on devices without these features (though calls won't work).

### 2. Build Configuration (build.gradle.kts)

The following configurations have been added to `android/app/build.gradle.kts`:

#### NDK ABI Filters
```kotlin
ndk {
    abiFilters.addAll(listOf("armeabi-v7a", "arm64-v8a", "x86", "x86_64"))
}
```

This ensures the Agora SDK native libraries are included for all supported architectures.

#### Packaging Options
```kotlin
packagingOptions {
    pickFirst("lib/arm64-v8a/libc++_shared.so")
    pickFirst("lib/armeabi-v7a/libc++_shared.so")
    pickFirst("lib/x86/libc++_shared.so")
    pickFirst("lib/x86_64/libc++_shared.so")
}
```

This resolves conflicts when multiple dependencies include the same native library.

### 3. ProGuard Rules

If you encounter issues with ProGuard in release builds, add these rules to `android/app/proguard-rules.pro`:

```proguard
# Agora RTC Engine
-keep class io.agora.**{*;}
-dontwarn io.agora.**
```

## iOS Configuration

### 1. Permissions (Info.plist)

The following permissions are configured in `ios/Runner/Info.plist`:

#### Camera Permission
```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to make video calls and take photos/videos for chat messages.</string>
```

#### Microphone Permission
```xml
<key>NSMicrophoneUsageDescription</key>
<string>This app needs microphone access to make audio and video calls, and record audio messages.</string>
```

#### Background Modes
```xml
<key>UIBackgroundModes</key>
<array>
    <string>audio</string>
    <string>voip</string>
</array>
```

These modes allow the app to:
- Continue audio playback in the background during calls
- Receive VoIP push notifications for incoming calls

### 2. Podfile Configuration

A Podfile has been created at `ios/Podfile` with the following Agora-specific configurations:

#### Minimum iOS Version
```ruby
platform :ios, '12.0'
```

Agora RTC Engine requires iOS 12.0 or higher.

#### Post-Install Settings
```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # Disable bitcode (Agora SDK doesn't support it)
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      
      # Set minimum deployment target
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      
      # Exclude arm64 for simulator (compatibility)
      config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
      
      # Disable warnings for Agora SDK
      config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = 'YES'
      config.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = 'NO'
    end
  end
end
```

### 3. Installing Dependencies

After creating/modifying the Podfile, run:

```bash
cd ios
pod install
cd ..
```

This will download and configure the Agora SDK and other iOS dependencies.

## Testing Permissions

### Android Testing

1. **Install the app** on a physical device or emulator
2. **Navigate to a chat** and tap the call button
3. **Verify permission dialogs** appear for:
   - Microphone (for audio calls)
   - Camera (for video calls)
4. **Grant permissions** and verify the call initiates
5. **Check Settings > Apps > Chattrix > Permissions** to verify granted permissions

### iOS Testing

1. **Install the app** on a physical device or simulator
2. **Navigate to a chat** and tap the call button
3. **Verify permission dialogs** appear with the custom descriptions
4. **Grant permissions** and verify the call initiates
5. **Check Settings > Chattrix > Permissions** to verify granted permissions

### Testing Background Audio (iOS)

1. **Start a call** on iOS
2. **Press the home button** to background the app
3. **Verify audio continues** playing in the background
4. **Return to the app** and verify the call is still active

## Common Issues and Solutions

### Android

**Issue**: App crashes on startup after adding Agora SDK
- **Solution**: Ensure `minSdk` is at least 21 in `build.gradle.kts`

**Issue**: Native library conflicts
- **Solution**: Verify `packagingOptions` are correctly configured

**Issue**: Permissions not being requested
- **Solution**: Check that permissions are in `AndroidManifest.xml` and not just in the `<application>` tag

### iOS

**Issue**: Pod install fails
- **Solution**: Run `pod repo update` then `pod install` again

**Issue**: Bitcode errors during build
- **Solution**: Verify `ENABLE_BITCODE = 'NO'` is set in post_install

**Issue**: Simulator build fails with arm64 errors
- **Solution**: Verify `EXCLUDED_ARCHS[sdk=iphonesimulator*]` is set correctly

**Issue**: Permissions not being requested
- **Solution**: Ensure usage descriptions are in `Info.plist` and rebuild the app

## Environment Variables

Ensure the `.env` file contains the Agora App ID:

```env
AGORA_APP_ID=your_agora_app_id_here
```

This is loaded by the app at runtime and used to initialize the Agora SDK.

## Build Commands

### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## Next Steps

After completing platform configuration:

1. ✅ Permissions are configured
2. ✅ Build settings are configured
3. ✅ Podfile is created (iOS)
4. ⏭️ Test permissions on both platforms
5. ⏭️ Verify Agora SDK initializes correctly
6. ⏭️ Test complete call flow end-to-end

## References

- [Agora Flutter SDK Documentation](https://docs.agora.io/en/video-calling/get-started/get-started-sdk?platform=flutter)
- [Android Permissions Guide](https://developer.android.com/guide/topics/permissions/overview)
- [iOS Permissions Guide](https://developer.apple.com/documentation/uikit/protecting_the_user_s_privacy)
- [Flutter Platform Integration](https://docs.flutter.dev/platform-integration/platform-channels)
