import 'package:chattrix_ui/features/chat/domain/entities/mentioned_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mentioned_user_model.freezed.dart';

@freezed
abstract class MentionedUserModel with _$MentionedUserModel {
  const MentionedUserModel._();

  const factory MentionedUserModel({required int userId, required String username, required String fullName}) =
      _MentionedUserModel;

  factory MentionedUserModel.fromJson(Map<String, dynamic> json) {
    // Handle null userId from backend (shouldn't happen but does)
    final userId = json['userId'];
    if (userId == null) {
      // Skip this mentioned user if userId is null
      throw FormatException('userId cannot be null in MentionedUserModel');
    }
    return MentionedUserModel(
      userId: userId as int,
      username: json['username'] as String,
      fullName: json['fullName'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'userId': userId, 'username': username, 'fullName': fullName};

  MentionedUser toEntity() {
    return MentionedUser(userId: userId, username: username, fullName: fullName);
  }
}
