import 'package:flutter_core/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();

    navigate();
  }

  Future<void> navigate() async {

    await Future.delayed(
      const Duration(seconds: 2),
    );

    Get.offAllNamed(
      AppRoutes.login,
    );
  }
}