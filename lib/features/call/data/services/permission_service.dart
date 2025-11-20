import 'package:dartz/dartz.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/errors/failures.dart';

/// Service for handling camera and microphone permissions
///
/// This service wraps the permission_handler package and provides
/// methods to request, check, and manage media permissions required
/// for audio and video calls.
class PermissionService {
  /// Requests camera permission from the user
  ///
  /// Returns Either<Failure, bool> where:
  /// - Right(true): Permission granted
  /// - Right(false): Permission denied
  /// - Left(Failure): Error occurred during permission request
  Future<Either<Failure, bool>> requestCameraPermission() async {
    try {
      final status = await Permission.camera.request();

      if (status.isGranted) {
        return const Right(true);
      } else if (status.isDenied || status.isPermanentlyDenied) {
        return const Right(false);
      } else {
        return Left(Failure.permission(message: 'Camera permission request returned unexpected status: $status'));
      }
    } catch (e) {
      return Left(Failure.permission(message: 'Failed to request camera permission: ${e.toString()}'));
    }
  }

  /// Requests microphone permission from the user
  ///
  /// Returns Either<Failure, bool> where:
  /// - Right(true): Permission granted
  /// - Right(false): Permission denied
  /// - Left(Failure): Error occurred during permission request
  Future<Either<Failure, bool>> requestMicrophonePermission() async {
    try {
      final status = await Permission.microphone.request();

      if (status.isGranted) {
        return const Right(true);
      } else if (status.isDenied || status.isPermanentlyDenied) {
        return const Right(false);
      } else {
        return Left(Failure.permission(message: 'Microphone permission request returned unexpected status: $status'));
      }
    } catch (e) {
      return Left(Failure.permission(message: 'Failed to request microphone permission: ${e.toString()}'));
    }
  }

  /// Checks if camera permission is currently granted
  ///
  /// Returns true if permission is granted, false otherwise
  Future<bool> checkCameraPermission() async {
    try {
      final status = await Permission.camera.status;
      return status.isGranted;
    } catch (e) {
      // If we can't check the permission, assume it's not granted
      return false;
    }
  }

  /// Checks if microphone permission is currently granted
  ///
  /// Returns true if permission is granted, false otherwise
  Future<bool> checkMicrophonePermission() async {
    try {
      final status = await Permission.microphone.status;
      return status.isGranted;
    } catch (e) {
      // If we can't check the permission, assume it's not granted
      return false;
    }
  }

  /// Opens the app settings page where users can manually grant permissions
  ///
  /// This is useful when permissions are permanently denied and the user
  /// needs to manually enable them in system settings.
  Future<void> openAppSettings() async {
    await openAppSettings();
  }
}
