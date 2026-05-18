import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AppSnackbar {
  static success(String message) {
    Get.snackbar(
      "Success",
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  static error(String message) {
    Get.snackbar(
      "Error",
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  static info(String message) {
    Get.snackbar(
      "Info",
      message,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }
}