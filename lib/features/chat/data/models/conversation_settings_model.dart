import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_settings_model.freezed.dart';
part 'conversation_settings_model.g.dart';

@freezed
abstract class ConversationSettingsModel with _$ConversationSettingsModel {
  const factory ConversationSettingsModel({
    required int conversationId,
    @Default(false) bool muted,
    @Default(false) bool blocked,
    @Default(true) bool notificationsEnabled,
    @Default(false) bool pinned,
    int? pinOrder,
    @Default(false) bool archived,
    @Default(false) bool hidden,
    String? customNickname,
    String? theme,
  }) = _ConversationSettingsModel;

  factory ConversationSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationSettingsModelFromJson(json);
}

@freezed
abstract class UpdateConversationSettingsRequest with _$UpdateConversationSettingsRequest {
  const factory UpdateConversationSettingsRequest({
    bool? notificationsEnabled,
    String? customNickname,
    String? theme,
  }) = _UpdateConversationSettingsRequest;

  factory UpdateConversationSettingsRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateConversationSettingsRequestFromJson(json);
}

@freezed
abstract class ConversationPermissionsModel with _$ConversationPermissionsModel {
  const factory ConversationPermissionsModel({
    required int conversationId,
    @Default('ALL') String sendMessages,
    @Default('ADMIN_ONLY') String addMembers,
    @Default('ADMIN_ONLY') String removeMembers,
    @Default('ADMIN_ONLY') String editGroupInfo,
    @Default('ADMIN_ONLY') String pinMessages,
    @Default('ADMIN_ONLY') String deleteMessages,
    @Default('ALL') String createPolls,
  }) = _ConversationPermissionsModel;

  factory ConversationPermissionsModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationPermissionsModelFromJson(json);
}

@freezed
abstract class UpdateConversationPermissionsRequest with _$UpdateConversationPermissionsRequest {
  const factory UpdateConversationPermissionsRequest({
    String? sendMessages,
    String? addMembers,
    String? removeMembers,
    String? editGroupInfo,
    String? pinMessages,
    String? deleteMessages,
    String? createPolls,
  }) = _UpdateConversationPermissionsRequest;

  factory UpdateConversationPermissionsRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateConversationPermissionsRequestFromJson(json);
}

@freezed
abstract class MuteMemberRequest with _$MuteMemberRequest {
  const factory MuteMemberRequest({
    required int duration,
  }) = _MuteMemberRequest;

  factory MuteMemberRequest.fromJson(Map<String, dynamic> json) =>
      _$MuteMemberRequestFromJson(json);
}

@freezed
abstract class MutedMemberModel with _$MutedMemberModel {
  const factory MutedMemberModel({
    required int userId,
    required String username,
    required String fullName,
    required bool muted,
    DateTime? mutedUntil,
    DateTime? mutedAt,
    int? mutedBy,
  }) = _MutedMemberModel;

  factory MutedMemberModel.fromJson(Map<String, dynamic> json) =>
      _$MutedMemberModelFromJson(json);
}

