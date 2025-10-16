import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/user_status.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/user_status_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserStatusUsecase {
  final UserStatusRepository repository;

  GetUserStatusUsecase(this.repository);

  Future<Either<Failure, UserStatus>> call(String userId) {
    return repository.getUserStatus(userId);
  }
}
