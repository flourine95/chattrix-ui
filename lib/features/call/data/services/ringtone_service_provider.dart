import 'package:chattrix_ui/features/call/data/services/ringtone_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ringtone_service_provider.g.dart';

/// Provider for the ringtone service
@Riverpod(keepAlive: true)
RingtoneService ringtoneService(Ref ref) {
  final service = RingtoneService();

  // Dispose the service when the provider is disposed
  ref.onDispose(() {
    service.dispose();
  });

  return service;
}
