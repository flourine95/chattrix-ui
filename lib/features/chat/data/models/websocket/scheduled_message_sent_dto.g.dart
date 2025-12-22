// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'scheduled_message_sent_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScheduledMessageSentDto _$ScheduledMessageSentDtoFromJson(
  Map<String, dynamic> json,
) => _ScheduledMessageSentDto(
  scheduledMessageId: (json['scheduledMessageId'] as num).toInt(),
  message: OutgoingMessageDto.fromJson(json['message'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ScheduledMessageSentDtoToJson(
  _ScheduledMessageSentDto instance,
) => <String, dynamic>{
  'scheduledMessageId': instance.scheduledMessageId,
  'message': instance.message,
};
