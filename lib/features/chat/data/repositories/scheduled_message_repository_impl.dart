import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/repositories/base_repository.dart';
import '../../domain/datasources/scheduled_message_datasource.dart';
import '../../domain/entities/scheduled_message.dart';
import '../../domain/repositories/scheduled_message_repository.dart';
import '../models/scheduled_msg_model.dart';

/// Implementation of ScheduledMessageRepository
class ScheduledMessageRepositoryImpl extends BaseRepository implements ScheduledMessageRepository {
  final ScheduledMessageDatasource _datasource;

  ScheduledMessageRepositoryImpl(this._datasource);

  @override
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
  }) async {
    return executeApiCall(() async {
      final request = ScheduleMessageRequest(
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

      final response = await _datasource.scheduleMessage(conversationId: conversationId, request: request);

      if (response.success && response.data != null) {
        return response.data!.toEntity();
      } else {
        throw Exception(response.message);
      }
    });
  }

  @override
  Future<Either<Failure, List<ScheduledMessage>>> getScheduledMessages({
    int? conversationId,
    String status = 'PENDING',
    int page = 0,
    int size = 20,
  }) async {
    return executeApiCall(() async {
      debugPrint('🟢 Repository: Getting scheduled messages with status=$status');

      final response = await _datasource.getScheduledMessages(
        conversationId: conversationId,
        status: status,
        page: page,
        size: size,
      );

      debugPrint('🟢 Repository: API response success=${response.success}');
      debugPrint('🟢 Repository: API response data=${response.data}');

      if (response.success && response.data != null) {
        final messages = response.data!.messages.map((model) => model.toEntity()).toList();
        debugPrint('🟢 Repository: Converted ${messages.length} messages to entities');
        return messages;
      } else {
        debugPrint('🔴 Repository: API call failed with message: ${response.message}');
        throw Exception(response.message);
      }
    });
  }

  @override
  Future<Either<Failure, ScheduledMessage>> getScheduledMessage({required int scheduledMessageId}) async {
    return executeApiCall(() async {
      final response = await _datasource.getScheduledMessage(scheduledMessageId: scheduledMessageId);

      if (response.success && response.data != null) {
        return response.data!.toEntity();
      } else {
        throw Exception(response.message);
      }
    });
  }

  @override
  Future<Either<Failure, ScheduledMessage>> updateScheduledMessage({
    required int scheduledMessageId,
    String? content,
    DateTime? scheduledTime,
    String? mediaUrl,
    String? thumbnailUrl,
    String? fileName,
  }) async {
    return executeApiCall(() async {
      final request = UpdateScheduledMessageRequest(
        content: content,
        scheduledTime: scheduledTime,
        mediaUrl: mediaUrl,
        thumbnailUrl: thumbnailUrl,
        fileName: fileName,
      );

      final response = await _datasource.updateScheduledMessage(
        scheduledMessageId: scheduledMessageId,
        request: request,
      );

      if (response.success && response.data != null) {
        return response.data!.toEntity();
      } else {
        throw Exception(response.message);
      }
    });
  }

  @override
  Future<Either<Failure, void>> cancelScheduledMessage({required int scheduledMessageId}) async {
    return executeApiCall(() async {
      final response = await _datasource.cancelScheduledMessage(scheduledMessageId: scheduledMessageId);

      if (response.success) {
        return;
      } else {
        throw Exception(response.message);
      }
    });
  }

  @override
  Future<Either<Failure, int>> bulkCancelScheduledMessages({required List<int> scheduledMessageIds}) async {
    return executeApiCall(() async {
      final response = await _datasource.bulkCancelScheduledMessages(scheduledMessageIds: scheduledMessageIds);

      if (response.success && response.data != null) {
        return response.data!.cancelledCount;
      } else {
        throw Exception(response.message);
      }
    });
  }
}
