import 'package:chattrix_ui/features/chat/services/cloudinary_service.dart';
import 'package:chattrix_ui/features/chat/services/media_upload_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cloudinaryServiceProvider = Provider<CloudinaryService>((ref) {
  return CloudinaryService();
});

final mediaUploadServiceProvider = Provider<MediaUploadService>((ref) {
  return MediaUploadService(ref.watch(cloudinaryServiceProvider));
});
