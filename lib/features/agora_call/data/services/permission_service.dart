import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../domain/entities/call_entity.dart';

/// Service for managing call-related permissions
///
/// Handles requesting and checking microphone and camera permissions
/// required for audio and video calls
class PermissionService {
  /// Requests the necessary permissions for a call based on call type
  ///
  /// For audio calls: requests microphone permission
  /// For video calls: requests both microphone and camera permissions
  ///
  /// Returns true if all required permissions are granted, false otherwise
  ///
  /// [callType] - The type of call (audio or video)
  Future<bool> requestCallPermissions(CallType callType) async {
    try {
      debugPrint('PermissionService: Requesting permissions for ${callType.name} call');

      // Determine which permissions are needed based on call type
      final permissions = <Permission>[Permission.microphone];

      if (callType == CallType.video) {
        permissions.add(Permission.camera);
      }

      // Request all required permissions
      final statuses = await permissions.request();

      // Check if all permissions are granted
      final allGranted = statuses.values.every((status) => status.isGranted);

      if (allGranted) {
        debugPrint('PermissionService: All permissions granted');
      } else {
        debugPrint('PermissionService: Some permissions denied');
        _logPermissionStatuses(statuses);
      }

      return allGranted;
    } catch (e) {
      debugPrint('PermissionService: Error requesting permissions: $e');
      return false;
    }
  }

  /// Checks if the required permissions are already granted
  ///
  /// Returns true if all required permissions are granted, false otherwise
  ///
  /// [callType] - The type of call (audio or video)
  Future<bool> hasCallPermissions(CallType callType) async {
    try {
      final micStatus = await Permission.microphone.status;

      if (callType == CallType.audio) {
        return micStatus.isGranted;
      }

      // For video calls, check both microphone and camera
      final cameraStatus = await Permission.camera.status;
      return micStatus.isGranted && cameraStatus.isGranted;
    } catch (e) {
      debugPrint('PermissionService: Error checking permissions: $e');
      return false;
    }
  }

  /// Checks if we should show permission rationale
  ///
  /// Returns true if the user has previously denied the permission
  /// and we should explain why we need it
  ///
  /// [callType] - The type of call (audio or video)
  Future<bool> shouldShowRationale(CallType callType) async {
    try {
      final micShouldShow = await Permission.microphone.shouldShowRequestRationale;

      if (callType == CallType.audio) {
        return micShouldShow;
      }

      // For video calls, check both permissions
      final cameraShouldShow = await Permission.camera.shouldShowRequestRationale;
      return micShouldShow || cameraShouldShow;
    } catch (e) {
      debugPrint('PermissionService: Error checking rationale: $e');
      return false;
    }
  }

  /// Checks if permissions are permanently denied
  ///
  /// Returns true if any required permission is permanently denied
  /// In this case, the user needs to go to app settings to grant permission
  ///
  /// [callType] - The type of call (audio or video)
  Future<bool> arePermissionsPermanentlyDenied(CallType callType) async {
    try {
      final micStatus = await Permission.microphone.status;

      if (callType == CallType.audio) {
        return micStatus.isPermanentlyDenied;
      }

      // For video calls, check both permissions
      final cameraStatus = await Permission.camera.status;
      return micStatus.isPermanentlyDenied || cameraStatus.isPermanentlyDenied;
    } catch (e) {
      debugPrint('PermissionService: Error checking permanent denial: $e');
      return false;
    }
  }

  /// Opens the app settings page where user can manually grant permissions
  Future<bool> openSettings() async {
    try {
      debugPrint('PermissionService: Opening app settings');
      return await openAppSettings();
    } catch (e) {
      debugPrint('PermissionService: Error opening app settings: $e');
      return false;
    }
  }

  /// Logs the status of each permission for debugging
  void _logPermissionStatuses(Map<Permission, PermissionStatus> statuses) {
    statuses.forEach((permission, status) {
      debugPrint('PermissionService: ${permission.toString()} - ${status.toString()}');
    });
  }
}
