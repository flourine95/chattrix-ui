import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../entities/birthday.dart';
import '../entities/mutual_group.dart';
import '../entities/message.dart';

/// Repository interface for social features
/// Implementation: Data Layer
abstract class SocialRepository {
  /// Get birthdays today
  /// Returns [Right] with list of [Birthday] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<Birthday>>> getBirthdaysToday();

  /// Send birthday wishes
  Future<Either<Failure, SendBirthdayWishes>> sendBirthdayWishes({
    required int userId,
    required List<int> conversationIds,
    String? customMessage,
  });

  /// Create announcement
  Future<Either<Failure, Message>> createAnnouncement({required int conversationId, required String content});

  /// Get mutual groups with a user
  Future<Either<Failure, List<MutualGroup>>> getMutualGroups({required int userId});
}
