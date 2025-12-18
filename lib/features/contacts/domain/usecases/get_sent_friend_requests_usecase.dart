import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/friend_request.dart';
import '../repositories/contact_repository.dart';

class GetSentFriendRequestsUseCase {
  final ContactRepository repository;

  GetSentFriendRequestsUseCase(this.repository);

  Future<Either<Failure, List<FriendRequest>>> call() {
    return repository.getSentFriendRequests();
  }
}
