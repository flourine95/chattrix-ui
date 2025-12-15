import 'package:freezed_annotation/freezed_annotation.dart';

part 'reply_to_message.freezed.dart';

@freezed
abstract class ReplyToMessage with _$ReplyToMessage {
  const factory ReplyToMessage({
    required int id,
    required String content,
    required int senderId,
    required String senderUsername,
  }) = _ReplyToMessage;
}

