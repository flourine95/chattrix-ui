import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';
import '../../data/datasources/scheduled_message_datasource_impl.dart';
import '../../data/datasources/chat_websocket_datasource_impl.dart';
import '../../data/repositories/scheduled_message_repository_impl.dart';
import '../../domain/datasources/scheduled_message_datasource.dart';
import '../../domain/repositories/scheduled_message_repository.dart';
import '../../domain/usecases/cancel_scheduled_message_usecase.dart';
import '../../domain/usecases/get_scheduled_messages_usecase.dart';
import '../../domain/usecases/schedule_message_usecase.dart';
import '../../domain/usecases/update_scheduled_message_usecase.dart';
import '../../../auth/presentation/providers/auth_repository_provider.dart';
import '../state/scheduled_messages_notifier.dart';
import 'chat_websocket_provider_new.dart';

part 'scheduled_message_providers.g.dart';

// ============================================================================
// Datasource Provider
// ============================================================================

@riverpod
ScheduledMessageDatasource scheduledMessageDatasource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return ScheduledMessageDatasourceImpl(dio);
}

// ============================================================================
// Repository Provider
// ============================================================================

@riverpod
ScheduledMessageRepository scheduledMessageRepository(Ref ref) {
  final datasource = ref.watch(scheduledMessageDatasourceProvider);
  return ScheduledMessageRepositoryImpl(datasource);
}

// ============================================================================
// UseCase Providers
// ============================================================================

@riverpod
ScheduleMessageUseCase scheduleMessageUseCase(Ref ref) {
  final repository = ref.watch(scheduledMessageRepositoryProvider);
  return ScheduleMessageUseCase(repository);
}

@riverpod
GetScheduledMessagesUseCase getScheduledMessagesUseCase(Ref ref) {
  final repository = ref.watch(scheduledMessageRepositoryProvider);
  return GetScheduledMessagesUseCase(repository);
}

@riverpod
UpdateScheduledMessageUseCase updateScheduledMessageUseCase(Ref ref) {
  final repository = ref.watch(scheduledMessageRepositoryProvider);
  return UpdateScheduledMessageUseCase(repository);
}

@riverpod
CancelScheduledMessageUseCase cancelScheduledMessageUseCase(Ref ref) {
  final repository = ref.watch(scheduledMessageRepositoryProvider);
  return CancelScheduledMessageUseCase(repository);
}

// ============================================================================
// WebSocket Event Listener Provider
// ============================================================================

/// Provider to listen to WebSocket events for scheduled messages
///
/// This provider automatically listens to:
/// - scheduled.message.sent: When a scheduled message is successfully sent
/// - scheduled.message.failed: When a scheduled message fails to send
@Riverpod(keepAlive: true)
void scheduledMessageWebSocketListener(Ref ref) {
  // Get WebSocket datasource
  final chatWebSocketDataSource = ref.watch(chatWebSocketDataSourceProvider);

  // Cast to implementation to access scheduled message streams
  if (chatWebSocketDataSource is ChatWebSocketDataSourceImpl) {
    // Listen to scheduled message sent events
    chatWebSocketDataSource.scheduledMessageSentStream.listen((event) {
      debugPrint('📤 Scheduled message sent: ${event.scheduledMessageId}');

      // Invalidate scheduled message providers to refresh all lists
      // This will refresh all tabs (SCHEDULED, SENT, FAILED)
      ref.invalidate(scheduledMessagesProvider);
    });

    // Listen to scheduled message failed events
    chatWebSocketDataSource.scheduledMessageFailedStream.listen((event) {
      debugPrint('❌ Scheduled message failed: ${event.scheduledMessageId} - ${event.failedReason}');

      // Invalidate scheduled message providers to refresh all lists
      ref.invalidate(scheduledMessagesProvider);
    });
  }
}
