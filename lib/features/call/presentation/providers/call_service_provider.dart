import 'package:chattrix_ui/features/call/services/agora_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provider for Agora RTC service
final agoraServiceProvider = Provider<AgoraService>((ref) {
  final service = AgoraService();
  ref.onDispose(() {
    service.dispose();
  });
  return service;
});

// NOTE: CallWebSocketDataSource provider has been moved to:
// lib/features/call/presentation/providers/call_websocket_provider.dart
// Import it from there: callWebSocketDataSourceProvider

