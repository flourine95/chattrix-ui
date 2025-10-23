import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_update.freezed.dart';

/// Entity representing a conversation update from WebSocket
@freezed
abstract class ConversationUpdate with _$ConversationUpdate {
  const ConversationUpdate._();

  const factory ConversationUpdate({
    required int conversationId,
    required String updatedAt,
    LastMessageInfo? lastMessage,
  }) = _ConversationUpdate;
}

/// Entity representing last message info in a conversation update
@freezed
abstract class LastMessageInfo with _$LastMessageInfo {
  const LastMessageInfo._();

  const factory LastMessageInfo({
    required int id,
    required String content,
    required int senderId,
    required String senderUsername,
    required String sentAt,
    required String type,
  }) = _LastMessageInfo;
}
