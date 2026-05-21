import 'package:flutter_core/core/constants/app_constants.dart';
import 'package:flutter_core/core/storage/local_preferences.dart';
import 'package:flutter_core/core/utils/app_toast.dart';
import 'package:flutter_core/routes/app_routes.dart';
import 'package:get/get.dart';
import '../repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository repository;

  AuthController(this.repository);

  final isLoading = false.obs;
  final pendingPhone = ''.obs;
  final pendingEmail = ''.obs;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      AppToast.showLoading();

      final user = await repository.login(
        email: email,
        password: password,
      );

      pendingEmail.value = email;
      await LocalPreferences.to.saveUser(
        id: user.id,
        fullName: user.name,
        userEmail: user.email,
        userPhone: user.phone,
      );
      AppToast.dismiss();
      AppToast.info('demo_otp_hint'.tr);

      Get.toNamed(
        AppRoutes.otp,
        arguments: {'email': email, 'user': user},
      );
    } catch (e) {
      AppToast.dismiss();
      AppToast.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      AppToast.showLoading();

      final user = await repository.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );

      pendingPhone.value = phone;
      pendingEmail.value = email;
      await LocalPreferences.to.saveUser(
        id: user.id,
        fullName: user.name,
        userEmail: user.email,
        userPhone: user.phone,
      );
      AppToast.dismiss();
      AppToast.info('demo_otp_hint'.tr);

      Get.toNamed(
        AppRoutes.otp,
        arguments: {'email': email, 'phone': phone},
      );
    } catch (e) {
      AppToast.dismiss();
      AppToast.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp(String code) async {
    if (code.trim() != AppConstants.demoOtp) {
      AppToast.error('Invalid OTP. Use ${AppConstants.demoOtp} for demo.');
      return;
    }

    final prefs = LocalPreferences.to;
    await prefs.saveToken('demo_token_${DateTime.now().millisecondsSinceEpoch}');
    await prefs.saveUser(
      id: '1',
      fullName: prefs.name.value.isNotEmpty ? prefs.name.value : 'Demo User',
      userEmail: pendingEmail.value.isNotEmpty
          ? pendingEmail.value
          : 'demo@fluttercore.dev',
      userPhone: pendingPhone.value,
    );

    AppToast.success('success'.tr);
    Get.offAllNamed(AppRoutes.showcase);
  }

  void resendOtp() {
    AppToast.info('demo_otp_hint'.tr);
  }
}
