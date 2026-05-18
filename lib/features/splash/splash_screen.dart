import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.initial);
    });

    return const Scaffold(
      body: Center(
        child: Text("Flutter Core"),
      ),
    );
  }
}