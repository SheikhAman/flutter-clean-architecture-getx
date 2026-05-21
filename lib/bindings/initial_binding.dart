import 'package:flutter_core/bindings/network_binding.dart';
import 'package:flutter_core/features/auth/bindings/auth_binding.dart';
import 'package:flutter_core/features/showcase/bindings/showcase_binding.dart';
import 'package:flutter_core/features/splash/bindings/splash_binding.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    NetworkBinding().dependencies();
    SplashBinding().dependencies();
    ShowcaseBinding().dependencies();
    AuthBinding().dependencies();
  }
}
