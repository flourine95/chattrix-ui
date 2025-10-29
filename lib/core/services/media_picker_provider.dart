import 'package:chattrix_ui/core/services/media_picker_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provider for Media Picker service
final mediaPickerServiceProvider = Provider<MediaPickerService>((ref) {
  return MediaPickerService();
});

