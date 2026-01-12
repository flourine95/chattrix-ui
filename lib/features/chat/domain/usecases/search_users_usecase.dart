import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/search_user.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class SearchUsersUsecase {
  final ChatRepository repository;

  SearchUsersUsecase(this.repository);

  Future<Either<Failure, List<SearchUser>>> call({required String query, int limit = 20}) {
    return repository.searchUsers(query: query, limit: limit);
  }
}
