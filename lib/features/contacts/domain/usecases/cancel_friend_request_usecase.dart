import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/contacts/domain/repositories/contact_repository.dart';
import 'package:dartz/dartz.dart';

class CancelFriendRequestUseCase {
  final ContactRepository repository;

  CancelFriendRequestUseCase(this.repository);

  Future<Either<Failure, void>> call({required int friendRequestId}) {
    return repository.cancelFriendRequest(friendRequestId: friendRequestId);
  }
}
