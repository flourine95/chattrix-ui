import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/contact_repository.dart';

class AcceptFriendRequestUseCase {
  final ContactRepository repository;

  AcceptFriendRequestUseCase(this.repository);

  Future<Either<Failure, void>> call({required int friendRequestId}) {
    return repository.acceptFriendRequest(friendRequestId: friendRequestId);
  }
}
