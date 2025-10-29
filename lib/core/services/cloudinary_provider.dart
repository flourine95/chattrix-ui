import 'package:chattrix_ui/core/services/cloudinary_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provider for Cloudinary service
final cloudinaryServiceProvider = Provider<CloudinaryService>((ref) {
  return CloudinaryService();
});

