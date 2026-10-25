import 'package:flutter_core/core/constants/app_constants.dart';
import 'package:flutter_core/core/storage/local_preferences.dart';
import 'package:flutter_core/core/utils/app_toast.dart';
import 'package:flutter_core/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_core/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_core/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:flutter_core/routes/app_routes.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;

  AuthController({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.verifyOtpUseCase,
  });

  final isLoading = false.obs;
  final isOtpVerifying = false.obs;
  final pendingPhone = ''.obs;
  final pendingEmail = ''.obs;
  final otpError = ''.obs;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      AppToast.showLoading();

      final user = await loginUseCase(
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

      final user = await registerUseCase(
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

  Future<bool> verifyOtp(String code) async {
    try {
      isOtpVerifying.value = true;
      otpError.value = '';

      final isValid = await verifyOtpUseCase(
        code: code,
        email: pendingEmail.value,
      );

      if (!isValid) {
        otpError.value = 'Invalid OTP. Use ${AppConstants.demoOtp} for demo.';
        AppToast.error(otpError.value);
        return false;
      }

      final prefs = LocalPreferences.to;
      await prefs.saveToken('demo_token_${DateTime.now().millisecondsSinceEpoch}');
      await prefs.saveUser(
        id: prefs.userId.value.isNotEmpty ? prefs.userId.value : '1',
        fullName: prefs.name.value.isNotEmpty ? prefs.name.value : 'Demo User',
        userEmail: pendingEmail.value.isNotEmpty
            ? pendingEmail.value
            : 'demo@fluttercore.dev',
        userPhone: pendingPhone.value,
      );

      AppToast.success('success'.tr);
      Get.offAllNamed(AppRoutes.showcase);
      return true;
    } catch (e) {
      otpError.value = e.toString();
      AppToast.error(e.toString());
      return false;
    } finally {
      isOtpVerifying.value = false;
    }
  }

  void resendOtp() {
    otpError.value = '';
    AppToast.info('demo_otp_hint'.tr);
  }
}
