import '../entities/user_entity.dart';
import '../repositories/i_auth_repository.dart';

class LoginUseCase {
  final IAuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call({
    required String email,
    required String password,
  }) {
    return repository.login(email: email, password: password);
  }
}
