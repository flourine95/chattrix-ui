import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite_link_model.freezed.dart';
part 'invite_link_model.g.dart';

@freezed
abstract class InviteLinkModel with _$InviteLinkModel {
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
}

@freezed
abstract class JoinViaInviteLinkResponse with _$JoinViaInviteLinkResponse {
  const factory JoinViaInviteLinkResponse({
    required bool success,
    required int conversationId,
    required String message,
  }) = _JoinViaInviteLinkResponse;

  factory JoinViaInviteLinkResponse.fromJson(Map<String, dynamic> json) =>
      _$JoinViaInviteLinkResponseFromJson(json);
}

