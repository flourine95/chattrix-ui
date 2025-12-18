import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/contact_repository.dart';

class CancelFriendRequestUseCase {
  final ContactRepository repository;

  CancelFriendRequestUseCase(this.repository);

  Future<Either<Failure, void>> call({required int friendRequestId}) {
    return repository.cancelFriendRequest(friendRequestId: friendRequestId);
  }
}
