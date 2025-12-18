import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/friend_request.dart';
import '../repositories/contact_repository.dart';

class SendFriendRequestUseCase {
  final ContactRepository repository;

  SendFriendRequestUseCase(this.repository);

  Future<Either<Failure, FriendRequest>> call({required int receiverUserId, String? nickname}) {
    return repository.sendFriendRequest(receiverUserId: receiverUserId, nickname: nickname);
  }
}
