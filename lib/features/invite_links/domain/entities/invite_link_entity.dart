import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite_link_entity.freezed.dart';

/// Domain entity for invite link
@freezed
abstract class InviteLinkEntity with _$InviteLinkEntity {
  const factory InviteLinkEntity({
    required int id,
    required String token,
    required int conversationId,
    required int createdBy,
    required String createdByUsername,
    required DateTime createdAt,
    DateTime? expiresAt,
    int? maxUses,
    required int currentUses,
    required bool revoked,
    DateTime? revokedAt,
    int? revokedBy,
    required bool valid,
  }) = _InviteLinkEntity;

  const InviteLinkEntity._();

  /// Check if link is expired
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  /// Check if link reached max uses
  bool get isMaxUsesReached {
    if (maxUses == null) return false;
    return currentUses >= maxUses!;
  }

  /// Get full invite URL
  String get inviteUrl => 'https://chattrix.app/invite/$token';

  /// Get deep link URL
  String get deepLinkUrl => 'chattrix://invite/$token';
}

/// Domain entity for invite link info (public)
@freezed
abstract class InviteLinkInfoEntity with _$InviteLinkInfoEntity {
  const factory InviteLinkInfoEntity({
    required String token,
    required int groupId,
    required String groupName,
    required int memberCount,
    required bool valid,
    DateTime? expiresAt,
    required int createdBy,
    required String createdByUsername,
    required String createdByFullName,
    int? maxUses,
    @Default(0) int usesCount,
    @Default(false) bool revoked,
    String? groupAvatar,
  }) = _InviteLinkInfoEntity;

  const InviteLinkInfoEntity._();

  /// Check if link is expired
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  /// Check if link reached max uses
  bool get isMaxUsesReached {
    if (maxUses == null) return false;
    return usesCount >= maxUses!;
  }

  /// Check if link is valid (not expired, not revoked, not max uses reached)
  bool get isValid => valid && !isExpired && !isMaxUsesReached && !revoked;

  /// Get creator display name
  String get creatorName => createdByFullName.isNotEmpty ? createdByFullName : createdByUsername;

  /// Get created at date (using current time as fallback since API doesn't provide it)
  DateTime get createdAt => DateTime.now();
}

/// Domain entity for join group result
@freezed
abstract class JoinGroupResultEntity with _$JoinGroupResultEntity {
  const factory JoinGroupResultEntity({
    required bool success,
    required int conversationId,
    required String message,
    String? groupName,
  }) = _JoinGroupResultEntity;
}
