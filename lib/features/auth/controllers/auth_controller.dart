import 'package:get/get.dart';
import '../../../core/utils/loading.dart';
import '../../../core/utils/app_snackbar.dart';
import '../repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository repository;

  AuthController(this.repository);

  final isLoading = false.obs;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      Loading.show();

      await repository.login(
        email: email,
        password: password,
      );

      AppSnackbar.success("Login successful");
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isLoading.value = false;
      Loading.hide();
    }
  }
}