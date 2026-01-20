@echo off
echo [AUTO] Dang quet thiet bi va Reverse Port...
echo.

powershell -Command "foreach($line in (adb devices)) { if($line -match '\tdevice$') { $id=$line.Split()[0]; Write-Host ('-> Tim thay: ' + $id); cmd /c adb -s $id reverse tcp:8080 tcp:8080; Write-Host '   [OK] Da noi 8080.' } }"

echo.
echo [DONE] Hoan tat! Gio ban cu cam may nao vao la no nhan may do.
pause