import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/scheduled_message.dart';
import '../repositories/scheduled_message_repository.dart';

/// UseCase for scheduling a message
class ScheduleMessageUseCase {
  final ScheduledMessageRepository _repository;

  ScheduleMessageUseCase(this._repository);

  /// Execute the use case
  ///
  /// **Parameters:**
  /// - [conversationId]: ID of the conversation
  /// - [content]: Message content
  /// - [type]: Message type (TEXT, IMAGE, etc.)
  /// - [scheduledTime]: When to send the message
  /// - [mediaUrl]: Optional media URL
  /// - [thumbnailUrl]: Optional thumbnail URL
  /// - [fileName]: Optional file name
  /// - [fileSize]: Optional file size
  /// - [duration]: Optional duration for audio/video
  /// - [replyToMessageId]: Optional message ID to reply to
  ///
  /// **Returns:**
  /// - Right(ScheduledMessage): Success
  /// - Left(Failure): Error occurred
  Future<Either<Failure, ScheduledMessage>> call({
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
    // Validation: scheduled time must be in the future
    if (scheduledTime.isBefore(DateTime.now())) {
      return left(
        const Failure.validation(message: 'Thời gian hẹn phải trong tương lai', code: 'INVALID_SCHEDULED_TIME'),
      );
    }

    // Validation: scheduled time must be within 1 year
    final oneYearFromNow = DateTime.now().add(const Duration(days: 365));
    if (scheduledTime.isAfter(oneYearFromNow)) {
      return left(
        const Failure.validation(message: 'Thời gian hẹn không được quá 1 năm', code: 'SCHEDULED_TIME_TOO_FAR'),
      );
    }

    // Validation: content cannot be empty
    if (content.trim().isEmpty) {
      return left(const Failure.validation(message: 'Nội dung tin nhắn không được để trống', code: 'EMPTY_CONTENT'));
    }

    return await _repository.scheduleMessage(
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
  }
}
