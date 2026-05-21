import 'package:flutter_core/core/utils/app_toast.dart';

/// Legacy alias — prefer [AppToast].
class AppSnackbar {
  static void success(String message) => AppToast.success(message);
  static void error(String message) => AppToast.error(message);
  static void info(String message) => AppToast.info(message);
}
