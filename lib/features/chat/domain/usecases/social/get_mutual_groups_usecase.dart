import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/mutual_group.dart';
import '../../repositories/social_repository.dart';

/// Use case for getting mutual groups with a user
class GetMutualGroupsUseCase {
  final SocialRepository _repository;

  GetMutualGroupsUseCase(this._repository);

  Future<Either<Failure, List<MutualGroup>>> call({required int userId}) async {
    return await _repository.getMutualGroups(userId: userId);
  }
}
