# 🎙️ Manual Audio-Only Call Testing Guide

## ✅ Pre-Test Checklist

### 1. Backend Status
- [ ] Backend is running (chattrix-api container is up)
- [ ] Backend is accessible at http://localhost:8080
- [ ] Agora credentials are configured:
  - AGORA_APP_ID: `9300ff3fc592405fa28e43a96ab2bf0f` ✅
  - AGORA_APP_CERTIFICATE: `b5807d0448a94153a1a4562c03a7de29` ✅

### 2. Frontend Configuration
- [ ] Agora App ID matches backend: `9300ff3fc592405fa28e43a96ab2bf0f` ✅
- [ ] Environment variables loaded from `.env` file

### 3. Critical Fix Applied
- [ ] Task 1 completed: ChannelMediaOptions fix applied
  - ✅ Removed `channelProfile` from ChannelMediaOptions
  - ✅ Only `clientRoleType: ClientRoleType.clientRoleBroadcaster` is set
- [ ] Task 2 completed: Enhanced logging added

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

### Step 3: Initiate Audio-Only Call

**Actions:**
1. Navigate to a chat or contact
2. Tap the **audio call button** (🎙️ or phone icon)
3. Wait for call to initiate

**Expected Console Logs:**
```
[AgoraService] 🚀 Starting Agora engine initialization...
[AgoraService] 🔑 App ID: 9300ff3f...
[AgoraService] 📡 Channel Profile: Communication (0)
[AgoraService] ✅ Agora engine initialized successfully
[AgoraService] 🎯 Attempting to join channel...
[AgoraService] 📺 Channel ID: channel_XXXXX
[AgoraService] 👤 UID: XXXXXX
[AgoraService] 🎥 Video enabled: false
[AgoraService] 🔐 Token (first 20 chars): 0069XXXXXXXXXXXXXXXX...
[AgoraService] ⚙️ ChannelMediaOptions: {clientRoleType: Broadcaster (1)}
[AgoraService] 🔊 Audio enabled
[AgoraService] 📹 Video disabled (audio-only call)
[AgoraService] ✅ Join channel request sent successfully
```

**Key Verification Points:**
- ✅ `Video enabled: false` appears in logs
- ✅ `Video disabled (audio-only call)` message appears
- ✅ `Audio enabled` message appears
- ✅ NO `Video enabled and preview started` message

**Expected UI:**
- Call screen appears with "Connecting..." message
- Loading indicator visible
- **NO video preview** (this is audio-only)
- Black or minimal background

**✅ Pass Criteria:**
- No error -17 in console logs
- Call screen loads
- "Connecting..." message appears
- No video preview appears (correct for audio-only)
- No crash or error dialogs

**❌ Fail Criteria:**
- Error -17 appears: `errJoinChannelRejected`
- App crashes
- Error dialog shows
- Video preview appears (incorrect for audio-only)
- Call screen doesn't load

---

### Step 4: Verify Join Success

**Wait for 3-5 seconds after initiating call**

**Expected Console Logs:**
```
[AgoraService] ✅ Join channel SUCCESS
[AgoraService]    └─ Channel: channel_XXXXX
[AgoraService]    └─ Local UID: XXXXXX
[AgoraService]    └─ Elapsed time: XXXms
```

**Expected UI:**
- "Connecting..." message disappears
- **NO video preview** (audio-only call)
- Call controls appear at bottom:
  - 🎤 Microphone button (active/unmuted)
  - ☎️ End call button (red)
  - **NO video button** (or video button disabled/hidden)
  - **NO camera switch button** (not applicable for audio)
- Call timer starts (00:00)
- Network quality indicator may appear
- User avatar or placeholder image may be shown

**✅ Pass Criteria:**
- Join succeeds (onJoinChannelSuccess event)
- NO video preview appears
- Audio controls are visible and responsive
- No error messages
- Call timer is running
- UI clearly indicates audio-only mode

**❌ Fail Criteria:**
- Join fails with error -17
- Video preview appears (incorrect)
- Controls are missing
- Error message appears
- App crashes

---

### Step 5: Verify Audio Stream Works

**Actions:**
1. Speak into microphone
2. Tap microphone button to mute
3. Speak again (should not be heard by remote user)
4. Tap microphone button to unmute
5. Speak again (should be heard by remote user)

