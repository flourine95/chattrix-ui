// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'scheduled_message_failed_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScheduledMessageFailedDto _$ScheduledMessageFailedDtoFromJson(
  Map<String, dynamic> json,
) => _ScheduledMessageFailedDto(
  scheduledMessageId: (json['scheduledMessageId'] as num).toInt(),
  conversationId: (json['conversationId'] as num).toInt(),
  failedReason: json['failedReason'] as String,
  failedAt: DateTime.parse(json['failedAt'] as String),
);

Map<String, dynamic> _$ScheduledMessageFailedDtoToJson(
  _ScheduledMessageFailedDto instance,
) => <String, dynamic>{
  'scheduledMessageId': instance.scheduledMessageId,
  'conversationId': instance.conversationId,
  'failedReason': instance.failedReason,
  'failedAt': instance.failedAt.toIso8601String(),
};
