// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'scheduled_msg_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScheduledMessageModel _$ScheduledMessageModelFromJson(
  Map<String, dynamic> json,
) => _ScheduledMessageModel(
  id: (json['id'] as num).toInt(),
  conversationId: (json['conversationId'] as num).toInt(),
  senderId: (json['senderId'] as num).toInt(),
  senderUsername: json['senderUsername'] as String?,
  senderFullName: json['senderFullName'] as String?,
  content: json['content'] as String,
  type: json['type'] as String,
  mediaUrl: json['mediaUrl'] as String?,
  sentAt: json['sentAt'] == null
      ? null
      : DateTime.parse(json['sentAt'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  scheduledTime: _$JsonConverterFromJson<String, DateTime>(
    json['scheduledTime'],
    const DateTimeUtcConverter().fromJson,
  ),
  scheduledStatus: json['scheduledStatus'] as String?,
);

Map<String, dynamic> _$ScheduledMessageModelToJson(
  _ScheduledMessageModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'conversationId': instance.conversationId,
  'senderId': instance.senderId,
  'senderUsername': instance.senderUsername,
  'senderFullName': instance.senderFullName,
  'content': instance.content,
  'type': instance.type,
  'mediaUrl': instance.mediaUrl,
  'sentAt': instance.sentAt?.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'scheduledTime': _$JsonConverterToJson<String, DateTime>(
    instance.scheduledTime,
    const DateTimeUtcConverter().toJson,
  ),
  'scheduledStatus': instance.scheduledStatus,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

_ScheduleMessageRequest _$ScheduleMessageRequestFromJson(
  Map<String, dynamic> json,
) => _ScheduleMessageRequest(
  content: json['content'] as String,
  type: json['type'] as String? ?? 'TEXT',
  scheduledTime: const DateTimeUtcConverter().fromJson(
    json['scheduledTime'] as String,
  ),
  mediaUrl: json['mediaUrl'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  fileName: json['fileName'] as String?,
  fileSize: (json['fileSize'] as num?)?.toInt(),
  duration: (json['duration'] as num?)?.toInt(),
  replyToMessageId: (json['replyToMessageId'] as num?)?.toInt(),
);

Map<String, dynamic> _$ScheduleMessageRequestToJson(
  _ScheduleMessageRequest instance,
) => <String, dynamic>{
  'content': instance.content,
  'type': instance.type,
  'scheduledTime': const DateTimeUtcConverter().toJson(instance.scheduledTime),
  'mediaUrl': instance.mediaUrl,
  'thumbnailUrl': instance.thumbnailUrl,
  'fileName': instance.fileName,
  'fileSize': instance.fileSize,
  'duration': instance.duration,
  'replyToMessageId': instance.replyToMessageId,
};

_ScheduledMessageListItemModel _$ScheduledMessageListItemModelFromJson(
  Map<String, dynamic> json,
) => _ScheduledMessageListItemModel(
  id: (json['id'] as num).toInt(),
  conversationId: (json['conversationId'] as num).toInt(),
  senderId: (json['senderId'] as num).toInt(),
  content: json['content'] as String,
  type: json['type'] as String,
  scheduledTime: _$JsonConverterFromJson<String, DateTime>(
    json['scheduledTime'],
    const DateTimeUtcConverter().fromJson,
  ),
  scheduledStatus: json['scheduledStatus'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ScheduledMessageListItemModelToJson(
  _ScheduledMessageListItemModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'conversationId': instance.conversationId,
  'senderId': instance.senderId,
  'content': instance.content,
  'type': instance.type,
  'scheduledTime': _$JsonConverterToJson<String, DateTime>(
    instance.scheduledTime,
    const DateTimeUtcConverter().toJson,
  ),
  'scheduledStatus': instance.scheduledStatus,
  'createdAt': instance.createdAt.toIso8601String(),
};

_ScheduledMessagesPaginationResponse
_$ScheduledMessagesPaginationResponseFromJson(Map<String, dynamic> json) =>
    _ScheduledMessagesPaginationResponse(
      messages:
          (json['data'] as List<dynamic>?)
              ?.map(
                (e) => ScheduledMessageListItemModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          const [],
      totalElements: (json['total'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
      currentPage: (json['page'] as num?)?.toInt() ?? 0,
      pageSize: (json['size'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ScheduledMessagesPaginationResponseToJson(
  _ScheduledMessagesPaginationResponse instance,
) => <String, dynamic>{
  'data': instance.messages,
  'total': instance.totalElements,
  'totalPages': instance.totalPages,
  'page': instance.currentPage,
  'size': instance.pageSize,
};

_UpdateScheduledMessageRequest _$UpdateScheduledMessageRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateScheduledMessageRequest(
  content: json['content'] as String?,
  scheduledTime: _$JsonConverterFromJson<String, DateTime>(
    json['scheduledTime'],
    const DateTimeUtcConverter().fromJson,
  ),
  mediaUrl: json['mediaUrl'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  fileName: json['fileName'] as String?,
);

Map<String, dynamic> _$UpdateScheduledMessageRequestToJson(
  _UpdateScheduledMessageRequest instance,
) => <String, dynamic>{
  'content': instance.content,
  'scheduledTime': _$JsonConverterToJson<String, DateTime>(
    instance.scheduledTime,
    const DateTimeUtcConverter().toJson,
  ),
  'mediaUrl': instance.mediaUrl,
  'thumbnailUrl': instance.thumbnailUrl,
  'fileName': instance.fileName,
};

_BulkCancelRequest _$BulkCancelRequestFromJson(Map<String, dynamic> json) =>
    _BulkCancelRequest(
      scheduledMessageIds: (json['scheduledMessageIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$BulkCancelRequestToJson(_BulkCancelRequest instance) =>
    <String, dynamic>{'scheduledMessageIds': instance.scheduledMessageIds};

_BulkCancelResponse _$BulkCancelResponseFromJson(Map<String, dynamic> json) =>
    _BulkCancelResponse(
      cancelledCount: (json['cancelledCount'] as num).toInt(),
      failedIds: (json['failedIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$BulkCancelResponseToJson(_BulkCancelResponse instance) =>
    <String, dynamic>{
      'cancelledCount': instance.cancelledCount,
      'failedIds': instance.failedIds,
    };
