import 'package:chattrix_ui/features/chat/domain/entities/message_sender.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_sender_model.freezed.dart';
part 'message_sender_model.g.dart';

@freezed
abstract class MessageSenderModel with _$MessageSenderModel {
  const MessageSenderModel._();

  const factory MessageSenderModel({
    required int id,
    required String username,
    required String fullName,
  }) = _MessageSenderModel;

  factory MessageSenderModel.fromJson(Map<String, dynamic> json) =>
      _$MessageSenderModelFromJson(json);

  factory MessageSenderModel.fromApi(Map<String, dynamic> json) {
    final rawId = json['id'] ?? json['userId'] ?? json['senderId'];
    final id = rawId is int ? rawId : int.tryParse(rawId.toString()) ?? 0;

    return MessageSenderModel(
      id: id,
      username: (json['username'] ?? json['senderUsername'] ?? '').toString(),
      fullName: (json['fullName'] ?? json['full_name'] ?? '').toString(),
    );
  }

  MessageSender toEntity() {
    return MessageSender(
      id: id,
      username: username,
      fullName: fullName,
    );
  }
}
