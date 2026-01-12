import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite_link.freezed.dart';

/// Domain entity for invite link
/// Framework-agnostic - NO Flutter/Dio/json_annotation imports
@freezed
abstract class InviteLink with _$InviteLink {
  const factory InviteLink({
    required int id,
    required String token,
    required int conversationId,
    required int createdBy,
    required String createdByUsername,
    required DateTime createdAt,
    int? maxUses,
    required int currentUses,
    required bool revoked,
    DateTime? revokedAt,
    int? revokedBy,
    required bool valid,
  }) = _InviteLink;
}

/// Domain entity for invite link info (public)
@freezed
abstract class InviteLinkInfo with _$InviteLinkInfo {
  const factory InviteLinkInfo({
    required String token,
    required int groupId,
    required int memberCount,
    required bool valid,
    required int createdBy,
    required String createdByUsername,
    required String createdByFullName,
  }) = _InviteLinkInfo;
}

/// Domain entity for join via invite link response
@freezed
abstract class JoinViaInviteLink with _$JoinViaInviteLink {
  const factory JoinViaInviteLink({required bool success, required int conversationId, required String message}) =
      _JoinViaInviteLink;
}
