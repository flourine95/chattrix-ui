@echo off
echo ========================================
echo Rebuilding Android App
echo ========================================
echo.

echo Step 1: Flutter clean...
call flutter clean
echo.

echo Step 2: Get dependencies...
call flutter pub get
echo.

echo Step 3: Build Android APK (debug)...
call flutter build apk --debug
echo.

echo ========================================
echo Build complete!
echo ========================================
echo.
echo To install on device, run:
echo flutter install
echo.
pause
