import 'package:chattrix_ui/features/chat/domain/entities/conversation_update.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_update_model.freezed.dart';
part 'conversation_update_model.g.dart';

/// Model for conversation update (extends entity)
@freezed
abstract class ConversationUpdateModel with _$ConversationUpdateModel {
  const ConversationUpdateModel._();

  const factory ConversationUpdateModel({
    required int conversationId,
    required String updatedAt,
    LastMessageInfoModel? lastMessage,
  }) = _ConversationUpdateModel;

  /// Convert from JSON
  factory ConversationUpdateModel.fromJson(Map<String, dynamic> json) => _$ConversationUpdateModelFromJson(json);

  /// Convert to entity
  ConversationUpdate toEntity() {
    return ConversationUpdate(
      conversationId: conversationId,
      updatedAt: updatedAt,
      lastMessage: lastMessage?.toEntity(),
    );
  }
}

/// Model for last message info (extends entity)
@freezed
abstract class LastMessageInfoModel with _$LastMessageInfoModel {
  const LastMessageInfoModel._();

  const factory LastMessageInfoModel({
    required int id,
    required String content,
    required int senderId,
    required String senderUsername,
    required String sentAt,
    required String type,
  }) = _LastMessageInfoModel;

  /// Convert from JSON
  factory LastMessageInfoModel.fromJson(Map<String, dynamic> json) => _$LastMessageInfoModelFromJson(json);

  /// Convert to entity
  LastMessageInfo toEntity() {
    return LastMessageInfo(
      id: id,
      content: content,
      senderId: senderId,
      senderUsername: senderUsername,
      sentAt: sentAt,
      type: type,
    );
  }
}
