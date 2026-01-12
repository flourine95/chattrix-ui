import 'package:freezed_annotation/freezed_annotation.dart';

part 'scheduled_message_failed_dto.freezed.dart';
part 'scheduled_message_failed_dto.g.dart';

/// WebSocket DTO for scheduled.message.failed event
@freezed
abstract class ScheduledMessageFailedDto with _$ScheduledMessageFailedDto {
  const factory ScheduledMessageFailedDto({
    required int scheduledMessageId,
    required int conversationId,
    required String failedReason,
    required DateTime failedAt,
  }) = _ScheduledMessageFailedDto;

  factory ScheduledMessageFailedDto.fromJson(Map<String, dynamic> json) => _$ScheduledMessageFailedDtoFromJson(json);
}
