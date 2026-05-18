import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;

  void toggleTheme() {
    isDark.value = !isDark.value;
    Get.changeTheme(isDark.value ? ThemeData.dark() : ThemeData.light());
  }
}