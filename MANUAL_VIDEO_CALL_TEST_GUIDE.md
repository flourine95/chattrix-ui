# 📹 Manual Video Call Testing Guide

## ✅ Pre-Test Checklist

### 1. Backend Status
- [x] Backend is running (chattrix-api container is up)
- [x] Backend is accessible at http://localhost:8080
- [x] Agora credentials are configured:
  - AGORA_APP_ID: `9300ff3fc592405fa28e43a96ab2bf0f` ✅
  - AGORA_APP_CERTIFICATE: `b5807d0448a94153a1a4562c03a7de29` ✅

### 2. Frontend Configuration
- [x] Agora App ID matches backend: `9300ff3fc592405fa28e43a96ab2bf0f` ✅
- [x] Environment variables loaded from `.env` file

### 3. Critical Fix Applied
- [x] Task 1 completed: ChannelMediaOptions fix applied
  - ✅ Removed `channelProfile` from ChannelMediaOptions
  - ✅ Only `clientRoleType: ClientRoleType.clientRoleBroadcaster` is set
- [x] Task 2 completed: Enhanced logging added
- [x] Task 3 completed: EnvValidator implemented
- [x] Task 4 completed: User-friendly error messages added

---

## 🧪 Test Execution Steps

### Step 1: Start the Flutter Application

```bash
cd chattrix-ui
flutter run
```

**Expected Output:**
- App launches successfully
- No environment validation errors
- Console shows: `[EnvValidator] ✅ AGORA_APP_ID validated: 9300ff3f...`

**✅ Pass Criteria:**
- App starts without crashes
- No error dialogs appear
- Login screen is visible

---

### Step 2: User Login

**Actions:**
1. Navigate to login screen
2. Enter valid credentials (ensure user exists in backend)
3. Tap "Login" button

**Expected Output:**
- Successful authentication
- JWT token stored securely
- Navigate to home/chat screen
- WebSocket connection established

**✅ Pass Criteria:**
- Login succeeds without errors
- User is redirected to main app screen
- Console shows successful authentication logs

**❌ Fail Criteria:**
- Login fails with network error
- Token not stored
- App crashes

---

### Step 3: Initiate Video Call

**Actions:**
1. Navigate to a chat or contact
2. Tap the video call button (📹 icon)
3. Wait for call to initiate

**Expected Console Logs:**
```
[CallLogger] ℹ️ Initializing Agora with App ID: 9300ff3f...
[CallLogger] ℹ️ Agora engine initialized successfully
[CallLogger] ℹ️ Joining channel: channel_XXXXX with UID: XXXXXX, isVideo: true
[CallLogger] 🔍 Token (first 20 chars): 0069XXXXXXXXXXXXXXXX...
[CallLogger] ℹ️ Join channel request sent successfully
```

**Expected UI:**
- Call screen appears with "Connecting..." message
- Loading indicator visible
- Black background

**✅ Pass Criteria:**
- No error -17 in console logs
- Call screen loads
- "Connecting..." message appears
- No crash or error dialogs

**❌ Fail Criteria:**
- Error -17 appears: `errJoinChannelRejected`
- App crashes
- Error dialog shows
- Call screen doesn't load

---

### Step 4: Verify Join Success

**Wait for 3-5 seconds after initiating call**

**Expected Console Logs:**
```
[CallLogger] Agora event: onJoinChannelSuccess
[CallLogger] ✅ Successfully joined channel: channel_XXXXX
[CallLogger] Local UID: XXXXXX
```

**Expected UI:**
- "Connecting..." message disappears
- Local video preview appears (top-right corner)
- Call controls appear at bottom:
  - 🎤 Microphone button (active)
  - 📹 Video button (active)
  - 🔄 Camera switch button
  - ☎️ End call button (red)
- Call timer starts (00:00)
- Network quality indicator may appear

**✅ Pass Criteria:**
- Join succeeds (onJoinChannelSuccess event)
- Local video preview shows camera feed
- All controls are visible and responsive
- No error messages
- Call timer is running

**❌ Fail Criteria:**
- Join fails with error -17
- Local video doesn't appear
- Controls are missing
- Error message appears

---

### Step 5: Verify Video/Audio Streams

**Actions:**
1. Check local video preview (should show your camera)
2. Speak into microphone (check audio indicator if available)
3. Tap microphone button to mute/unmute
4. Tap video button to disable/enable video
5. Tap camera switch button (if on mobile device)

**Expected Behavior:**

**Local Video:**
- ✅ Camera feed visible in preview window
- ✅ Preview updates in real-time
- ✅ Preview can be toggled on/off

**Audio:**
- ✅ Microphone captures audio
- ✅ Mute button toggles state (icon changes: 🎤 ↔️ 🎤🚫)
- ✅ Audio can be muted/unmuted

**Video Toggle:**
- ✅ Video button toggles state (icon changes: 📹 ↔️ 📹🚫)
- ✅ Local preview disappears when video disabled
- ✅ Local preview reappears when video enabled

**Camera Switch:**
- ✅ Camera switches between front/back (mobile)
- ✅ No crash or freeze during switch

**✅ Pass Criteria:**
- All controls work as expected
- Video feed is smooth (no freezing)
- Audio mute/unmute works
- Video enable/disable works
- Camera switch works (mobile)

**❌ Fail Criteria:**
- Controls don't respond
- Video freezes
- Audio doesn't mute
- App crashes when toggling controls

---

### Step 6: Verify Remote User Can Join

**Setup:**
- Use a second device or emulator
- Login with a different user account
- Have the first user call the second user (or vice versa)

**Actions:**
1. User A initiates call to User B
2. User B receives incoming call notification
3. User B accepts the call

