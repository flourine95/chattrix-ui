import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// Shows a dialog when camera permission is denied
/// Provides option to open app settings
Future<void> showCameraPermissionDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.videocam_off, color: Colors.orange),
            SizedBox(width: 12),
            Text('Camera Permission Required'),
          ],
        ),
        content: const Text(
          'This app needs camera access to enable video calls. '
          'Please grant camera permission in your device settings.',
        ),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      );
    },
  );
}

/// Shows a dialog when microphone permission is denied
/// Provides option to open app settings
Future<void> showMicrophonePermissionDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.mic_off, color: Colors.orange),
            SizedBox(width: 12),
            Text('Microphone Permission Required'),
          ],
        ),
        content: const Text(
          'This app needs microphone access to enable audio calls. '
          'Please grant microphone permission in your device settings.',
        ),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      );
    },
  );
}

/// Shows a dialog when both camera and microphone permissions are denied
/// Provides option to open app settings
Future<void> showMediaPermissionsDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.block, color: Colors.orange),
            SizedBox(width: 12),
            Text('Media Permissions Required'),
          ],
        ),
        content: const Text(
          'This app needs camera and microphone access to enable calls. '
          'Please grant these permissions in your device settings.',
        ),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      );
    },
  );
}
