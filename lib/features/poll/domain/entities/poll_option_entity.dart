import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../auth/domain/entities/user.dart';

part 'poll_option_entity.freezed.dart';

/// Poll option entity - framework agnostic
///
/// Represents a single voting option in a poll
@freezed
abstract class PollOptionEntity with _$PollOptionEntity {
  const factory PollOptionEntity({
    required int id,
    required String optionText,
    required int optionOrder,
    required int voteCount,
    required double percentage,
    required List<User> voters,
  }) = _PollOptionEntity;

  const PollOptionEntity._();

  /// Check if a specific user has voted for this option
  bool hasUserVoted(int userId) {
    return voters.any((voter) => voter.id == userId);
  }

  /// Get voter names as comma-separated string
  String get voterNames {
    if (voters.isEmpty) return '';
    return voters.map((v) => v.fullName).join(', ');
  }
}
