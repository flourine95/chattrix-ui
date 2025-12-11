import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'typing_indicator_model.freezed.dart';
part 'typing_indicator_model.g.dart';

/// Model for typing indicator (extends entity)
@freezed
abstract class TypingIndicatorModel with _$TypingIndicatorModel {
  const TypingIndicatorModel._();

  const factory TypingIndicatorModel({
    @JsonKey(fromJson: _conversationIdFromJson) required String conversationId,
    required List<TypingUserModel> typingUsers,
  }) = _TypingIndicatorModel;

  /// Convert from JSON
  factory TypingIndicatorModel.fromJson(Map<String, dynamic> json) => _$TypingIndicatorModelFromJson(json);

  /// Convert to entity
  TypingIndicator toEntity() {
    return TypingIndicator(
      conversationId: conversationId,
      typingUsers: typingUsers.map((user) => user.toEntity()).toList(),
    );
  }
}

/// Convert conversationId from int or String to String
String _conversationIdFromJson(dynamic value) {
  if (value is int) return value.toString();
  if (value is String) return value;
  throw FormatException('Invalid conversationId format: $value');
}

/// Model for typing user (extends entity)
@freezed
abstract class TypingUserModel with _$TypingUserModel {
  const TypingUserModel._();

  const factory TypingUserModel({
    @JsonKey(name: 'userId', fromJson: _userIdFromJson) required String id,
    required String username,
    required String fullName,
  }) = _TypingUserModel;

  /// Convert from JSON
  factory TypingUserModel.fromJson(Map<String, dynamic> json) => _$TypingUserModelFromJson(json);

  /// Convert to entity
  TypingUser toEntity() {
    return TypingUser(id: id, username: username, fullName: fullName);
  }
}

/// Convert user id from int or String to String
String _userIdFromJson(dynamic value) {
  if (value == null) throw FormatException('userId cannot be null');
  if (value is int) return value.toString();
  if (value is String) return value;
  throw FormatException('Invalid user id format: $value');
}

