import 'package:flutter_core/core/services/device_info_service.dart';
import 'package:flutter_core/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:flutter_core/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_core/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_core/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:flutter_core/network/api_service.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../repositories/auth_repository.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IAuthRepository>(
      () => AuthRepository(
        apiService: Get.find<ApiService>(),
        deviceInfo: Get.find<DeviceInfoService>(),
      ),
      fenix: true,
    );

    Get.lazyPut<LoginUseCase>(
      () => LoginUseCase(Get.find<IAuthRepository>()),
      fenix: true,
    );

    Get.lazyPut<RegisterUseCase>(
      () => RegisterUseCase(Get.find<IAuthRepository>()),
      fenix: true,
    );

    Get.lazyPut<VerifyOtpUseCase>(
      () => VerifyOtpUseCase(Get.find<IAuthRepository>()),
      fenix: true,
    );

    Get.lazyPut<AuthController>(
      () => AuthController(
        loginUseCase: Get.find<LoginUseCase>(),
        registerUseCase: Get.find<RegisterUseCase>(),
        verifyOtpUseCase: Get.find<VerifyOtpUseCase>(),
      ),
      fenix: true,
    );
  }
}
