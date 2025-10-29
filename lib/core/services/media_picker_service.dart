import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

/// Service for picking media files (images, videos, audio, documents)
/// and getting location
class MediaPickerService {
  final ImagePicker _imagePicker = ImagePicker();

  /// Pick an image from gallery
  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      
      if (image != null) {
        debugPrint('📷 Image picked from gallery: ${image.path}');
        return File(image.path);
      }
      return null;
    } catch (e) {
      debugPrint('❌ Failed to pick image from gallery: $e');
      rethrow;
    }
  }

  /// Take a photo with camera
  Future<File?> takePhoto() async {
    try {
      // Request camera permission
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        debugPrint('❌ Camera permission denied');
        return null;
      }

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      
      if (image != null) {
        debugPrint('📷 Photo taken: ${image.path}');
        return File(image.path);
      }
      return null;
    } catch (e) {
      debugPrint('❌ Failed to take photo: $e');
      rethrow;
    }
  }

  /// Pick a video from gallery
  Future<File?> pickVideoFromGallery() async {
    try {
      final XFile? video = await _imagePicker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 5),
      );
      
      if (video != null) {
        debugPrint('🎥 Video picked from gallery: ${video.path}');
        return File(video.path);
      }
      return null;
    } catch (e) {
      debugPrint('❌ Failed to pick video from gallery: $e');
      rethrow;
    }
  }

  /// Record a video with camera
  Future<File?> recordVideo() async {
    try {
      // Request camera permission
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        debugPrint('❌ Camera permission denied');
        return null;
      }

      final XFile? video = await _imagePicker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(minutes: 5),
      );
      
      if (video != null) {
        debugPrint('🎥 Video recorded: ${video.path}');
        return File(video.path);
      }
      return null;
    } catch (e) {
      debugPrint('❌ Failed to record video: $e');
      rethrow;
    }
  }

  /// Pick an audio file
  Future<File?> pickAudioFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
      );
      
      if (result != null && result.files.isNotEmpty) {
        final path = result.files.first.path;
        if (path != null) {
          debugPrint('🎵 Audio file picked: $path');
          return File(path);
        }
      }
      return null;
    } catch (e) {
      debugPrint('❌ Failed to pick audio file: $e');
      rethrow;
    }
  }

  /// Pick a document file (PDF, DOCX, etc.)
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
          debugPrint('📄 Document picked: $path (${file.name})');
          return PickedFile(
            file: File(path),
            name: file.name,
            size: file.size,
            extension: file.extension,
          );
        }
      }
      return null;
    } catch (e) {
      debugPrint('❌ Failed to pick document: $e');
      rethrow;
    }
  }

  /// Get current location
  Future<LocationData?> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint('❌ Location services are disabled');
        return null;
      }

      // Request location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('❌ Location permission denied');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        debugPrint('❌ Location permission denied forever');
        return null;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      debugPrint('📍 Location obtained: ${position.latitude}, ${position.longitude}');
      return LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      debugPrint('❌ Failed to get location: $e');
      rethrow;
    }
  }
}

/// Represents a picked file with metadata
class PickedFile {
  final File file;
  final String name;
  final int size;
  final String? extension;

  PickedFile({
    required this.file,
    required this.name,
    required this.size,
    this.extension,
  });
}

/// Represents location data
class LocationData {
  final double latitude;
  final double longitude;

  LocationData({
    required this.latitude,
    required this.longitude,
  });
}

