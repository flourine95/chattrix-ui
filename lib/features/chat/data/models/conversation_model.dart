import 'package:chattrix_ui/core/domain/enums/enums.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_settings_model.dart';
import 'package:chattrix_ui/features/chat/data/models/message_model.dart';
import 'package:chattrix_ui/features/chat/data/models/participant_model.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:flutter/material.dart';
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
    String? avatarUrl,
    required String createdAt,
    required String updatedAt,
    required List<ParticipantModel> participants,
    MessageModel? lastMessage,
    @Default(0) int unreadCount,
    ConversationSettingsModel? settings,
  }) = _ConversationModel;

  factory ConversationModel.fromJson(Map<String, dynamic> json) => _$ConversationModelFromJson(json);

  factory ConversationModel.fromApi(Map<String, dynamic> json) {
    final participantsJson = (json['participants'] as List? ?? []).whereType<Map<String, dynamic>>().toList();

    final lastMessageJson = json['lastMessage'];
    MessageModel? lastMessageModel;
    if (lastMessageJson != null && lastMessageJson is Map<String, dynamic>) {
      lastMessageModel = MessageModel.fromApi(lastMessageJson);
    }

    final settingsJson = json['settings'];
    ConversationSettingsModel? settingsModel;
    if (settingsJson != null && settingsJson is Map<String, dynamic>) {
      settingsModel = ConversationSettingsModel.fromJson(settingsJson);
      debugPrint(
        '🔍 Conversation ${json['id']} settings: pinned=${settingsModel.pinned}, muted=${settingsModel.muted}, hidden=${settingsModel.hidden}, pinOrder=${settingsModel.pinOrder}',
      );
    } else {
      debugPrint('⚠️ Conversation ${json['id']} has NO settings field - using defaults');
      // Create default settings if backend doesn't return it
      settingsModel = const ConversationSettingsModel(
        conversationId: 0,
        muted: false,
        blocked: false,
        notificationsEnabled: true,
        pinned: false,
        archived: false,
        hidden: false,
      );
    }

    return ConversationModel(
      id: (json['id'] ?? json['conversationId'] ?? 0) is int
          ? (json['id'] ?? json['conversationId'] ?? 0)
          : int.tryParse((json['id'] ?? json['conversationId'] ?? 0).toString()) ?? 0,
      name: (json['name'] ?? json['title'])?.toString(),
      type: (json['type'] ?? '').toString(),
      avatarUrl: json['avatarUrl']?.toString(),
      createdAt: (json['createdAt'] ?? json['created_at'] ?? '').toString(),
      updatedAt: (json['updatedAt'] ?? json['updated_at'] ?? '').toString(),
      participants: participantsJson.map((p) => ParticipantModel.fromApi(p)).toList(),
      lastMessage: lastMessageModel,
      unreadCount: json['unreadCount'] ?? 0,
      settings: settingsModel,
    );
  }

  Conversation toEntity() {
    // Map string type to ConversationType enum
    final conversationType = type.toUpperCase() == 'DIRECT' ? ConversationType.direct : ConversationType.group;

    return Conversation(
      id: id,
      name: name,
      type: conversationType,
      avatarUrl: avatarUrl,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
      participants: participants.map((p) => p.toEntity()).toList(),
      lastMessage: lastMessage?.toEntity(),
      unreadCount: unreadCount,
      settings: settings?.toEntity(),
    );
  }
}
