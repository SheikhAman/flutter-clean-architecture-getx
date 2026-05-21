import 'package:flutter_core/core/services/device_info_service.dart';
import 'package:flutter_core/network/api_service.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../repositories/auth_repository.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(
      () => AuthRepository(
        apiService: Get.find<ApiService>(),
        deviceInfo: Get.find<DeviceInfoService>(),
      ),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(Get.find<AuthRepository>()),
    );
  }
}
