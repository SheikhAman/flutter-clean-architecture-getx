import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../repositories/auth_repository.dart';
import '../../../network/api_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(
          () => AuthRepository(Get.find<ApiService>()),
    );

    Get.lazyPut<AuthController>(
          () => AuthController(Get.find<AuthRepository>()),
    );
  }
}