import '../entities/user_entity.dart';

abstract class IAuthRepository {
  Future<UserEntity> login({
    required String email,
    required String password,
  });

  Future<UserEntity> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  });

  Future<bool> verifyOtp({
    required String code,
    String? email,
  });
}
