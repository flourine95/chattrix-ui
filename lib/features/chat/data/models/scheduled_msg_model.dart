import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/scheduled_message.dart';

part 'scheduled_msg_model.freezed.dart';
part 'scheduled_msg_model.g.dart';

/// Custom converter to serialize DateTime as UTC with Z suffix
class DateTimeUtcConverter implements JsonConverter<DateTime, String> {
  const DateTimeUtcConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => object.toUtc().toIso8601String();
}

/// Response model for scheduled message
@freezed
abstract class ScheduledMessageModel with _$ScheduledMessageModel {
  const ScheduledMessageModel._();

  const factory ScheduledMessageModel({
    required int id,
    required int conversationId,
    required int senderId,
    String? senderUsername,
    String? senderFullName,
    required String content,
    required String type,
    String? mediaUrl,
    DateTime? sentAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    @DateTimeUtcConverter() DateTime? scheduledTime,
    String? scheduledStatus,
  }) = _ScheduledMessageModel;

  factory ScheduledMessageModel.fromJson(Map<String, dynamic> json) => _$ScheduledMessageModelFromJson(json);

  ScheduledMessage toEntity() {
    return ScheduledMessage(
      id: id,
      conversationId: conversationId,
      senderId: senderId,
      senderUsername: senderUsername,
      senderFullName: senderFullName,
      content: content,
      type: type,
      mediaUrl: mediaUrl,
      thumbnailUrl: null,
      fileName: null,
      fileSize: null,
      duration: null,
      replyToMessageId: null,
      sentAt: sentAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      scheduledTime: scheduledTime,
      scheduledStatus: scheduledStatus,
    );
  }
}

/// Request model for creating scheduled message
@freezed
abstract class ScheduleMessageRequest with _$ScheduleMessageRequest {
  const ScheduleMessageRequest._();

  const factory ScheduleMessageRequest({
    required String content,
    @Default('TEXT') String type,
    @DateTimeUtcConverter() required DateTime scheduledTime,
    String? mediaUrl,
    String? thumbnailUrl,
    String? fileName,
    int? fileSize,
    int? duration,
    int? replyToMessageId,
  }) = _ScheduleMessageRequest;

  factory ScheduleMessageRequest.fromJson(Map<String, dynamic> json) => _$ScheduleMessageRequestFromJson(json);
}

/// List item model for scheduled messages (includes scheduledTime and scheduledStatus)
@freezed
abstract class ScheduledMessageListItemModel with _$ScheduledMessageListItemModel {
  const ScheduledMessageListItemModel._();

  const factory ScheduledMessageListItemModel({
    required int id,
    required int conversationId,
    required int senderId,
    required String content,
    required String type,
    @DateTimeUtcConverter() DateTime? scheduledTime,
    String? scheduledStatus,
    required DateTime createdAt,
  }) = _ScheduledMessageListItemModel;

  factory ScheduledMessageListItemModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduledMessageListItemModelFromJson(json);

  ScheduledMessage toEntity() {
    return ScheduledMessage(
      id: id,
      conversationId: conversationId,
      senderId: senderId,
      senderUsername: null,
      senderFullName: null,
      content: content,
      type: type,
      mediaUrl: null,
      thumbnailUrl: null,
      fileName: null,
      fileSize: null,
      duration: null,
      replyToMessageId: null,
      sentAt: null,
      createdAt: createdAt,
      updatedAt: createdAt,
      scheduledTime: scheduledTime,
      scheduledStatus: scheduledStatus,
    );
  }
}

/// Pagination response for list scheduled messages
@freezed
abstract class ScheduledMessagesPaginationResponse with _$ScheduledMessagesPaginationResponse {
  const factory ScheduledMessagesPaginationResponse({
    @Default([]) List<ScheduledMessageListItemModel> items,
    @JsonKey(name: 'nextCursor') String? nextCursor,
    @Default(false) bool hasNextPage,
    @Default(20) int itemsPerPage,
  }) = _ScheduledMessagesPaginationResponse;

  factory ScheduledMessagesPaginationResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduledMessagesPaginationResponseFromJson(json);
}

/// Request model for updating scheduled message
@freezed
abstract class UpdateScheduledMessageRequest with _$UpdateScheduledMessageRequest {
  const UpdateScheduledMessageRequest._();

  const factory UpdateScheduledMessageRequest({
    String? content,
    @DateTimeUtcConverter() DateTime? scheduledTime,
    String? mediaUrl,
    String? thumbnailUrl,
    String? fileName,
  }) = _UpdateScheduledMessageRequest;

  factory UpdateScheduledMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateScheduledMessageRequestFromJson(json);
}

/// Request model for bulk cancel
@freezed
abstract class BulkCancelRequest with _$BulkCancelRequest {
  const factory BulkCancelRequest({required List<int> scheduledMessageIds}) = _BulkCancelRequest;

  factory BulkCancelRequest.fromJson(Map<String, dynamic> json) => _$BulkCancelRequestFromJson(json);
}

/// Response model for bulk cancel
@freezed
abstract class BulkCancelResponse with _$BulkCancelResponse {
  const factory BulkCancelResponse({required int cancelledCount, required List<int> failedIds}) = _BulkCancelResponse;

  factory BulkCancelResponse.fromJson(Map<String, dynamic> json) => _$BulkCancelResponseFromJson(json);
}
