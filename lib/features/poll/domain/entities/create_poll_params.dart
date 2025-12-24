import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_poll_params.freezed.dart';

/// Parameters for creating a poll
@freezed
abstract class CreatePollParams with _$CreatePollParams {
  const factory CreatePollParams({
    required int conversationId,
    required String question,
    required List<String> options,
    required bool allowMultipleVotes,
    DateTime? expiresAt,
  }) = _CreatePollParams;

  const CreatePollParams._();

  /// Validate parameters
  String? validate() {
    if (question.trim().isEmpty) {
      return 'Question cannot be empty';
    }
    if (question.length > 500) {
      return 'Question must be 500 characters or less';
    }
    if (options.length < 2) {
      return 'Poll must have at least 2 options';
    }
    if (options.length > 10) {
      return 'Poll cannot have more than 10 options';
    }
    for (var option in options) {
      if (option.trim().isEmpty) {
        return 'Options cannot be empty';
      }
      if (option.length > 200) {
        return 'Each option must be 200 characters or less';
      }
    }
    return null;
  }
}
