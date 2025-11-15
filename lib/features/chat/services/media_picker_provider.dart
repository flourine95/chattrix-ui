import 'package:chattrix_ui/features/chat/services/media_picker_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mediaPickerServiceProvider = Provider<MediaPickerService>((ref) {
  return MediaPickerService();
});
