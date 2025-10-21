import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'message_model.dart';
import 'participant_model.dart';

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
    // Debug: Print raw JSON to see what backend sends
    print('🔍 ConversationModel.fromApi JSON keys: ${json.keys.toList()}');
    print('🔍 Conversation ID: ${json['id']}, Type: ${json['type']}');
    print('🔍 Has lastMessage: ${json.containsKey('lastMessage')}');
    print('🔍 Participants count: ${(json['participants'] as List?)?.length ?? 0}');

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
