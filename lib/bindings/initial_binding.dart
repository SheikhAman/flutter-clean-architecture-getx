import 'package:flutter_core/bindings/network_binding.dart';
import 'package:flutter_core/features/auth/bindings/auth_binding.dart';
import 'package:flutter_core/features/splash/bindings/splash_binding.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {

  @override
  void dependencies() {

    /// =========================
    /// CORE
    /// =========================
    NetworkBinding().dependencies();

    /// =========================
    /// FEATURE BINDINGS
    /// =========================
    SplashBinding().dependencies();

    AuthBinding().dependencies();
  }
}