**Expected Behavior:**

**Audio:**
- ✅ Microphone captures audio when unmuted
- ✅ Mute button toggles state (icon changes: 🎤 ↔️ 🎤🚫)
- ✅ Audio can be muted/unmuted
- ✅ Audio indicator shows when speaking (if available)

**Video:**
- ✅ NO video preview at any time
- ✅ Video button is disabled, hidden, or not present
- ✅ Camera switch button is disabled, hidden, or not present

**Expected Console Logs:**
```
[CallLogger] 📊 Media control: Audio - Enabled: false (when muted)
[CallLogger] 📊 Media control: Audio - Enabled: true (when unmuted)
```

**✅ Pass Criteria:**
- Audio mute/unmute works correctly
- No video preview appears at any time
- Video controls are appropriately disabled/hidden
- Audio quality is clear
- No crashes when toggling controls

**❌ Fail Criteria:**
- Audio doesn't mute
- Video preview appears
- Video controls are active (incorrect for audio-only)
- App crashes when toggling controls
- Audio quality is poor or distorted

---

### Step 6: Verify Remote User Can Join (Audio-Only)

**Setup:**
- Use a second device or emulator
- Login with a different user account
- Have the first user call the second user with an audio call

**Actions:**
1. User A initiates **audio call** to User B
2. User B receives incoming call notification (should indicate audio-only)
3. User B accepts the call

**Expected Behavior:**

**User A (Caller):**
- ✅ Call screen shows "Calling..." or "Ringing..."
- ✅ NO video preview
- ✅ When User B joins, console shows: `[AgoraService] 👥 User JOINED`
- ✅ Audio from User B is heard

**User B (Callee):**
- ✅ Incoming call screen appears
- ✅ Call type indicator shows "Audio Call" or phone icon
- ✅ Accept button is visible
- ✅ After accepting, joins channel successfully
- ✅ NO video preview
- ✅ Hears User A's audio

**Both Users:**
- ✅ Can hear each other's audio clearly
- ✅ NO video streams (correct for audio-only)
- ✅ Audio controls work for both users
- ✅ Network quality indicator shows connection status
- ✅ Call timer is running

**Expected Console Logs (Both Users):**
```
[AgoraService] 🎥 Video enabled: false
[AgoraService] 📹 Video disabled (audio-only call)
[AgoraService] 🔊 Audio enabled
[AgoraService] 👥 User JOINED
[AgoraService]    └─ Remote UID: XXXXX
```

**✅ Pass Criteria:**
- Both users successfully join the same channel
- Audio streams work bidirectionally
- NO video streams (correct behavior)
- No error -17 for either user
- Call is stable
- Both users clearly understand it's an audio-only call

**❌ Fail Criteria:**
- Second user gets error -17
- Video appears for either user (incorrect)
- Audio doesn't work
- Call drops immediately
- App crashes for either user
- UI incorrectly shows video controls

---

### Step 7: Verify Video Cannot Be Enabled During Audio Call

**Actions:**
1. During an active audio call, attempt to enable video (if button exists)
2. Check that video remains disabled

**Expected Behavior:**
- ✅ Video button is disabled, hidden, or shows "Not available in audio call"
- ✅ If video button is tapped, nothing happens or a message appears
- ✅ Video preview never appears
- ✅ Call continues as audio-only

**Expected Console Logs:**
```
[CallLogger] ⚠️ Cannot switch camera in audio-only call (if attempted)
```

**✅ Pass Criteria:**
- Video cannot be enabled during audio-only call
- UI clearly indicates audio-only mode
- No crashes when attempting to enable video

**❌ Fail Criteria:**
- Video can be enabled (incorrect)
- App crashes when attempting to enable video
- UI is confusing about call type

---

### Step 8: End Call Successfully

**Actions:**
1. Tap the red "End Call" button (☎️)
2. Wait for call to end

**Expected Console Logs:**
```
[CallLogger] ℹ️ Ending call
[AgoraService] 👋 User OFFLINE (if remote user present)
[CallLogger] ✅ Call ended
```

**Expected UI:**
- Call screen closes
- Navigate back to previous screen (chat/contact list)
- No error dialogs
- No crash

**Expected Cleanup:**
- ✅ Agora engine releases resources
- ✅ Microphone stops
- ✅ WebSocket notifies backend of call end

