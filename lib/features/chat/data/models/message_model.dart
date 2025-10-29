import 'package:chattrix_ui/features/chat/data/models/message_sender_model.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
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
    // Reactions and mentions (JSON strings)
    String? reactions,
    String? mentions,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  // Maps backend API response variations into our model
  factory MessageModel.fromApi(Map<String, dynamic> json) {
    // Build sender from nested object or flat senderId/senderUsername fields
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
      createdAt:
          (json['createdAt'] ??
                  json['sentAt'] ??
                  DateTime.now().toIso8601String())
              .toString(),
      conversationId: (json['conversationId'] ?? json['conversation_id'] ?? '')
          .toString(),
      sender: MessageSenderModel.fromApi(senderJson),
      // Rich media fields
      mediaUrl: json['mediaUrl']?.toString(),
      thumbnailUrl: json['thumbnailUrl']?.toString(),
      fileName: json['fileName']?.toString(),
      fileSize: json['fileSize'] != null ? (json['fileSize'] as num).toInt() : null,
      duration: json['duration'] != null ? (json['duration'] as num).toInt() : null,
      // Location fields
      latitude: json['latitude'] != null ? (json['latitude'] as num).toDouble() : null,
      longitude: json['longitude'] != null ? (json['longitude'] as num).toDouble() : null,
      locationName: json['locationName']?.toString(),
      // Reply/Thread fields
      replyToMessageId: json['replyToMessageId'] != null ? (json['replyToMessageId'] as num).toInt() : null,
      // Reactions and mentions
      reactions: json['reactions']?.toString(),
      mentions: json['mentions']?.toString(),
    );
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
