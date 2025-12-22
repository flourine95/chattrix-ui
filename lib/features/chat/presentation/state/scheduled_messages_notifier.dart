import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/scheduled_message.dart';
import '../../domain/usecases/cancel_scheduled_message_usecase.dart';
import '../../domain/usecases/get_scheduled_messages_usecase.dart';
import '../../domain/usecases/schedule_message_usecase.dart';
import '../../domain/usecases/update_scheduled_message_usecase.dart';
import '../providers/scheduled_message_providers.dart';

part 'scheduled_messages_notifier.g.dart';

/// Notifier for scheduled messages list
///
/// Manages the state of scheduled messages with filtering by status
@Riverpod(keepAlive: true)
class ScheduledMessagesNotifier extends _$ScheduledMessagesNotifier {
  late final GetScheduledMessagesUseCase _getScheduledMessagesUseCase;
  late final ScheduleMessageUseCase _scheduleMessageUseCase;
  late final UpdateScheduledMessageUseCase _updateScheduledMessageUseCase;
  late final CancelScheduledMessageUseCase _cancelScheduledMessageUseCase;

  @override
  Future<List<ScheduledMessage>> build({int? conversationId, String status = 'PENDING'}) async {
    debugPrint('🟢 ScheduledMessagesNotifier: build() called with status=$status, conversationId=$conversationId');

    try {
      _getScheduledMessagesUseCase = ref.read(getScheduledMessagesUseCaseProvider);
      _scheduleMessageUseCase = ref.read(scheduleMessageUseCaseProvider);
      _updateScheduledMessageUseCase = ref.read(updateScheduledMessageUseCaseProvider);
      _cancelScheduledMessageUseCase = ref.read(cancelScheduledMessageUseCaseProvider);

      debugPrint('🟢 ScheduledMessagesNotifier: All usecases initialized successfully');
    } catch (e) {
      debugPrint('🔴 ScheduledMessagesNotifier: Failed to initialize usecases: $e');
      rethrow;
    }

    return _loadScheduledMessages(conversationId: conversationId, status: status);
  }

  /// Load scheduled messages from API
  Future<List<ScheduledMessage>> _loadScheduledMessages({
    int? conversationId,
    String status = 'PENDING',
    int page = 0,
    int size = 20,
  }) async {
    debugPrint('🟡 Notifier: Loading scheduled messages with status=$status, conversationId=$conversationId');

    try {
      final result = await _getScheduledMessagesUseCase(
        conversationId: conversationId,
        status: status,
        page: page,
        size: size,
      );

      return result.fold(
        (failure) {
          debugPrint('🔴 Notifier: Failed to load messages: ${failure.userMessage}');
          throw Exception(failure.userMessage);
        },
        (messages) {
          debugPrint('🟡 Notifier: Successfully loaded ${messages.length} messages');
          return messages;
        },
      );
    } catch (e) {
      debugPrint('🔴 Notifier: Exception in _loadScheduledMessages: $e');
      rethrow;
    }
  }

  /// Schedule a new message
  Future<void> scheduleMessage({
    required int conversationId,
    required String content,
    required String type,
    required DateTime scheduledTime,
    String? mediaUrl,
    String? thumbnailUrl,
    String? fileName,
    int? fileSize,
    int? duration,
    int? replyToMessageId,
  }) async {
    final result = await _scheduleMessageUseCase(
      conversationId: conversationId,
      content: content,
      type: type,
      scheduledTime: scheduledTime,
      mediaUrl: mediaUrl,
      thumbnailUrl: thumbnailUrl,
      fileName: fileName,
      fileSize: fileSize,
      duration: duration,
      replyToMessageId: replyToMessageId,
    );

    result.fold((failure) => throw Exception(failure.userMessage), (scheduledMessage) {
      // Add to current list if status matches (scheduledStatus field)
      if (scheduledMessage.scheduledStatus == status) {
        state.whenData((messages) {
          state = AsyncValue.data([scheduledMessage, ...messages]);
        });
      }
    });
  }

  /// Update a scheduled message
  Future<void> updateScheduledMessage({
    required int scheduledMessageId,
    String? content,
    DateTime? scheduledTime,
    String? mediaUrl,
    String? thumbnailUrl,
    String? fileName,
  }) async {
    final result = await _updateScheduledMessageUseCase(
      scheduledMessageId: scheduledMessageId,
      content: content,
      scheduledTime: scheduledTime,
      mediaUrl: mediaUrl,
      thumbnailUrl: thumbnailUrl,
      fileName: fileName,
    );

    result.fold((failure) => throw Exception(failure.userMessage), (updatedMessage) {
      // Update in current list
      state.whenData((messages) {
        final updatedList = messages.map((msg) {
          return msg.id == scheduledMessageId ? updatedMessage : msg;
        }).toList();
        state = AsyncValue.data(updatedList);
      });
    });
  }

  /// Cancel a scheduled message
  Future<void> cancelScheduledMessage({required int scheduledMessageId}) async {
    final result = await _cancelScheduledMessageUseCase(scheduledMessageId: scheduledMessageId);

    result.fold((failure) => throw Exception((failure as Failure?)?.userMessage ?? 'Unknown error'), (_) {
      // Remove from current list
      state.whenData((messages) {
        final updatedList = messages.where((msg) => msg.id != scheduledMessageId).toList();
        state = AsyncValue.data(updatedList);
      });
    });
  }

  /// Refresh the list
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadScheduledMessages(conversationId: conversationId, status: status));
  }

  /// Handle WebSocket event: scheduled message sent
  void onScheduledMessageSent(int scheduledMessageId) {
    // Remove from PENDING list
    if (status == 'PENDING') {
      state.whenData((messages) {
        final updatedList = messages.where((msg) => msg.id != scheduledMessageId).toList();
        state = AsyncValue.data(updatedList);
      });
    }
  }

  /// Handle WebSocket event: scheduled message failed
  void onScheduledMessageFailed(int scheduledMessageId, String failedReason) {
    // Remove from PENDING list
    if (status == 'PENDING') {
      state.whenData((messages) {
        final updatedList = messages.where((msg) => msg.id != scheduledMessageId).toList();
        state = AsyncValue.data(updatedList);
      });
    }
  }
}
