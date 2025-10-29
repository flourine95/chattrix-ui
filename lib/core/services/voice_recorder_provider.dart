import 'package:chattrix_ui/core/services/voice_recorder_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'voice_recorder_provider.g.dart';

@riverpod
VoiceRecorderService voiceRecorderService(Ref ref) {
  final service = VoiceRecorderService();
  ref.onDispose(() => service.dispose());
  return service;
}

