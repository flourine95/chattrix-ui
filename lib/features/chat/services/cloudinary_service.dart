import 'dart:io';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CloudinaryService {
  late final CloudinaryPublic _cloudinary;

  CloudinaryService() {
    final cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'];
    final uploadPreset = dotenv.env['CLOUDINARY_UPLOAD_PRESET'];

    if (cloudName == null || uploadPreset == null) {
      throw Exception('Missing Cloudinary env vars. Check your .env file.');
    }

    _cloudinary = CloudinaryPublic(cloudName, uploadPreset, cache: false);
  }

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

      return CloudinaryUploadResult(
        url: response.secureUrl,
        publicId: response.publicId,
        format: response.data['format'],
        width: response.data['width'],
        height: response.data['height'],
        bytes: response.data['bytes'],
      );
    } catch (e) {
      AppLogger.error('Failed to upload image', error: e, tag: 'Cloudinary');
      rethrow;
    }
  }

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

      final thumbnailUrl = response.secureUrl.replaceAll('.mp4', '.jpg');

      return CloudinaryUploadResult(
        url: response.secureUrl,
        thumbnailUrl: thumbnailUrl,
        publicId: response.publicId,
        format: response.data['format'],
        duration: (response.data['duration'] as num?)?.toDouble(),
        bytes: response.data['bytes'],
      );
    } catch (e) {
      AppLogger.error('Failed to upload video', error: e, tag: 'Cloudinary');
      rethrow;
    }
  }

  Future<CloudinaryUploadResult> uploadAudio(File file, {String? fileName}) async {
    try {
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          resourceType: CloudinaryResourceType.Video, // Cloudinary uses "video" for audio
          folder: 'chattrix/audio',
          publicId: fileName,
        ),
      );

      return CloudinaryUploadResult(
        url: response.secureUrl,
        publicId: response.publicId,
        format: response.data['format'],
        duration: (response.data['duration'] as num?)?.toDouble(),
        bytes: response.data['bytes'],
      );
    } catch (e) {
      AppLogger.error('Failed to upload audio', error: e, tag: 'Cloudinary');
      rethrow;
    }
  }

  Future<CloudinaryUploadResult> uploadDocument(File file, {String? fileName}) async {
    try {
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          resourceType: CloudinaryResourceType.Raw,
          folder: 'chattrix/documents',
          publicId: fileName,
        ),
      );

      return CloudinaryUploadResult(
        url: response.secureUrl,
        publicId: response.publicId,
        format: response.data['format'],
        bytes: response.data['bytes'],
      );
    } catch (e) {
      AppLogger.error('Failed to upload document', error: e, tag: 'Cloudinary');
      rethrow;
    }
  }

  Future<void> deleteFile(String publicId, CloudinaryResourceType resourceType) async {
    throw UnimplementedError('File deletion requires API secret. Implement this in your backend.');
  }
}

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
