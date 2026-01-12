import 'package:freezed_annotation/freezed_annotation.dart';

part 'pinned_message_model.freezed.dart';
part 'pinned_message_model.g.dart';

@freezed
abstract class PinnedMessageModel with _$PinnedMessageModel {
  const factory PinnedMessageModel({
    required int id,
    required int conversationId,
    required int senderId,
    required String senderUsername,
    required String senderFullName,
    required String content,
    required String type,
    @Default({}) Map<String, dynamic> reactions,
    required DateTime sentAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool edited,
    @Default(false) bool deleted,
    @Default(false) bool forwarded,
    @Default(0) int forwardCount,
    @Default(true) bool pinned,
    DateTime? pinnedAt,
    int? pinnedBy,
    String? pinnedByUsername,
    String? pinnedByFullName,
    @Default(false) bool scheduled,
  }) = _PinnedMessageModel;

  factory PinnedMessageModel.fromJson(Map<String, dynamic> json) =>
      _$PinnedMessageModelFromJson(json);
}

@freezed
abstract class SearchMessagesRequest with _$SearchMessagesRequest {
  const factory SearchMessagesRequest({
    required String query,
    int? limit,
    String? cursor,
  }) = _SearchMessagesRequest;

  factory SearchMessagesRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchMessagesRequestFromJson(json);
}

@freezed
abstract class SearchMediaRequest with _$SearchMediaRequest {
  const factory SearchMediaRequest({
    String? type,
    int? limit,
    String? cursor,
  }) = _SearchMediaRequest;

  factory SearchMediaRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchMediaRequestFromJson(json);
}

