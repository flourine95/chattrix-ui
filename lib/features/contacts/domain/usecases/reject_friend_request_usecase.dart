import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/contact_repository.dart';

class RejectFriendRequestUseCase {
  final ContactRepository repository;

  RejectFriendRequestUseCase(this.repository);

  Future<Either<Failure, void>> call({required int friendRequestId}) {
    return repository.rejectFriendRequest(friendRequestId: friendRequestId);
  }
}
