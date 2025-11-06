# ==========================================
# Run selected Android emulator + Flutter app
# ==========================================

Write-Host ""
Write-Host "Getting available AVDs..."
$avds = & emulator -list-avds

if ($avds.Count -eq 0) {
    Write-Host "No Android Virtual Devices found!"
    exit 1
}

Write-Host ""
Write-Host "Available AVDs:"
for ($i = 0; $i -lt $avds.Count; $i++) {
    Write-Host "[$i] $($avds[$i])"
}

$choice = Read-Host "`nChoose emulator index (0..$($avds.Count - 1))"
if ($choice -lt 0 -or $choice -ge $avds.Count) {
    Write-Host "Invalid choice. Exiting."
    exit 1
}

$selectedAvd = $avds[$choice]
Write-Host ""
Write-Host "Starting emulator: $selectedAvd ..."

Start-Process -FilePath "emulator" -ArgumentList "@$selectedAvd -no-boot-anim -netdelay none -netspeed full"
