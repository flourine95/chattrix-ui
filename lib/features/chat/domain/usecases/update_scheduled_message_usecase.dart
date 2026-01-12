import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/scheduled_message.dart';
import '../repositories/scheduled_message_repository.dart';

/// UseCase for updating a scheduled message
class UpdateScheduledMessageUseCase {
  final ScheduledMessageRepository _repository;

  UpdateScheduledMessageUseCase(this._repository);

  /// Execute the use case
  ///
  /// **Parameters:**
  /// - [conversationId]: ID of the conversation
  /// - [scheduledMessageId]: ID of the scheduled message
  /// - [content]: Optional new content
  /// - [scheduledTime]: Optional new scheduled time
  /// - [mediaUrl]: Optional new media URL
  /// - [thumbnailUrl]: Optional new thumbnail URL
  /// - [fileName]: Optional new file name
  ///
  /// **Returns:**
  /// - Right(ScheduledMessage): Success
  /// - Left(Failure): Error occurred
  Future<Either<Failure, ScheduledMessage>> call({
    required int conversationId,
    required int scheduledMessageId,
    String? content,
    DateTime? scheduledTime,
    String? mediaUrl,
    String? thumbnailUrl,
    String? fileName,
  }) async {
    // Validation: if scheduledTime is provided, it must be in the future
    if (scheduledTime != null && scheduledTime.isBefore(DateTime.now())) {
      return left(
        const Failure.validation(message: 'Thời gian hẹn phải trong tương lai', code: 'INVALID_SCHEDULED_TIME'),
      );
    }

    // Validation: if content is provided, it cannot be empty
    if (content != null && content.trim().isEmpty) {
      return left(const Failure.validation(message: 'Nội dung tin nhắn không được để trống', code: 'EMPTY_CONTENT'));
    }

    return await _repository.updateScheduledMessage(
      conversationId: conversationId,
      scheduledMessageId: scheduledMessageId,
      content: content,
      scheduledTime: scheduledTime,
      mediaUrl: mediaUrl,
      thumbnailUrl: thumbnailUrl,
      fileName: fileName,
    );
  }
}
