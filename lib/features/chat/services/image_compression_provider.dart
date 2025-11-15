import 'package:chattrix_ui/features/chat/services/image_compression_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_compression_provider.g.dart';

@riverpod
ImageCompressionService imageCompressionService(Ref ref) {
  return ImageCompressionService();
}

