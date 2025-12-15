import 'dart:convert';
import 'package:chattrix_ui/features/chat/data/models/mentioned_user_model.dart';
import 'package:chattrix_ui/features/chat/data/models/message_sender_model.dart';
import 'package:chattrix_ui/features/chat/data/models/read_receipt_model.dart';
import 'package:chattrix_ui/features/chat/data/models/reply_to_message_model.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:flutter/cupertino.dart';
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
    @Deprecated('Use senderId, senderUsername, senderFullName instead') MessageSenderModel? sender,
    String? mediaUrl,
    String? thumbnailUrl,
    String? fileName,
    int? fileSize,
    int? duration,
    double? latitude,
    double? longitude,
    String? locationName,
    int? replyToMessageId,
    ReplyToMessageModel? replyToMessage,
    String? reactions,
    String? mentions,
    @Default([]) List<MentionedUserModel> mentionedUsers,
    String? sentAt,
    String? updatedAt,
    @Default(false) bool edited,
    String? editedAt,
    @Default(false) bool deleted,
    String? deletedAt,
    @Default(false) bool forwarded,
    int? originalMessageId,
    @Default(0) int forwardCount,
    @Default(0) int readCount,
    @Default([]) List<ReadReceiptModel> readBy,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

  factory MessageModel.fromApi(Map<String, dynamic> json) {
    // Parse senderId
    final senderId = (json['senderId'] ?? json['sender']?['id'] ?? 0) is int
        ? (json['senderId'] ?? json['sender']?['id'] ?? 0)
        : int.tryParse((json['senderId'] ?? json['sender']?['id'] ?? 0).toString()) ?? 0;

    // Parse senderUsername
    final senderUsername = json['senderUsername']?.toString() ??
                          json['sender']?['username']?.toString();

    // Parse senderFullName
    final senderFullName = json['senderFullName']?.toString() ??
                          json['sender']?['fullName']?.toString();

    // Keep backward compatibility with old sender object
    final senderJson = (json['sender'] is Map<String, dynamic>)
        ? json['sender'] as Map<String, dynamic>
        : <String, dynamic>{
            'id': senderId,
            'userId': senderId,
            'senderId': senderId,
            'username': senderUsername,
            'senderUsername': senderUsername,
            'fullName': senderFullName ?? '',
          };

    // Parse replyToMessage
    ReplyToMessageModel? replyToMessage;
    if (json['replyToMessage'] != null && json['replyToMessage'] is Map<String, dynamic>) {
      replyToMessage = ReplyToMessageModel.fromJson(json['replyToMessage']);
    }

    // Parse mentionedUsers
    List<MentionedUserModel> mentionedUsers = [];
    if (json['mentionedUsers'] != null && json['mentionedUsers'] is List) {
      mentionedUsers = (json['mentionedUsers'] as List)
          .map((e) => MentionedUserModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    // Parse readBy
    List<ReadReceiptModel> readBy = [];
    if (json['readBy'] != null && json['readBy'] is List) {
      readBy = (json['readBy'] as List)
          .map((e) => ReadReceiptModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return MessageModel(
      id: (json['id'] ?? json['messageId'] ?? 0) is int
          ? (json['id'] ?? json['messageId'] ?? 0)
          : int.tryParse((json['id'] ?? json['messageId'] ?? 0).toString()) ?? 0,
      conversationId: (json['conversationId'] ?? json['conversation_id'] ?? 0) is int
          ? (json['conversationId'] ?? json['conversation_id'] ?? 0)
          : int.tryParse((json['conversationId'] ?? json['conversation_id'] ?? '0').toString()) ?? 0,
      senderId: senderId,
      senderUsername: senderUsername,
      senderFullName: senderFullName,
      content: (json['content'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      createdAt: (json['createdAt'] ?? json['sentAt'] ?? DateTime.now().toIso8601String()).toString(),
      sender: MessageSenderModel.fromApi(senderJson),
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
      reactions: _convertReactionsToJson(json['reactions']),
      mentions: _convertMentionsToJson(json['mentions']),
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
    );
  }

  /// Convert reactions from API format to JSON string
  /// API returns: {"👍": [1, 5], "❤️": [7]} (object)
  /// We need: "{\"👍\": [1, 5], \"❤️\": [7]}" (JSON string)
  static String? _convertReactionsToJson(dynamic reactions) {
    if (reactions == null) return null;
    if (reactions is String) return reactions;
    if (reactions is Map) {
      try {
        return jsonEncode(reactions);
      } catch (e) {
        debugPrint('Error converting reactions to JSON: $e');
        return null;
      }
    }
    return null;
  }

  /// Convert mentions from API format to JSON string
  /// API returns: [1, 2, 3] (array)
  /// We need: "[1, 2, 3]" (JSON string)
  static String? _convertMentionsToJson(dynamic mentions) {
    if (mentions == null) return null;
    if (mentions is String) return mentions;
    if (mentions is List) {
      try {
        // Convert List to JSON string
        return jsonEncode(mentions);
      } catch (e) {
        debugPrint('Error converting mentions to JSON: $e');
        return null;
      }
    }
    return null;
  }

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
      sender: sender?.toEntity(),
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
    );
  }
}
