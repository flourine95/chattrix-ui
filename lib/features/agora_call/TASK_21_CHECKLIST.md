# Task 21: Platform Configuration Checklist

## ✅ Completed Configurations

### Android
- [x] Added Agora-specific permissions to AndroidManifest.xml:
  - `MODIFY_AUDIO_SETTINGS`
  - `ACCESS_NETWORK_STATE`
  - `ACCESS_WIFI_STATE`
  - `BLUETOOTH` (maxSdkVersion="30")
  - `BLUETOOTH_CONNECT`
- [x] Configured NDK ABI filters in build.gradle.kts
- [x] Added packaging options to resolve native library conflicts
- [x] Verified camera and microphone permissions are present

### iOS
- [x] Created Podfile with Agora SDK configuration
- [x] Set minimum iOS version to 12.0
- [x] Configured post_install settings:
  - Disabled bitcode
  - Set deployment target
  - Excluded arm64 for simulator
  - Disabled warnings
- [x] Verified camera and microphone usage descriptions in Info.plist
- [x] Verified background modes (audio, voip) are configured

### Documentation
- [x] Created comprehensive PLATFORM_CONFIGURATION.md guide
- [x] Documented all permissions and their purposes
- [x] Included troubleshooting section
- [x] Added testing instructions

## 🧪 Testing Checklist (To Be Done)

### Android Testing
- [ ] Build the app: `flutter build apk --debug`
- [ ] Install on physical device or emulator
- [ ] Navigate to chat and tap call button
- [ ] Verify microphone permission dialog appears
- [ ] Grant microphone permission
- [ ] For video calls, verify camera permission dialog appears
- [ ] Grant camera permission
- [ ] Verify call initiates successfully
- [ ] Check app settings to confirm permissions are granted
- [ ] Test permission denial scenario
- [ ] Test revoking permissions and re-requesting

### iOS Testing
- [ ] Install CocoaPods dependencies: `cd ios && pod install`
- [ ] Build the app: `flutter build ios --debug`
- [ ] Install on physical device or simulator
- [ ] Navigate to chat and tap call button
- [ ] Verify permission dialogs show custom descriptions
- [ ] Grant microphone permission
- [ ] For video calls, grant camera permission
- [ ] Verify call initiates successfully
- [ ] Test background audio:
  - [ ] Start a call
  - [ ] Press home button
  - [ ] Verify audio continues
  - [ ] Return to app
  - [ ] Verify call is still active
- [ ] Check iOS Settings > Chattrix to confirm permissions
- [ ] Test permission denial scenario

### Cross-Platform Testing
- [ ] Test audio call on Android
- [ ] Test audio call on iOS
- [ ] Test video call on Android
- [ ] Test video call on iOS
- [ ] Verify Agora SDK initializes without errors
- [ ] Check logs for any permission-related warnings
- [ ] Test on different Android versions (API 21+)
- [ ] Test on different iOS versions (12.0+)

## 📋 Requirements Validation

**Requirement 8.2**: WHEN the Agora SDK fails to join a channel, THEN the Call System SHALL notify the user and send an end request to the backend

- [x] Permissions configured to prevent join failures
- [ ] Test permission denial handling
- [ ] Verify error notification appears
- [ ] Verify end request is sent to backend

## 🔍 Verification Commands

### Check Android Permissions
```bash
# View AndroidManifest.xml permissions
cat android/app/src/main/AndroidManifest.xml | grep "uses-permission"
```

### Check iOS Permissions
```bash
# View Info.plist usage descriptions
cat ios/Runner/Info.plist | grep -A 1 "Usage"
```

### Check Agora SDK Version
```bash
# View pubspec.yaml
cat pubspec.yaml | grep agora_rtc_engine
```

### Build and Check for Errors
```bash
# Android
flutter build apk --debug

# iOS (requires macOS)
flutter build ios --debug
```

## 🚨 Known Issues and Solutions

### Android
- **Issue**: Native library conflicts
  - **Status**: ✅ Resolved with packagingOptions
  
- **Issue**: Bluetooth permission on Android 12+
  - **Status**: ✅ Added BLUETOOTH_CONNECT permission

### iOS
- **Issue**: Bitcode not supported by Agora SDK
  - **Status**: ✅ Disabled in Podfile post_install
  
- **Issue**: Simulator arm64 architecture
  - **Status**: ✅ Excluded in Podfile post_install

## 📝 Notes

1. **Environment Variable**: Ensure `.env` file contains `AGORA_APP_ID`
2. **Minimum Versions**: 
   - Android: API 21 (Android 5.0)
   - iOS: 12.0
3. **Physical Device Recommended**: Camera and microphone testing works best on physical devices
4. **Background Audio**: iOS background modes allow calls to continue when app is backgrounded

## ✅ Task Completion Criteria

- [x] All Android permissions added
- [x] Android build configuration updated
- [x] iOS Podfile created and configured
- [x] iOS permissions verified
- [x] Documentation created
- [ ] Permissions tested on Android device
- [ ] Permissions tested on iOS device
- [ ] No build errors on either platform

## 🎯 Next Steps

After completing this task:
1. Run `cd ios && pod install` to install iOS dependencies
2. Test permissions on both platforms
3. Proceed to Task 22: Integrate with existing app navigation
4. Complete end-to-end call testing
