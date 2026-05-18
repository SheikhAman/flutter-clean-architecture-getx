import 'package:flutter/material.dart';
import 'package:flutter_core/features/auth/bindings/auth_binding.dart';
import 'package:flutter_core/features/auth/screens/login_screen.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.initial,
      page: () => const Placeholder(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
  ];
}