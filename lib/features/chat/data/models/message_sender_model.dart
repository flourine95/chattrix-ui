import 'package:chattrix_ui/features/chat/domain/entities/message_sender.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_sender_model.freezed.dart';
part 'message_sender_model.g.dart';

@freezed
abstract class MessageSenderModel with _$MessageSenderModel {
  const MessageSenderModel._();

  const factory MessageSenderModel({
    required String id,
    required String username,
    required String fullName,
  }) = _MessageSenderModel;

  factory MessageSenderModel.fromJson(Map<String, dynamic> json) =>
      _$MessageSenderModelFromJson(json);

  // Maps backend variations into our model
  factory MessageSenderModel.fromApi(Map<String, dynamic> json) {
    return MessageSenderModel(
      id: (json['id'] ?? json['userId'] ?? json['senderId'] ?? '').toString(),
      username: (json['username'] ?? json['senderUsername'] ?? '').toString(),
      fullName: (json['fullName'] ?? json['full_name'] ?? '').toString(),
    );
  }

  MessageSender toEntity() {
    return MessageSender(id: id, username: username, fullName: fullName);
  }
}
