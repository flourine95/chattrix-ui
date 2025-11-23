# Quick Start: Adding Ringtone

## Step 1: Get a Ringtone File
Download a free ringtone from one of these sources:
- https://freesound.org/search/?q=phone+ringtone
- https://mixkit.co/free-sound-effects/phone/
- https://www.zapsplat.com/sound-effect-category/phone-ringtones/

## Step 2: Prepare the File
1. Ensure the file is in MP3 format
2. Rename it to exactly: `ringtone.mp3`
3. Recommended: Keep duration between 3-5 seconds (it will loop)

## Step 3: Place the File
Copy `ringtone.mp3` to this directory:
```
chattrix-ui/assets/sounds/ringtone.mp3
```

## Step 4: Update Flutter Assets
Run this command in the chattrix-ui directory:
```bash
flutter pub get
```

## Step 5: Test
1. Run the app
2. Trigger an incoming call
3. Verify the ringtone plays and loops
4. Accept or reject the call to verify it stops

## Troubleshooting

**Ringtone doesn't play:**
- Check file is named exactly `ringtone.mp3`
- Check file is in `assets/sounds/` directory
- Run `flutter clean` then `flutter pub get`
- Check device volume is not muted

**App crashes on incoming call:**
- Check the MP3 file is valid (try playing it in a media player)
- Check Flutter logs for audio player errors
- Ensure `audioplayers` package is properly installed

## For Testing Only
If you just want to test the functionality quickly, you can use any MP3 file:
1. Find any MP3 file on your computer
2. Copy it to `assets/sounds/`
3. Rename it to `ringtone.mp3`
4. Run `flutter pub get`
