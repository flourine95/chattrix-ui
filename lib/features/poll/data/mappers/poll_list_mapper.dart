import '../models/poll_list_item_dto.dart';
import '../../../chat/data/models/poll_model.dart';
import '../../../auth/data/models/user_dto.dart';

extension PollListItemMapper on PollListItemDto {
  PollModel toPollModel(int conversationId) {
    return PollModel(
      id: messageId,
      question: question,
      conversationId: conversationId,
      creator: UserDto(
        id: createdBy,
        username: createdByUsername,
        email: '', // Not provided by list API
        emailVerified: false, // Not provided by list API
        fullName: createdByFullName ?? createdByUsername, // Use fullName if available, fallback to username
        avatarUrl: createdByAvatarUrl, // Use avatarUrl from API
        createdAt: createdAt.toIso8601String(),
      ),
      allowMultipleVotes: allowMultiple,
      expiresAt: expiresAt,
      closed: isClosed,
      expired: expiresAt != null && DateTime.now().isAfter(expiresAt!),
      active: !isClosed && (expiresAt == null || DateTime.now().isBefore(expiresAt!)),
      createdAt: createdAt,
      totalVoters: totalVotes,
      options: options.asMap().entries.map((entry) {
        final index = entry.key;
        final option = entry.value;
        return PollOptionModel(
          id: option.id,
          optionText: option.text,
          optionOrder: index,
          voteCount: option.voteCount,
          percentage: totalVotes > 0 ? (option.voteCount / totalVotes * 100) : 0.0,
          voters: [], // Not provided by list API
        );
      }).toList(),
      currentUserVotedOptionIds: options
          .where((opt) => opt.hasVoted)
          .map((opt) => opt.id)
          .toList(),
    );
  }
}
