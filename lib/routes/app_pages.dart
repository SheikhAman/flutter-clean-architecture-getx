import 'package:flutter_core/features/auth/bindings/auth_binding.dart';
import 'package:flutter_core/features/auth/screens/login_screen.dart';
import 'package:flutter_core/features/splash/bindings/splash_binding.dart';
import 'package:flutter_core/features/splash/screens/splash_screen.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {

  static final routes = [

    /// =========================
    /// SPLASH
    /// =========================
    GetPage(
      name: AppRoutes.initial,

      page: () => const SplashScreen(),

      binding: SplashBinding(),

      transition: Transition.fadeIn,

      transitionDuration: const Duration(
        milliseconds: 300,
      ),
    ),

    /// =========================
    /// LOGIN
    /// =========================
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: AuthBinding(),

      transition: Transition.rightToLeft,

      transitionDuration: const Duration(
        milliseconds: 300,
      ),
    ),
  ];
}