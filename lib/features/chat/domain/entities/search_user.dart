import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_user.freezed.dart';

@freezed
abstract class SearchUser with _$SearchUser {
  const factory SearchUser({
    required int id,
    required String username,
    required String email,
    required String fullName,
    String? avatarUrl,
    required bool isOnline,
    required DateTime lastSeen,
    required bool contact,
    required bool hasConversation,
    int? conversationId,
  }) = _SearchUser;
}
