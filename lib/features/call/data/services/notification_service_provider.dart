import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'notification_service.dart';

part 'notification_service_provider.g.dart';

@riverpod
NotificationService notificationService(Ref ref) {
  final service = NotificationService();
  // Initialize the service
  service.initialize();
  return service;
}
