import 'package:chattrix_ui/features/chat/domain/entities/search_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_user_model.freezed.dart';
part 'search_user_model.g.dart';

@freezed
abstract class SearchUserModel with _$SearchUserModel {
  const SearchUserModel._();

  const factory SearchUserModel({
    required int id,
    required String username,
    required String email,
    required String fullName,
    String? avatarUrl,
    @JsonKey(name: 'online') required bool isOnline,
    required String lastSeen,
    required bool contact,
    required bool hasConversation,
    int? conversationId,
  }) = _SearchUserModel;

  factory SearchUserModel.fromJson(Map<String, dynamic> json) =>
      _$SearchUserModelFromJson(json);

  SearchUser toEntity() {
    return SearchUser(
      id: id,
      username: username,
      email: email,
      fullName: fullName,
      avatarUrl: avatarUrl,
      isOnline: isOnline,
      lastSeen: DateTime.parse(lastSeen),
      contact: contact,
      hasConversation: hasConversation,
      conversationId: conversationId,
    );
  }
}

