import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class ImageCompressionService {
  Future<File> compressImage(
    File file, {
    int quality = 85,
    int maxWidth = 1920,
    int maxHeight = 1920,
  }) async {
    try {
      final originalSize = await file.length();

      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final targetPath = '${tempDir.path}/compressed_$timestamp.jpg';

      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: quality,
        minWidth: maxWidth,
        minHeight: maxHeight,
        format: CompressFormat.jpeg,
      );

      if (result == null) {
        return file;
      }

      final compressedFile = File(result.path);
      final compressedSize = await compressedFile.length();

      if (compressedSize >= originalSize) {
        await compressedFile.delete();
        return file;
      }

      return compressedFile;
    } catch (e) {
      return file;
    }
  }

  Future<List<File>> compressImages(
    List<File> files, {
    int quality = 85,
    int maxWidth = 1920,
    int maxHeight = 1920,
  }) async {
    final compressed = <File>[];

    for (final file in files) {
      final result = await compressImage(
        file,
        quality: quality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
      );
      compressed.add(result);
    }

    return compressed;
  }

  Future<ImageDimensions?> getImageDimensions(File file) async {
    try {
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> needsCompression(
    File file, {
    int maxSizeBytes = 5 * 1024 * 1024,
    int maxWidth = 1920,
    int maxHeight = 1920,
  }) async {
    try {
      final size = await file.length();
      if (size > maxSizeBytes) {
        return true;
      }

      final dimensions = await getImageDimensions(file);
      if (dimensions != null) {
        if (dimensions.width > maxWidth || dimensions.height > maxHeight) {
          return true;
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<File> compressToTargetSize(
    File file, {
    int targetSizeBytes = 1 * 1024 * 1024,
    int maxWidth = 1920,
    int maxHeight = 1920,
  }) async {
    try {
      final originalSize = await file.length();

      if (originalSize <= targetSizeBytes) {
        return file;
      }

      final qualities = [85, 75, 65, 55, 45];

      for (final quality in qualities) {
        final compressed = await compressImage(
          file,
          quality: quality,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
        );

        final size = await compressed.length();

        if (size <= targetSizeBytes) {
          return compressed;
        }
      }

      return await compressImage(
        file,
        quality: 45,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
      );
    } catch (e) {
      return file;
    }
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
  }
}

class ImageDimensions {
  final int width;
  final int height;

  const ImageDimensions({required this.width, required this.height});

  double get aspectRatio => width / height;

  @override
  String toString() => '${width}x$height';
}
