import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppToast {
  AppToast._();

  static void success(String message) {
    EasyLoading.showSuccess(message);
  }

  static void error(String message) {
    EasyLoading.showError(message);
  }

  static void info(String message) {
    EasyLoading.showInfo(message);
  }

  static void showLoading([String? message]) {
    EasyLoading.show(status: message);
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }
}
