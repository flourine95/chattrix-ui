import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/chat/data/models/poll_model.dart';
import 'package:chattrix_ui/features/auth/data/models/user_dto.dart';

part 'poll_list_item_dto.freezed.dart';
part 'poll_list_item_dto.g.dart';

/// DTO for poll item from list polls API
/// API structure is different from PollModel
@freezed
abstract class PollListItemDto with _$PollListItemDto {
  const PollListItemDto._();

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

  /// Convert PollListItemDto to PollModel
  PollModel toPollModel(int conversationId) {
    // Create UserDto for creator
    final creatorDto = UserDto(
      id: createdBy,
      username: createdByUsername,
      email: '', // Not available in list API
      emailVerified: false,
      fullName: createdByFullName ?? createdByUsername, // Use username as fallback
      avatarUrl: createdByAvatarUrl ?? '', // Empty string as fallback
      bio: null,
      gender: null,
      dateOfBirth: null,
      location: null,
      profileVisibility: 'public',
      lastSeen: null,
      createdAt: createdAt.toIso8601String(),
      updatedAt: createdAt.toIso8601String(),
    );

    // Convert options
    final pollOptions = options.map((opt) {
      // Convert voter IDs to UserDto list (minimal info)
      final voters = opt.voterIds.map((voterId) {
        return UserDto(
          id: voterId,
          username: 'User$voterId', // Placeholder username
          email: '',
          emailVerified: false,
          fullName: 'User$voterId', // Placeholder name
          avatarUrl: '', // Empty string
          bio: null,
          gender: null,
          dateOfBirth: null,
          location: null,
          profileVisibility: 'public',
          lastSeen: null,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        );
      }).toList();

      return PollOptionModel(
        id: opt.id,
        optionText: opt.text,
        optionOrder: options.indexOf(opt),
        voteCount: opt.voteCount,
        percentage: totalVotes > 0 ? (opt.voteCount / totalVotes * 100) : 0.0,
        voters: voters,
      );
    }).toList();

    // Get current user voted option IDs
    final currentUserVotedOptionIds = options
        .where((opt) => opt.hasVoted)
        .map((opt) => opt.id)
        .toList();

    return PollModel(
      id: messageId,
      question: question,
      conversationId: conversationId,
      creator: creatorDto,
      allowMultipleVotes: allowMultiple,
      expiresAt: expiresAt,
      closed: isClosed,
      expired: expiresAt != null && DateTime.now().isAfter(expiresAt!),
      active: !isClosed && (expiresAt == null || DateTime.now().isBefore(expiresAt!)),
      createdAt: createdAt,
      totalVoters: totalVotes,
      options: pollOptions,
      currentUserVotedOptionIds: currentUserVotedOptionIds,
    );
  }
}

@freezed
abstract class PollListOptionDto with _$PollListOptionDto {
  const PollListOptionDto._();

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
