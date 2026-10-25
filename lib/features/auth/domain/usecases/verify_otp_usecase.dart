import '../repositories/i_auth_repository.dart';

class VerifyOtpUseCase {
  final IAuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<bool> call({
    required String code,
    String? email,
  }) {
    return repository.verifyOtp(code: code, email: email);
  }
}
