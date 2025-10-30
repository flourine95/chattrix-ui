import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart';

/// Service for uploading media files to Cloudinary
/// Handles images, videos, audio, and documents
class CloudinaryService {
  late final CloudinaryPublic _cloudinary;
  
  // TODO: Replace with your Cloudinary credentials
  static const String _cloudName = 'dk3gud5kq';
  static const String _uploadPreset = 'chattrix_media';
  
  CloudinaryService() {
    _cloudinary = CloudinaryPublic(_cloudName, _uploadPreset, cache: false);
  }

  /// Upload an image file to Cloudinary
  /// Returns the secure URL of the uploaded image
  Future<CloudinaryUploadResult> uploadImage(File file, {String? fileName}) async {
    try {

      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          resourceType: CloudinaryResourceType.Image,
          folder: 'chattrix/images',
          publicId: fileName,
        ),
      );

      // Extract data from response.data map
      final format = response.data['format'] as String?;
      final width = response.data['width'] as int?;
      final height = response.data['height'] as int?;
      final bytes = response.data['bytes'] as int?;

      return CloudinaryUploadResult(
        url: response.secureUrl,
        publicId: response.publicId,
        format: format,
        width: width,
        height: height,
        bytes: bytes,
      );
    } catch (e) {
      debugPrint('❌ Failed to upload image: $e');
      rethrow;
    }
  }

  /// Upload a video file to Cloudinary
  /// Returns the secure URL and thumbnail URL
  Future<CloudinaryUploadResult> uploadVideo(File file, {String? fileName}) async {
    try {

      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          resourceType: CloudinaryResourceType.Video,
          folder: 'chattrix/videos',
          publicId: fileName,
        ),
      );

      // Generate thumbnail URL (Cloudinary auto-generates thumbnails for videos)
      final thumbnailUrl = response.secureUrl.replaceAll('.mp4', '.jpg');

      // Extract data from response.data map
      final format = response.data['format'] as String?;
      final duration = response.data['duration'] as num?;
      final bytes = response.data['bytes'] as int?;

      return CloudinaryUploadResult(
        url: response.secureUrl,
        thumbnailUrl: thumbnailUrl,
        publicId: response.publicId,
        format: format,
        duration: duration?.toDouble(),
        bytes: bytes,
      );
    } catch (e) {
      debugPrint('❌ Failed to upload video: $e');
      rethrow;
    }
  }

  /// Upload an audio file to Cloudinary
  /// Returns the secure URL
  Future<CloudinaryUploadResult> uploadAudio(File file, {String? fileName}) async {
    try {

      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          resourceType: CloudinaryResourceType.Video, // Audio uses video resource type
          folder: 'chattrix/audio',
          publicId: fileName,
        ),
      );

      // Extract data from response.data map
      final format = response.data['format'] as String?;
      final duration = response.data['duration'] as num?;
      final bytes = response.data['bytes'] as int?;

      return CloudinaryUploadResult(
        url: response.secureUrl,
        publicId: response.publicId,
        format: format,
        duration: duration?.toDouble(),
        bytes: bytes,
      );
    } catch (e) {
      debugPrint('❌ Failed to upload audio: $e');
      rethrow;
    }
  }

  /// Upload a document file to Cloudinary
  /// Returns the secure URL
  Future<CloudinaryUploadResult> uploadDocument(File file, {String? fileName}) async {
    try {

      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          resourceType: CloudinaryResourceType.Raw, // Raw for documents
          folder: 'chattrix/documents',
          publicId: fileName,
        ),
      );

      // Extract data from response.data map
      final format = response.data['format'] as String?;
      final bytes = response.data['bytes'] as int?;

      return CloudinaryUploadResult(
        url: response.secureUrl,
        publicId: response.publicId,
        format: format,
        bytes: bytes,
      );
    } catch (e) {
      debugPrint('❌ Failed to upload document: $e');
      rethrow;
    }
  }

  /// Delete a file from Cloudinary by public ID
  /// Note: This requires API secret and should be done on backend
  /// The cloudinary_public package doesn't support deletion (unsigned uploads only)
  Future<void> deleteFile(String publicId, CloudinaryResourceType resourceType) async {
    throw UnimplementedError(
      'File deletion requires API secret and should be implemented on backend. '
      'Use your backend API to delete files from Cloudinary.'
    );
  }
}

/// Result of a Cloudinary upload operation
class CloudinaryUploadResult {
  final String url;
  final String? thumbnailUrl;
  final String publicId;
  final String? format;
  final int? width;
  final int? height;
  final double? duration;
  final int? bytes;

  CloudinaryUploadResult({
    required this.url,
    this.thumbnailUrl,
    required this.publicId,
    this.format,
    this.width,
    this.height,
    this.duration,
    this.bytes,
  });
}

