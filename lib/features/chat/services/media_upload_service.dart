import 'dart:io';

import 'package:chattrix_ui/features/chat/services/cloudinary_service.dart';
import 'package:flutter/foundation.dart';
import 'package:photo_manager/photo_manager.dart';

/// Service to handle media uploads
/// Centralizes all upload logic to avoid duplication
class MediaUploadService {
  final CloudinaryService _cloudinary;

  MediaUploadService(this._cloudinary);

  /// Upload image file
  Future<String> uploadImage(File file) async {
    debugPrint('☁️ [MediaUpload] Uploading image...');
    final response = await _cloudinary.uploadImage(file);
    debugPrint('☁️ [MediaUpload] Image uploaded: ${response.url}');
    return response.url;
  }

  /// Upload video file
  Future<String> uploadVideo(File file) async {
    debugPrint('☁️ [MediaUpload] Uploading video...');
    final response = await _cloudinary.uploadVideo(file);
    debugPrint('☁️ [MediaUpload] Video uploaded: ${response.url}');
    return response.url;
  }

  /// Upload audio file
  Future<String> uploadAudio(File file) async {
    debugPrint('☁️ [MediaUpload] Uploading audio...');
    final response = await _cloudinary.uploadAudio(file);
    debugPrint('☁️ [MediaUpload] Audio uploaded: ${response.url}');
    return response.url;
  }

  /// Upload document file
  Future<String> uploadDocument(File file, {String? fileName}) async {
    debugPrint('☁️ [MediaUpload] Uploading document...');
    final response = await _cloudinary.uploadDocument(file, fileName: fileName);
    debugPrint('☁️ [MediaUpload] Document uploaded: ${response.url}');
    return response.url;
  }

  /// Upload asset from gallery (handles both image and video)
  Future<MediaUploadResult> uploadAsset(AssetEntity asset) async {
    final file = await asset.file;
    if (file == null) {
      throw Exception('Failed to get file from asset');
    }

    final isVideo = asset.type == AssetType.video;
    final url = isVideo ? await uploadVideo(file) : await uploadImage(file);

    return MediaUploadResult(
      url: url,
      type: isVideo ? 'VIDEO' : 'IMAGE',
      duration: isVideo ? asset.duration : null,
    );
  }

  /// Upload multiple assets from gallery
  Future<List<MediaUploadResult>> uploadAssets(List<AssetEntity> assets) async {
    final results = <MediaUploadResult>[];

    for (final asset in assets) {
      try {
        final result = await uploadAsset(asset);
        results.add(result);
      } catch (e) {
        debugPrint('❌ [MediaUpload] Failed to upload asset: $e');
        // Continue with other assets
      }
    }

    return results;
  }
}

/// Result of media upload
class MediaUploadResult {
  final String url;
  final String type;
  final int? duration;

  MediaUploadResult({
    required this.url,
    required this.type,
    this.duration,
  });
}
