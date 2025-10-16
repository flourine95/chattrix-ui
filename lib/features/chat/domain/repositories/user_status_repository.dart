import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/features/chat/domain/entities/user_status.dart';
import 'package:dartz/dartz.dart';

abstract class UserStatusRepository {
  /// Get all online users
  Future<Either<Failure, List<User>>> getOnlineUsers();

  /// Get online users in a conversation
  Future<Either<Failure, List<User>>> getOnlineUsersInConversation(
    String conversationId,
  );

  /// Get user status
  Future<Either<Failure, UserStatus>> getUserStatus(String userId);
}
