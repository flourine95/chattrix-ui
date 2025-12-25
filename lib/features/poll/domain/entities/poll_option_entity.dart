import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'poll_option_entity.freezed.dart';

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

  bool hasUserVoted(int userId) {
    return voters.any((voter) => voter.id == userId);
  }

  String get voterNames {
    if (voters.isEmpty) return '';
    return voters.map((v) => v.fullName).join(', ');
  }
}
