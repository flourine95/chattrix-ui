import 'package:freezed_annotation/freezed_annotation.dart';
import '../outgoing_message_dto.dart';

part 'scheduled_message_sent_dto.freezed.dart';
part 'scheduled_message_sent_dto.g.dart';

/// WebSocket DTO for scheduled.message.sent event
@freezed
abstract class ScheduledMessageSentDto with _$ScheduledMessageSentDto {
  const factory ScheduledMessageSentDto({required int scheduledMessageId, required OutgoingMessageDto message}) =
      _ScheduledMessageSentDto;

  factory ScheduledMessageSentDto.fromJson(Map<String, dynamic> json) => _$ScheduledMessageSentDtoFromJson(json);
}
