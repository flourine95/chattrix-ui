import 'package:freezed_annotation/freezed_annotation.dart';

part 'mentioned_user.freezed.dart';

@freezed
abstract class MentionedUser with _$MentionedUser {
  const factory MentionedUser({
    required int userId,
    required String username,
    required String fullName,
  }) = _MentionedUser;
}

