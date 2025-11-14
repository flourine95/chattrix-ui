import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/contacts/domain/entities/friend_request.dart';
import 'package:chattrix_ui/features/contacts/domain/repositories/contact_repository.dart';
import 'package:dartz/dartz.dart';

class GetReceivedFriendRequestsUseCase {
  final ContactRepository repository;

  GetReceivedFriendRequestsUseCase(this.repository);

  Future<Either<Failure, List<FriendRequest>>> call() {
    return repository.getReceivedFriendRequests();
  }
}

