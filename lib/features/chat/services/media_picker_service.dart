import 'dart:io';

import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class MediaPickerService {
  /// Pick a single image from gallery using WeChat-style picker
  Future<File?> pickImageFromGallery(BuildContext context) async {
    try {
      final List<AssetEntity>? assets = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          maxAssets: 1,
          requestType: RequestType.image,
          specialPickerType: SpecialPickerType.noPreview,
        ),
      );

      if (assets != null && assets.isNotEmpty) {
        final file = await assets.first.file;
        if (file != null) {
          return file;
        }
      }
      return null;
    } catch (e) {
      AppLogger.error('pickImageFromGallery error', error: e, tag: 'MediaPicker');
      rethrow;
    }
  }

  /// Pick multiple images from gallery using WeChat-style picker (up to 9)
  Future<List<File>> pickMultipleImagesFromGallery(BuildContext context) async {
    try {
      final List<AssetEntity>? assets = await AssetPicker.pickAssets(
        context,
        pickerConfig: const AssetPickerConfig(maxAssets: 9, requestType: RequestType.image),
      );

      if (assets != null && assets.isNotEmpty) {
        final List<File> files = [];
        for (final asset in assets) {
          final file = await asset.file;
          if (file != null) {
            files.add(file);
          }
        }
        return files;
      }
      return [];
    } catch (e) {
      AppLogger.error('pickMultipleImagesFromGallery error', error: e, tag: 'MediaPicker');
      rethrow;
    }
  }

  /// Take a photo using WeChat-style camera picker
  Future<File?> takePhoto(BuildContext context) async {
    try {
      final status = await Permission.camera.request();

      if (!context.mounted) return null;

      if (!status.isGranted) {
        AppLogger.warning('Camera permission denied', tag: 'MediaPicker');
        return null;
      }

      final AssetEntity? asset = await CameraPicker.pickFromCamera(
        context,
        pickerConfig: const CameraPickerConfig(enableRecording: false, maximumRecordingDuration: Duration(seconds: 15)),
      );

      if (asset != null) {
        final file = await asset.file;
        if (file != null) {
          return file;
        }
      }
      return null;
    } catch (e) {
      AppLogger.error('takePhoto error', error: e, tag: 'MediaPicker');
      rethrow;
    }
  }

  /// Pick a video from gallery using WeChat-style picker
  Future<File?> pickVideoFromGallery(BuildContext context) async {
    try {
      final List<AssetEntity>? assets = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          maxAssets: 1,
          requestType: RequestType.video,
          specialPickerType: SpecialPickerType.noPreview,
        ),
      );

      if (assets != null && assets.isNotEmpty) {
        final asset = assets.first;

        // Check video duration (max 5 minutes)
        final duration = asset.duration;
        if (duration > 300) {
          // 300 seconds = 5 minutes
          AppLogger.warning('Video duration exceeds 5 minutes', tag: 'MediaPicker');
          throw Exception('Video duration must not exceed 5 minutes');
        }

        final file = await asset.file;
        if (file != null) {
          return file;
        }
      }
      return null;
    } catch (e) {
      AppLogger.error('pickVideoFromGallery error', error: e, tag: 'MediaPicker');
      rethrow;
    }
  }

  /// Record a video using WeChat-style camera picker
  Future<File?> recordVideo(BuildContext context) async {
    try {
      final status = await Permission.camera.request();

      if (!context.mounted) return null;

      if (!status.isGranted) {
        AppLogger.warning('Camera permission denied', tag: 'MediaPicker');
        return null;
      }

      final AssetEntity? asset = await CameraPicker.pickFromCamera(
        context,
        pickerConfig: const CameraPickerConfig(
          enableRecording: true,
          onlyEnableRecording: true,
          maximumRecordingDuration: Duration(minutes: 5),
        ),
      );

      if (asset != null) {
        final file = await asset.file;
        if (file != null) {
          return file;
        }
      }
      return null;
    } catch (e) {
      AppLogger.error('recordVideo error', error: e, tag: 'MediaPicker');
      rethrow;
    }
  }

  Future<File?> pickAudioFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.audio, allowMultiple: false);

      if (result != null && result.files.isNotEmpty) {
        final path = result.files.first.path;
        if (path != null) {
          return File(path);
        }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<PickedFile?> pickDocument() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        final path = file.path;
        if (path != null) {
          AppLogger.debug('Document picked: $path (${file.name})', tag: 'MediaPicker');
          return PickedFile(file: File(path), name: file.name, size: file.size, extension: file.extension);
        }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<LocationData?> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );

      return LocationData(latitude: position.latitude, longitude: position.longitude);
    } catch (e) {
      rethrow;
    }
  }
}

class PickedFile {
  final File file;
  final String name;
  final int size;
  final String? extension;

  PickedFile({required this.file, required this.name, required this.size, this.extension});
}

class LocationData {
  final double latitude;
  final double longitude;

  LocationData({required this.latitude, required this.longitude});
}
