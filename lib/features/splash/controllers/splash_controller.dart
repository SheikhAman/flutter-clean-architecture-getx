import 'package:flutter_core/core/constants/app_constants.dart';
import 'package:flutter_core/core/storage/local_preferences.dart';
import 'package:flutter_core/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(AppConstants.splashDuration);

    final prefs = LocalPreferences.to;
    if (prefs.isLoggedIn.value) {
      Get.offAllNamed(AppRoutes.showcase);
    } else {
      Get.offAllNamed(AppRoutes.showcase);
    }
  }
}
