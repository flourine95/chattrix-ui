import 'package:chattrix_ui/features/chat/domain/entities/message_sender.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

@freezed
abstract class Message with _$Message {
  const factory Message({
    required int id,
    required String content,
    required String type, // 'TEXT', etc.
    required DateTime createdAt,
    required String conversationId,
    required MessageSender sender,
  }) = _Message;
}
