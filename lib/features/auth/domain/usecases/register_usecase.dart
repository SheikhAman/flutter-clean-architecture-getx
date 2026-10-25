import '../entities/user_entity.dart';
import '../repositories/i_auth_repository.dart';

class RegisterUseCase {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  Future<UserEntity> call({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    return repository.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );
  }
}