**Expected Behavior:**

**User A (Caller):**
- ✅ Call screen shows "Calling..." or "Ringing..."
- ✅ When User B joins, remote video appears (full screen)
- ✅ Console shows: `[CallLogger] Agora event: onUserJoined, UID: XXXXX`

**User B (Callee):**
- ✅ Incoming call screen appears
- ✅ Accept button is visible
- ✅ After accepting, joins channel successfully
- ✅ Sees User A's video (full screen)
- ✅ Local preview appears (top-right)

**Both Users:**
- ✅ Can see each other's video
- ✅ Can hear each other's audio
- ✅ Controls work for both users
- ✅ Network quality indicator shows connection status

**✅ Pass Criteria:**
- Both users successfully join the same channel
- Video streams work bidirectionally
- Audio streams work bidirectionally
- No error -17 for either user
- Call is stable

**❌ Fail Criteria:**
- Second user gets error -17
- Video doesn't appear for remote user
- Audio doesn't work
- Call drops immediately
- App crashes for either user

---

### Step 7: End Call Successfully

**Actions:**
1. Tap the red "End Call" button (☎️)
2. Wait for call to end

**Expected Console Logs:**
```
[CallLogger] ℹ️ Leaving channel...
[CallLogger] Agora event: onLeaveChannel
[CallLogger] ✅ Successfully left channel
```

**Expected UI:**
- Call screen closes
- Navigate back to previous screen (chat/contact list)
- No error dialogs
- No crash

**Expected Cleanup:**
- ✅ Agora engine releases resources
- ✅ Camera stops
- ✅ Microphone stops
- ✅ WebSocket notifies backend of call end

**✅ Pass Criteria:**
- Call ends gracefully
- User returns to previous screen
- No memory leaks
- No lingering video/audio
- Backend receives call end notification

**❌ Fail Criteria:**
- App crashes on end call
- User stuck on call screen
- Camera/microphone still active
- Error dialog appears

---

## 🔍 Verification Checklist

After completing all steps, verify:

- [ ] **No Error -17**: Console logs show NO `errJoinChannelRejected` errors
- [ ] **Join Success**: Both users successfully joined the channel
- [ ] **Video Works**: Local and remote video streams are visible
- [ ] **Audio Works**: Both users can hear each other
- [ ] **Controls Work**: All buttons (mute, video, camera switch, end) function correctly
- [ ] **Stable Connection**: Call remains stable for at least 30 seconds
- [ ] **Clean Exit**: Call ends without errors or crashes
- [ ] **Logging**: All expected log messages appear in console

---

## 🐛 Troubleshooting

### If Error -17 Still Occurs:

1. **Check Console Logs:**
   ```
   Look for: "channelProfile" in ChannelMediaOptions
   Should NOT appear in join request
   ```

2. **Verify Fix Applied:**
   - Open `lib/features/call/data/services/agora_service.dart`
   - Line ~110: Ensure ChannelMediaOptions only has `clientRoleType`
   - Should look like:
     ```dart
     options: const ChannelMediaOptions(
       clientRoleType: ClientRoleType.clientRoleBroadcaster,
     )
     ```

3. **Check App ID Match:**
   ```bash
   # Frontend
   grep AGORA_APP_ID chattrix-ui/.env
   
   # Backend
   grep AGORA_APP_ID chattrix-api/.env
   ```
   Both should show: `9300ff3fc592405fa28e43a96ab2bf0f`

4. **Restart Everything:**
   ```bash
   # Stop Flutter app
   # Restart backend
   cd chattrix-api
   docker-compose restart
   
   # Clear Flutter build cache
   cd chattrix-ui
   flutter clean
   flutter pub get
   flutter run
   ```

### If Video Doesn't Appear:

1. **Check Permissions:**
   - Camera permission granted?
   - Microphone permission granted?

2. **Check Console for Errors:**
   - Look for permission denied errors
   - Look for camera initialization errors

3. **Try Audio-Only Call:**
   - If audio works but video doesn't, it's a camera issue
   - Check device camera settings

### If Remote User Can't Join:

1. **Check Token Generation:**
   - Backend logs should show token generation
   - Token should be valid for the channel

2. **Check Network:**
   - Both devices on same network?
   - Firewall blocking Agora ports?

3. **Check Backend Logs:**
   ```bash
   docker logs chattrix-api --tail 50
   ```
   Look for call-related errors

---

## 📊 Test Results Template

```
Test Date: _______________
Tester: _______________
Device: _______________
OS Version: _______________

✅ = Pass | ❌ = Fail | ⚠️ = Partial

[ ] Step 1: App Launch
[ ] Step 2: User Login
[ ] Step 3: Initiate Video Call
[ ] Step 4: Join Success (No Error -17)
[ ] Step 5: Video/Audio Streams Work
[ ] Step 6: Remote User Can Join
[ ] Step 7: End Call Successfully

Overall Result: _______________

Notes:
_________________________________
_________________________________
_________________________________
```

---

## 🎯 Success Criteria Summary

**Requirements Validated:**
- ✅ Requirement 1.1: Token successfully fetched and used
- ✅ Requirement 1.2: Channel profile consistent (Communication)
- ✅ Requirement 1.3: Engine initialized with correct profile
- ✅ Requirement 1.4: ChannelMediaOptions doesn't override profile

**Test Passes If:**
1. No error -17 occurs during join
2. Both users successfully join the channel
3. Video and audio streams work bidirectionally
4. All controls function correctly
5. Call ends cleanly without errors

**Test Fails If:**
- Error -17 appears at any point
- Join fails for any user
- Video or audio doesn't work
- App crashes during call
- Call cannot be ended properly
