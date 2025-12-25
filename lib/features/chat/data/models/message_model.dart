import 'package:chattrix_ui/features/chat/data/models/mentioned_user_model.dart';
import 'package:chattrix_ui/features/chat/data/models/read_receipt_model.dart';
import 'package:chattrix_ui/features/chat/data/models/reply_to_message_model.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/poll/data/models/poll_dto.dart';
import 'package:chattrix_ui/features/poll/data/mappers/poll_mapper.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
abstract class MessageModel with _$MessageModel {
  const MessageModel._();

  const factory MessageModel({
    required int id,
    required int conversationId,
    required int senderId,
    String? senderUsername,
    String? senderFullName,
    required String content,
    required String type,
    required String createdAt,
    // Rich media fields
    String? mediaUrl,
    String? thumbnailUrl,
    String? fileName,
    int? fileSize,
    int? duration,
    // Location fields
    double? latitude,
    double? longitude,
    String? locationName,
    // Reply/Thread fields
    int? replyToMessageId,
    ReplyToMessageModel? replyToMessage,
    // Reactions: Map of emoji to array of user IDs
    Map<String, List<int>>? reactions,
    // Mentions: Array of user IDs
    List<int>? mentions,
    @Default([]) List<MentionedUserModel> mentionedUsers,
    // Timestamps
    String? sentAt,
    String? updatedAt,
    // Edit/Delete/Forward
    @Default(false) bool edited,
    String? editedAt,
    @Default(false) bool deleted,
    String? deletedAt,
    @Default(false) bool forwarded,
    int? originalMessageId,
    @Default(0) int forwardCount,
    // Read receipts
    @Default(0) int readCount,
    @Default([]) List<ReadReceiptModel> readBy,
    // Scheduled message fields
    @Default(false) bool scheduled,
    String? scheduledTime,
    String? scheduledStatus, // PENDING, SENT, CANCELLED, FAILED
    // Poll data (for POLL type messages)
    PollDto? pollData,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

  /// Parse message from API response
  /// Handles both REST API and WebSocket message formats
  factory MessageModel.fromApi(Map<String, dynamic> json) {
    // Parse replyToMessage
    ReplyToMessageModel? replyToMessage;
    if (json['replyToMessage'] != null && json['replyToMessage'] is Map<String, dynamic>) {
      replyToMessage = ReplyToMessageModel.fromJson(json['replyToMessage']);
    }

    // Parse mentionedUsers - skip invalid entries
    List<MentionedUserModel> mentionedUsers = [];
    if (json['mentionedUsers'] != null && json['mentionedUsers'] is List) {
      for (var e in json['mentionedUsers'] as List) {
        try {
          mentionedUsers.add(MentionedUserModel.fromJson(e as Map<String, dynamic>));
        } catch (error) {
          // Skip invalid mentioned user (e.g., null userId from backend)
          debugPrint('⚠️ Skipping invalid mentioned user: $error');
        }
      }
    }

    // Parse readBy
    List<ReadReceiptModel> readBy = [];
    if (json['readBy'] != null && json['readBy'] is List) {
      readBy = (json['readBy'] as List).map((e) => ReadReceiptModel.fromJson(e as Map<String, dynamic>)).toList();
    }

    // Parse reactions - API returns Map<String, List<int>>
    Map<String, List<int>>? reactions;
    if (json['reactions'] != null && json['reactions'] is Map) {
      reactions = (json['reactions'] as Map).map(
        (key, value) => MapEntry(key.toString(), (value as List).map((e) => (e as num).toInt()).toList()),
      );
    }

    // Parse mentions - API returns List<int>
    List<int>? mentions;
    if (json['mentions'] != null && json['mentions'] is List) {
      mentions = (json['mentions'] as List).map((e) => (e as num).toInt()).toList();
    }

    // Parse poll data - API returns 'poll' object for POLL type messages
    PollDto? pollData;
    // Try 'poll' field first (messages API), then 'pollData' (WebSocket)
    final pollJson = json['poll'] ?? json['pollData'];
    if (pollJson != null && pollJson is Map) {
      try {
        pollData = PollDto.fromJson(pollJson as Map<String, dynamic>);
        debugPrint('🗳️ [MessageModel] ✅ Successfully parsed poll ${pollData.id} for message ${json['id']}');
      } catch (e) {
        debugPrint('⚠️ [MessageModel] Failed to parse poll for message ${json['id']}: $e');
      }
    } else {
      if (json['type'] == 'POLL') {
        debugPrint('🗳️ [MessageModel] ⚠️ POLL message ${json['id']} has no poll data (pollId: ${json['pollId']})');
      }
    }

    return MessageModel(
      id: (json['id'] ?? json['messageId'] ?? 0) as int,
      conversationId: (json['conversationId'] ?? json['conversation_id'] ?? 0) as int,
      senderId: (json['senderId'] ?? json['sender']?['id'] ?? 0) as int,
      senderUsername: json['senderUsername']?.toString() ?? json['sender']?['username']?.toString(),
      senderFullName: json['senderFullName']?.toString() ?? json['sender']?['fullName']?.toString(),
      content: (json['content'] ?? '').toString(),
      type: (json['type'] ?? 'TEXT').toString(),
      createdAt: (json['createdAt'] ?? json['sentAt'] ?? DateTime.now().toIso8601String()).toString(),
      mediaUrl: json['mediaUrl']?.toString(),
      thumbnailUrl: json['thumbnailUrl']?.toString(),
      fileName: json['fileName']?.toString(),
      fileSize: json['fileSize'] != null ? (json['fileSize'] as num).toInt() : null,
      duration: json['duration'] != null ? (json['duration'] as num).toInt() : null,
      latitude: json['latitude'] != null ? (json['latitude'] as num).toDouble() : null,
      longitude: json['longitude'] != null ? (json['longitude'] as num).toDouble() : null,
      locationName: json['locationName']?.toString(),
      replyToMessageId: json['replyToMessageId'] != null ? (json['replyToMessageId'] as num).toInt() : null,
      replyToMessage: replyToMessage,
      reactions: reactions,
      mentions: mentions,
      mentionedUsers: mentionedUsers,
      sentAt: json['sentAt']?.toString(),
      updatedAt: json['updatedAt']?.toString(),
      edited: json['edited'] ?? false,
      editedAt: json['editedAt']?.toString(),
      deleted: json['deleted'] ?? false,
      deletedAt: json['deletedAt']?.toString(),
      forwarded: json['forwarded'] ?? false,
      originalMessageId: json['originalMessageId'] != null ? (json['originalMessageId'] as num).toInt() : null,
      forwardCount: json['forwardCount'] ?? 0,
      readCount: json['readCount'] ?? 0,
      readBy: readBy,
      scheduled: json['scheduled'] ?? false,
      scheduledTime: json['scheduledTime']?.toString(),
      scheduledStatus: json['scheduledStatus']?.toString(),
      pollData: pollData,
    );
  }

  /// Convert to domain entity
  Message toEntity() {
    return Message(
      id: id,
      conversationId: conversationId,
      senderId: senderId,
      senderUsername: senderUsername,
      senderFullName: senderFullName,
      content: content,
      type: type,
      createdAt: DateTime.parse(createdAt),
      mediaUrl: mediaUrl,
      thumbnailUrl: thumbnailUrl,
      fileName: fileName,
      fileSize: fileSize,
      duration: duration,
      latitude: latitude,
      longitude: longitude,
      locationName: locationName,
      replyToMessageId: replyToMessageId,
      replyToMessage: replyToMessage?.toEntity(),
      reactions: reactions,
      mentions: mentions,
      mentionedUsers: mentionedUsers.map((e) => e.toEntity()).toList(),
      sentAt: sentAt != null ? DateTime.parse(sentAt!) : null,
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
      edited: edited,
      editedAt: editedAt != null ? DateTime.parse(editedAt!) : null,
      deleted: deleted,
      deletedAt: deletedAt != null ? DateTime.parse(deletedAt!) : null,
      forwarded: forwarded,
      originalMessageId: originalMessageId,
      forwardCount: forwardCount,
      readCount: readCount,
      readBy: readBy.map((e) => e.toEntity()).toList(),
      scheduled: scheduled,
      scheduledTime: scheduledTime != null ? DateTime.parse(scheduledTime!) : null,
      scheduledStatus: scheduledStatus,
      pollData: pollData?.toEntity(),
    );
  }
}
