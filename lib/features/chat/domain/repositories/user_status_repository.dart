import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/features/chat/domain/entities/user_status.dart';
import 'package:fpdart/fpdart.dart';

abstract class UserStatusRepository {
  Future<Either<Failure, List<User>>> getOnlineUsers();

  Future<Either<Failure, List<User>>> getOnlineUsersInConversation(int conversationId);

  Future<Either<Failure, UserStatus>> getUserStatus(int userId);
}
