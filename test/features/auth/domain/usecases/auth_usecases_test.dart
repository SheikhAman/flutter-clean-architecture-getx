import 'package:flutter_core/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_core/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:flutter_core/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_core/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_core/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeAuthRepository implements IAuthRepository {
  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    if (password == 'wrong') {
      throw Exception('Invalid credentials');
    }
    return UserEntity(
      id: 'user_1',
      name: 'Test User',
      email: email,
      phone: '+123456789',
    );
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    return UserEntity(
      id: 'user_2',
      name: name,
      email: email,
      phone: phone,
    );
  }

  @override
  Future<bool> verifyOtp({
    required String code,
    String? email,
  }) async {
    return code == '112345';
  }
}

void main() {
  late FakeAuthRepository repository;
  late LoginUseCase loginUseCase;
  late RegisterUseCase registerUseCase;
  late VerifyOtpUseCase verifyOtpUseCase;

  setUp(() {
    repository = FakeAuthRepository();
    loginUseCase = LoginUseCase(repository);
    registerUseCase = RegisterUseCase(repository);
    verifyOtpUseCase = VerifyOtpUseCase(repository);
  });

  group('Auth UseCases Unit Tests', () {
    test('LoginUseCase returns UserEntity on successful login', () async {
      final user = await loginUseCase(
        email: 'dev@fluttercore.com',
        password: 'password',
      );

      expect(user.id, 'user_1');
      expect(user.email, 'dev@fluttercore.com');
      expect(user.name, 'Test User');
    });

    test('LoginUseCase throws on wrong credentials', () async {
      expect(
        () => loginUseCase(email: 'dev@fluttercore.com', password: 'wrong'),
        throwsA(isA<Exception>()),
      );
    });

    test('RegisterUseCase creates and returns new UserEntity', () async {
      final user = await registerUseCase(
        name: 'Jane Doe',
        email: 'jane@fluttercore.com',
        phone: '+987654321',
        password: 'securePassword',
      );

      expect(user.id, 'user_2');
      expect(user.name, 'Jane Doe');
      expect(user.email, 'jane@fluttercore.com');
    });

    test('VerifyOtpUseCase validates code correctly', () async {
      final isValid = await verifyOtpUseCase(code: '112345');
      final isInvalid = await verifyOtpUseCase(code: '000000');

      expect(isValid, isTrue);
      expect(isInvalid, isFalse);
    });
  });
}
