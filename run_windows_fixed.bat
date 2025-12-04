@echo off
echo ========================================
echo    WINDOWS FIX - REBUILD APP
echo ========================================
echo.
echo Cleaning build cache...
call flutter clean
echo.
echo Getting dependencies...
call flutter pub get
echo.
echo Running code generation...
call dart run build_runner build --delete-conflicting-outputs
echo.
echo Starting app on Windows...
call flutter run -d windows

