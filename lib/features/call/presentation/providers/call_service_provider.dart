import 'package:chattrix_ui/features/call/services/agora_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final agoraServiceProvider = Provider<AgoraService>((ref) {
  final service = AgoraService();
  ref.onDispose(() {
    service.dispose();
  });
  return service;
});
