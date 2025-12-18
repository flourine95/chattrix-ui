import 'package:chattrix_ui/features/chat/domain/entities/mentioned_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mentioned_user_model.freezed.dart';
part 'mentioned_user_model.g.dart';

@freezed
abstract class MentionedUserModel with _$MentionedUserModel {
  const MentionedUserModel._();

  const factory MentionedUserModel({required int userId, required String username, required String fullName}) =
      _MentionedUserModel;

  factory MentionedUserModel.fromJson(Map<String, dynamic> json) => _$MentionedUserModelFromJson(json);

  MentionedUser toEntity() {
    return MentionedUser(userId: userId, username: username, fullName: fullName);
  }
}
