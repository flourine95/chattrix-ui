import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'typing_indicator_model.freezed.dart';
part 'typing_indicator_model.g.dart';

@freezed
abstract class TypingIndicatorModel with _$TypingIndicatorModel {
  const TypingIndicatorModel._();

  const factory TypingIndicatorModel({
    required int conversationId,
    required List<TypingUserModel> typingUsers,
  }) = _TypingIndicatorModel;

  factory TypingIndicatorModel.fromJson(Map<String, dynamic> json) => _$TypingIndicatorModelFromJson(json);

  TypingIndicator toEntity() {
    return TypingIndicator(
      conversationId: conversationId,
      typingUsers: typingUsers.map((user) => user.toEntity()).toList(),
    );
  }
}

@freezed
abstract class TypingUserModel with _$TypingUserModel {
  const TypingUserModel._();

  const factory TypingUserModel({
    @JsonKey(name: 'userId') required int id,
    required String username,
    required String fullName,
  }) = _TypingUserModel;

  factory TypingUserModel.fromJson(Map<String, dynamic> json) => _$TypingUserModelFromJson(json);

  TypingUser toEntity() {
    return TypingUser(id: id, username: username, fullName: fullName);
  }
}

