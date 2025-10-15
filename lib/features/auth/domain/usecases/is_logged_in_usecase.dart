import '../repositories/auth_repository.dart';

/// UseCase để kiểm tra trạng thái đăng nhập
class IsLoggedInUseCase {
  final AuthRepository repository;

  IsLoggedInUseCase(this.repository);

  Future<bool> call() async {
    return await repository.isLoggedIn();
  }
}
