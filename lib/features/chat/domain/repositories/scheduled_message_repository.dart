import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/scheduled_message.dart';

/// Repository interface for scheduled messages
abstract class ScheduledMessageRepository {
  /// Schedule a message to be sent at a future time
  ///
  /// Returns [Right] with [ScheduledMessage] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, ScheduledMessage>> scheduleMessage({
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
  });

  /// Get list of scheduled messages
  ///
  /// Returns [Right] with list of [ScheduledMessage] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<ScheduledMessage>>> getScheduledMessages({
    int? conversationId,
    String status = 'PENDING',
    int page = 0,
    int size = 20,
  });

  /// Get single scheduled message by ID
  ///
  /// Returns [Right] with [ScheduledMessage] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, ScheduledMessage>> getScheduledMessage({
    required int conversationId,
    required int scheduledMessageId,
  });

  /// Update scheduled message
  ///
  /// Returns [Right] with updated [ScheduledMessage] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, ScheduledMessage>> updateScheduledMessage({
    required int conversationId,
    required int scheduledMessageId,
    String? content,
    DateTime? scheduledTime,
    String? mediaUrl,
    String? thumbnailUrl,
    String? fileName,
  });

  /// Cancel scheduled message
  ///
  /// Returns [Right] with void on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, void>> cancelScheduledMessage({required int conversationId, required int scheduledMessageId});

  /// Bulk cancel scheduled messages
  ///
  /// Returns [Right] with count of cancelled messages on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, int>> bulkCancelScheduledMessages({
    required int conversationId,
    required List<int> scheduledMessageIds,
  });
}
