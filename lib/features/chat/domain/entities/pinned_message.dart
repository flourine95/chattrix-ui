import 'package:freezed_annotation/freezed_annotation.dart';

part 'pinned_message.freezed.dart';

/// Domain entity for pinned message
/// Framework-agnostic - NO Flutter/Dio/json_annotation imports
@freezed
abstract class PinnedMessage with _$PinnedMessage {
  const factory PinnedMessage({
    required int id,
    required int conversationId,
    required int senderId,
    required String senderUsername,
    required String senderFullName,
    required String content,
    required String type,
    required Map<String, dynamic> reactions,
    required DateTime sentAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    required bool edited,
    required bool deleted,
    required bool forwarded,
    required int forwardCount,
    required bool pinned,
    DateTime? pinnedAt,
    int? pinnedBy,
    String? pinnedByUsername,
    String? pinnedByFullName,
    required bool scheduled,
  }) = _PinnedMessage;
}
