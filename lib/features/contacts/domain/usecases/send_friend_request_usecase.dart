import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/contacts/domain/entities/friend_request.dart';
import 'package:chattrix_ui/features/contacts/domain/repositories/contact_repository.dart';
import 'package:dartz/dartz.dart';

class SendFriendRequestUseCase {
  final ContactRepository repository;

  SendFriendRequestUseCase(this.repository);

  Future<Either<Failure, FriendRequest>> call({
    required int receiverUserId,
    String? nickname,
  }) {
    return repository.sendFriendRequest(
      receiverUserId: receiverUserId,
      nickname: nickname,
    );
  }
}

