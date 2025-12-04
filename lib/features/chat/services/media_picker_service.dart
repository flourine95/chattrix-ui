import 'dart:io';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MediaPickerService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<File>> pickMultipleImagesFromGallery() async {
    try {
      final List<XFile> images = await _imagePicker.pickMultiImage(maxWidth: 1920, maxHeight: 1920, imageQuality: 85);

      if (images.isNotEmpty) {
        return images.map((image) => File(image.path)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<File?> takePhoto() async {
    try {
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        return null;
      }

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<File?> pickVideoFromGallery() async {
    try {
      final XFile? video = await _imagePicker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 5),
      );

      if (video != null) {
        return File(video.path);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<File?> recordVideo() async {
    try {
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        return null;
      }

      final XFile? video = await _imagePicker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(minutes: 5),
      );

      if (video != null) {
        return File(video.path);
      }
      return null;
    } catch (e) {
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