**✅ Pass Criteria:**
- Call ends gracefully
- User returns to previous screen
- No memory leaks
- No lingering audio
- Backend receives call end notification

**❌ Fail Criteria:**
- App crashes on end call
- User stuck on call screen
- Microphone still active
- Error dialog appears

---

## 🔍 Verification Checklist

After completing all steps, verify:

- [ ] **No Error -17**: Console logs show NO `errJoinChannelRejected` errors
- [ ] **Join Success**: Both users successfully joined the channel
- [ ] **Audio Works**: Both users can hear each other clearly
- [ ] **Video Disabled**: NO video preview appears at any time
- [ ] **Video Controls Hidden**: Video and camera switch buttons are disabled/hidden
- [ ] **Audio Controls Work**: Mute/unmute button functions correctly
- [ ] **Stable Connection**: Call remains stable for at least 30 seconds
- [ ] **Clean Exit**: Call ends without errors or crashes
- [ ] **Logging**: All expected log messages appear in console
- [ ] **UI Clarity**: UI clearly indicates audio-only mode

---

## 🐛 Troubleshooting

### If Error -17 Still Occurs:

1. **Check Console Logs:**
   ```
   Look for: "Video enabled: false"
   Should see: "Video disabled (audio-only call)"
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

### If Video Appears (Incorrect):

1. **Check Call Type:**
   - Ensure you're initiating an **audio call**, not a video call
   - Check the button you're tapping (should be phone/audio icon, not video icon)

2. **Check Console Logs:**
   - Should see: `Video enabled: false`
   - Should see: `Video disabled (audio-only call)`
   - Should NOT see: `Video enabled and preview started`

3. **Check Repository Code:**
   - Open `lib/features/call/data/repositories/call_repository_impl.dart`
   - Verify: `isVideo: callType == CallType.video`
   - For audio calls, this should evaluate to `false`

### If Audio Doesn't Work:

1. **Check Permissions:**
   - Microphone permission granted?
   - Check device microphone settings

2. **Check Console for Errors:**
   - Look for permission denied errors
   - Look for audio initialization errors

3. **Test with Video Call:**
   - If audio works in video calls but not audio-only, it's a call type issue
   - If audio doesn't work in either, it's a permission or device issue

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
[ ] Step 3: Initiate Audio-Only Call
[ ] Step 4: Join Success (No Error -17)
[ ] Step 5: Audio Stream Works
[ ] Step 6: Remote User Can Join (Audio-Only)
[ ] Step 7: Video Cannot Be Enabled
[ ] Step 8: End Call Successfully

Overall Result: _______________

Notes:
_________________________________
_________________________________
_________________________________
```

---

## 🎯 Success Criteria Summary

**Requirements Validated:**
- ✅ Requirement 9.2: Video is disabled for audio-only calls
- ✅ Requirement 1.2: Channel profile consistent (Communication)
- ✅ Requirement 1.3: Engine initialized with correct profile
- ✅ Requirement 1.4: ChannelMediaOptions doesn't override profile

**Test Passes If:**
1. No error -17 occurs during join
2. Both users successfully join the channel
3. Audio streams work bidirectionally
4. **Video is completely disabled** (no preview, no controls)
5. Audio controls function correctly
6. Call ends cleanly without errors

**Test Fails If:**
- Error -17 appears at any point
- Join fails for any user
- Audio doesn't work
- **Video appears** (incorrect for audio-only)
- **Video controls are active** (incorrect for audio-only)
- App crashes during call
- Call cannot be ended properly

---

## 📝 Comparison: Audio vs Video Calls

| Feature | Audio Call | Video Call |
|---------|-----------|------------|
| **Video Preview** | ❌ None | ✅ Local preview visible |
| **Video Button** | ❌ Disabled/Hidden | ✅ Active |
| **Camera Switch** | ❌ Disabled/Hidden | ✅ Active |
| **Audio Button** | ✅ Active | ✅ Active |
| **End Call Button** | ✅ Active | ✅ Active |
| **Console Log** | `Video enabled: false` | `Video enabled: true` |
| **Console Log** | `Video disabled (audio-only call)` | `Video enabled and preview started` |
| **Permissions** | Microphone only | Camera + Microphone |
| **UI Indicator** | Phone/Audio icon | Video camera icon |

