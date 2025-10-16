import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_sender.freezed.dart';

@freezed
abstract class MessageSender with _$MessageSender {
  const factory MessageSender({
    required String id,
    required String username,
    required String fullName,
  }) = _MessageSender;
}
