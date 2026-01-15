import 'package:freezed_annotation/freezed_annotation.dart';

part 'poll_list_item_dto.freezed.dart';
part 'poll_list_item_dto.g.dart';

/// DTO for poll item from list polls API
/// API structure is different from PollModel
@freezed
abstract class PollListItemDto with _$PollListItemDto {
  const factory PollListItemDto({
    required int messageId,
    required String question,
    required List<PollListOptionDto> options,
    required bool allowMultiple,
    required bool anonymous,
    required bool isClosed,
    required int totalVotes,
    required int createdBy,
    required String createdByUsername,
    String? createdByFullName,
    String? createdByAvatarUrl,
    required DateTime createdAt,
    DateTime? expiresAt,
  }) = _PollListItemDto;

  factory PollListItemDto.fromJson(Map<String, dynamic> json) =>
      _$PollListItemDtoFromJson(json);
}

@freezed
abstract class PollListOptionDto with _$PollListOptionDto {
  const factory PollListOptionDto({
    required int id,
    required String text,
    required int voteCount,
    required List<int> voterIds,
    required bool hasVoted,
  }) = _PollListOptionDto;

  factory PollListOptionDto.fromJson(Map<String, dynamic> json) =>
      _$PollListOptionDtoFromJson(json);
}
