import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'message_sender_model.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
abstract class MessageModel with _$MessageModel {
  const MessageModel._();

  const factory MessageModel({
    required String id,
    required String content,
    required String type,
    required String createdAt,
    required String conversationId,
    required MessageSenderModel sender,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Message toEntity() {
    return Message(
      id: id,
      content: content,
      type: type,
      createdAt: DateTime.parse(createdAt),
      conversationId: conversationId,
      sender: sender.toEntity(),
    );
  }
}
