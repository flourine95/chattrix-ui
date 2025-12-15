import 'package:chattrix_ui/features/chat/domain/entities/reply_to_message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reply_to_message_model.freezed.dart';
part 'reply_to_message_model.g.dart';

@freezed
abstract class ReplyToMessageModel with _$ReplyToMessageModel {
  const ReplyToMessageModel._();

  const factory ReplyToMessageModel({
    required int id,
    required String content,
    required int senderId,
    required String senderUsername,
  }) = _ReplyToMessageModel;

  factory ReplyToMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ReplyToMessageModelFromJson(json);

  ReplyToMessage toEntity() {
    return ReplyToMessage(
      id: id,
      content: content,
      senderId: senderId,
      senderUsername: senderUsername,
    );
  }
}

