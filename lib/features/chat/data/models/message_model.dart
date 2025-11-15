import 'dart:convert';
import 'package:chattrix_ui/features/chat/data/models/message_sender_model.dart';
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
    required String content,
    required String type,
    required String createdAt,
    required String conversationId,
    required MessageSenderModel sender,
    String? mediaUrl,
    String? thumbnailUrl,
    String? fileName,
    int? fileSize,
    int? duration,
    double? latitude,
    double? longitude,
    String? locationName,
    int? replyToMessageId,
    String? reactions,
    String? mentions,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

  factory MessageModel.fromApi(Map<String, dynamic> json) {
    final senderJson = (json['sender'] is Map<String, dynamic>)
        ? json['sender'] as Map<String, dynamic>
        : <String, dynamic>{
            'id': json['senderId'],
            'userId': json['senderId'],
            'senderId': json['senderId'],
            'username': json['senderUsername'],
            'senderUsername': json['senderUsername'],
            'fullName': json['senderFullName'] ?? json['full_name'] ?? '',
          };

    return MessageModel(
      id: (json['id'] ?? json['messageId'] ?? ''),
      content: (json['content'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      createdAt: (json['createdAt'] ?? json['sentAt'] ?? DateTime.now().toIso8601String()).toString(),
      conversationId: (json['conversationId'] ?? json['conversation_id'] ?? '').toString(),
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
      reactions: _convertReactionsToJson(json['reactions']),
      mentions: _convertMentionsToJson(json['mentions']),
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
      content: content,
      type: type,
      createdAt: DateTime.parse(createdAt),
      conversationId: conversationId,
      sender: sender.toEntity(),
      mediaUrl: mediaUrl,
      thumbnailUrl: thumbnailUrl,
      fileName: fileName,
      fileSize: fileSize,
      duration: duration,
      latitude: latitude,
      longitude: longitude,
      locationName: locationName,
      replyToMessageId: replyToMessageId,
      reactions: reactions,
      mentions: mentions,
    );
  }
}
