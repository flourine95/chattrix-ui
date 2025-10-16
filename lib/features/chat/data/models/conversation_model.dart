import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'participant_model.dart';

part 'conversation_model.freezed.dart';
part 'conversation_model.g.dart';

@freezed
abstract class ConversationModel with _$ConversationModel {
  const ConversationModel._();

  const factory ConversationModel({
    required String id,
    String? name,
    required String type,
    required String createdAt,
    required String updatedAt,
    required List<ParticipantModel> participants,
  }) = _ConversationModel;

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  Conversation toEntity() {
    return Conversation(
      id: id,
      name: name,
      type: type,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
      participants: participants.map((p) => p.toEntity()).toList(),
    );
  }
}
