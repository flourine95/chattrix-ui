import 'package:freezed_annotation/freezed_annotation.dart';

import 'message_sender.dart';

part 'message.freezed.dart';

@freezed
abstract class Message with _$Message {
  const factory Message({
    required String id,
    required String content,
    required String type, // 'TEXT', etc.
    required DateTime createdAt,
    required String conversationId,
    required MessageSender sender,
  }) = _Message;
}
