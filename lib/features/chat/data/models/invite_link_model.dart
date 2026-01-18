import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/chat/domain/entities/invite_link.dart';

part 'invite_link_model.freezed.dart';
part 'invite_link_model.g.dart';

@freezed
abstract class InviteLinkModel with _$InviteLinkModel {
  const InviteLinkModel._();

  const factory InviteLinkModel({
    required int id,
    required String token,
    required int conversationId,
    required int createdBy,
    required String createdByUsername,
    required DateTime createdAt,
    int? maxUses,
    @Default(0) int currentUses,
    @Default(false) bool revoked,
    DateTime? revokedAt,
    int? revokedBy,
    @Default(true) bool valid,
  }) = _InviteLinkModel;

  factory InviteLinkModel.fromJson(Map<String, dynamic> json) =>
      _$InviteLinkModelFromJson(json);

  InviteLink toEntity() {
    return InviteLink(
      id: id,
      token: token,
      conversationId: conversationId,
      createdBy: createdBy,
      createdByUsername: createdByUsername,
      createdAt: createdAt,
      maxUses: maxUses,
      currentUses: currentUses,
      revoked: revoked,
      revokedAt: revokedAt,
      revokedBy: revokedBy,
      valid: valid,
    );
  }
}

@freezed
abstract class CreateInviteLinkRequest with _$CreateInviteLinkRequest {
  const factory CreateInviteLinkRequest({
    int? expiresInDays,
    int? maxUses,
  }) = _CreateInviteLinkRequest;

  factory CreateInviteLinkRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateInviteLinkRequestFromJson(json);
}

@freezed
abstract class InviteLinkInfoModel with _$InviteLinkInfoModel {
  const InviteLinkInfoModel._();

  const factory InviteLinkInfoModel({
    required String token,
    required int groupId,
    required int memberCount,
    required bool valid,
    required int createdBy,
    required String createdByUsername,
    required String createdByFullName,
  }) = _InviteLinkInfoModel;

  factory InviteLinkInfoModel.fromJson(Map<String, dynamic> json) =>
      _$InviteLinkInfoModelFromJson(json);

  InviteLinkInfo toEntity() {
    return InviteLinkInfo(
      token: token,
      groupId: groupId,
      memberCount: memberCount,
      valid: valid,
      createdBy: createdBy,
      createdByUsername: createdByUsername,
      createdByFullName: createdByFullName,
    );
  }
}

@freezed
abstract class JoinViaInviteLinkResponse with _$JoinViaInviteLinkResponse {
  const JoinViaInviteLinkResponse._();

  const factory JoinViaInviteLinkResponse({
    required bool success,
    required int conversationId,
    required String message,
  }) = _JoinViaInviteLinkResponse;

  factory JoinViaInviteLinkResponse.fromJson(Map<String, dynamic> json) =>
      _$JoinViaInviteLinkResponseFromJson(json);

  JoinViaInviteLink toEntity() {
    return JoinViaInviteLink(
      success: success,
      conversationId: conversationId,
      message: message,
    );
  }
}

