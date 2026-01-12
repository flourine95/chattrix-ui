import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/user_status_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetOnlineUsersUsecase {
  final UserStatusRepository repository;

  GetOnlineUsersUsecase(this.repository);

  Future<Either<Failure, List<User>>> call() {
    return repository.getOnlineUsers();
  }
}
