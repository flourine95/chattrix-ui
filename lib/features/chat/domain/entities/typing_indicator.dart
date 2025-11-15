import 'package:freezed_annotation/freezed_annotation.dart';

part 'typing_indicator.freezed.dart';

/// Entity representing a typing indicator in a conversation
@freezed
abstract class TypingIndicator with _$TypingIndicator {
  const TypingIndicator._();

  const factory TypingIndicator({required String conversationId, required List<TypingUser> typingUsers}) =
      _TypingIndicator;
}

/// Entity representing a user who is typing
@freezed
abstract class TypingUser with _$TypingUser {
  const TypingUser._();

  const factory TypingUser({required String id, required String username, required String fullName}) = _TypingUser;
}
