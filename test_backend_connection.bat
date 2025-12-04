@echo off
echo ========================================
echo    TEST BACKEND CONNECTION
echo ========================================
echo.
echo [1/3] Checking backend health...
curl -X OPTIONS http://localhost:8080/api/v1/auth/login 2>nul
if %errorlevel% neq 0 (
    echo ❌ Backend is NOT running at localhost:8080
    echo    Please start your backend server first!
    pause
    exit /b 1
)
echo ✅ Backend is running!
echo.
echo [2/3] Starting Flutter app on Windows...
echo    Watch for these logs:
echo    - Platform: windows
echo    - HTTP Base URL: http://localhost:8080/api
echo    - WebSocket Base URL: ws://localhost:8080
echo.
echo [3/3] After app starts, please LOGIN to connect WebSocket
echo.
pause
flutter run -d windows

