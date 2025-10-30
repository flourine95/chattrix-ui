import 'package:chattrix_ui/core/services/cloudinary_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cloudinaryServiceProvider = Provider<CloudinaryService>((ref) {
  return CloudinaryService();
});

