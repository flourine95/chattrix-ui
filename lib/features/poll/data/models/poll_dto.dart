import 'package:chattrix_ui/features/auth/data/models/user_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'poll_option_dto.dart';

part 'poll_dto.freezed.dart';
part 'poll_dto.g.dart';

@freezed
abstract class PollDto with _$PollDto {
  const factory PollDto({
    required int id,
    required String question,
    required int conversationId,
    required UserDto creator,
    required bool allowMultipleVotes,
    DateTime? expiresAt,
    @JsonKey(name: 'closed') @Default(false) bool isClosed,
    @JsonKey(name: 'expired') @Default(false) bool isExpired,
    @JsonKey(name: 'active') @Default(true) bool isActive,
    required DateTime createdAt,
    required int totalVoters,
    required List<PollOptionDto> options,
    required List<int> currentUserVotedOptionIds,
  }) = _PollDto;

  factory PollDto.fromJson(Map<String, dynamic> json) => _$PollDtoFromJson(json);
}
