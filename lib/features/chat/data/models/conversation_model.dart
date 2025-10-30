import 'package:chattrix_ui/features/chat/data/models/message_model.dart';
import 'package:chattrix_ui/features/chat/data/models/participant_model.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_model.freezed.dart';
part 'conversation_model.g.dart';

@freezed
abstract class ConversationModel with _$ConversationModel {
  const ConversationModel._();

  const factory ConversationModel({
    required int id,
    String? name,
    required String type,
    required String createdAt,
    required String updatedAt,
    required List<ParticipantModel> participants,
    MessageModel? lastMessage,
  }) = _ConversationModel;

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  factory ConversationModel.fromApi(Map<String, dynamic> json) {
    final participantsJson = (json['participants'] as List? ?? [])
        .whereType<Map<String, dynamic>>()
        .toList();

    final lastMessageJson = json['lastMessage'];
    MessageModel? lastMessageModel;
    if (lastMessageJson != null && lastMessageJson is Map<String, dynamic>) {
      lastMessageModel = MessageModel.fromApi(lastMessageJson);
    }

    return ConversationModel(
      id: (json['id'] ?? json['conversationId'] ?? ''),
      name: (json['name'] ?? json['title'])?.toString(),
      type: (json['type'] ?? '').toString(),
      createdAt: (json['createdAt'] ?? json['created_at'] ?? '').toString(),
      updatedAt: (json['updatedAt'] ?? json['updated_at'] ?? '').toString(),
      participants: participantsJson
          .map((p) => ParticipantModel.fromApi(p))
          .toList(),
      lastMessage: lastMessageModel,
    );
  }

  Conversation toEntity() {
    return Conversation(
      id: id,
      name: name,
      type: type,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
      participants: participants.map((p) => p.toEntity()).toList(),
      lastMessage: lastMessage?.toEntity(),
    );
  }
}
