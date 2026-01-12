import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/friend_request.dart';
import '../repositories/contact_repository.dart';

class GetReceivedFriendRequestsUseCase {
  final ContactRepository repository;

  GetReceivedFriendRequestsUseCase(this.repository);

  Future<Either<Failure, List<FriendRequest>>> call() {
    return repository.getReceivedFriendRequests();
  }
}
