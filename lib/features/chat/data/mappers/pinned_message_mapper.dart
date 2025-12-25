import '../models/pinned_message_model.dart';
import '../../domain/entities/pinned_message.dart';

extension PinnedMessageModelMapper on PinnedMessageModel {
  PinnedMessage toEntity() {
    return PinnedMessage(
      id: id,
      conversationId: conversationId,
      senderId: senderId,
      senderUsername: senderUsername,
      senderFullName: senderFullName,
      content: content,
      type: type,
      reactions: reactions,
      sentAt: sentAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      edited: edited,
      deleted: deleted,
      forwarded: forwarded,
      forwardCount: forwardCount,
      pinned: pinned,
      pinnedAt: pinnedAt,
      pinnedBy: pinnedBy,
      pinnedByUsername: pinnedByUsername,
      pinnedByFullName: pinnedByFullName,
      scheduled: scheduled,
    );
  }
}
