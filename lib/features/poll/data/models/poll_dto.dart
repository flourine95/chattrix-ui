import 'package:freezed_annotation/freezed_annotation.dart';
import 'poll_option_dto.dart';
import '../../../auth/data/models/user_dto.dart';

part 'poll_dto.freezed.dart';
part 'poll_dto.g.dart';

/// DTO for Poll API response
@freezed
abstract class PollDto with _$PollDto {
  const factory PollDto({
    required int id,
    required String question,
    required int conversationId,
    required UserDto creator,
    required bool allowMultipleVotes,
    DateTime? expiresAt,
    required bool isClosed,
    required bool isExpired,
    required bool isActive,
    required DateTime createdAt,
    required int totalVoters,
    required List<PollOptionDto> options,
    required List<int> currentUserVotedOptionIds,
  }) = _PollDto;

  factory PollDto.fromJson(Map<String, dynamic> json) => _$PollDtoFromJson(json);
}
